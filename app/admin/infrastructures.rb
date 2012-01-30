ActiveAdmin.register Infrastructure do
  controller do
    def deploy   
      @conf = Preference.find(:all)
    
      configuration = Hash.new()
      @conf.each do |p|
        configuration[p.option] = p.value
      end
      ec2 = AWS::EC2::Base.new(:access_key_id => configuration['ACCESS_KEY_ID'], :secret_access_key => configuration['SECRET_ACCESS_KEY'])
    
      infrastructure = Infrastructure.find(params[:id])
      
      infrastructure.datacenters.each do |dc|
        template = Template.find(dc.id_template_rs)
        @instances = ec2.run_instances(:image_id => template.idRemote, :max_count => dc.hosts, :instance_type => "m1.large")
        @instances.instancesSet.item.each do |instance|
          ec2.create_tags(:resource_id => instance.instanceId, :tag => [{'Name' => dc.name}])
        end
      end
      
      infrastructure.deployed = true
      infrastructure.save
      
      respond_to do |format|
        format.html { redirect_to admin_infrastructure_path(infrastructure) }
        format.json { head :ok }
      end 
    end
    def undeploy   
      @conf = Preference.find(:all)
    
      configuration = Hash.new()
      @conf.each do |p|
        configuration[p.option] = p.value
      end
      ec2 = AWS::EC2::Base.new(:access_key_id => configuration['ACCESS_KEY_ID'], :secret_access_key => configuration['SECRET_ACCESS_KEY'])
      
      infrastructure = Infrastructure.find(params[:id])
      
      i = Array.new
      ec2.describe_instances().reservationSet.item.each do |instance|
        instance.instancesSet.item.each do |instance_item|
          i << instance_item.instanceId
        end
      end
      ec2.terminate_instances(:instance_id => i)
    
      infrastructure.deployed = false
      infrastructure.save
      
      respond_to do |format|
        format.html { redirect_to admin_infrastructure_path(infrastructure) }
        format.json { head :ok }
      end 
    end
  end

  action_item :only => :show do
    if infrastructure.deployed == false
      link_to("Deploy", :action => 'deploy')
    else
      link_to("Undeploy", :action => 'undeploy')
    end
  end
  
  index do
    column :name do |infrastructure|
      link_to infrastructure.name, admin_infrastructure_path(infrastructure)
    end
    column :infrastructure_type
    column :deployed do |infrastructure|
      status_tag (infrastructure.deployed ? "Deployed" : "Undeployed"), (infrastructure.deployed ? :ok : :error) 
    end

    default_actions
  end
  
  show :title => :name do
    panel "Datacenters" do
      table_for infrastructure.datacenters do |t|
        t.column :name
        t.column :hosts
      end
    end    
  end
  
  form do |f|
    f.inputs "Infrastructure details" do
      f.input :name
      f.input :infrastructure_type, :as => :select, :collection => ["AWS"], :selected => "AWS"
      
      f.has_many :datacenters do |datacenter_form|
        datacenter_form.input :name
        datacenter_form.input :hosts
        datacenter_form.input :id_template_server, :label => "Server template", :as => :select, :collection => Template.find(:all)
        datacenter_form.input :id_template_rs, :label => "RS template", :as => :select, :collection => Template.find(:all)
        datacenter_form.input :id_template_node, :label => "Node template", :as => :select, :collection => Template.find(:all)
        
        datacenter_form.input :_destroy, :as=>:boolean, :required => false, :label=>'Remove'
      end
    end
    f.buttons
  end
  filter  :name
end