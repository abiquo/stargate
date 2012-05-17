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
        zone = Zone.find(dc.id_zone)

        @instances = ec2.run_instances(:image_id => template.idRemote, :max_count => dc.hosts, :instance_type => "m1.large", :availability_zone  => zone.zoneId)
        @instances.instancesSet.item.each do |instance|
          i = Instance.new()
          while (i.ipAddress.nil?) do
            instance_desc = ec2.describe_instances(:instance_id => instance.instanceId).reservationSet.item[0].instancesSet.item[0]
            i = Instance.new(instance_desc)
          end
          i = infrastructure.instances.new(instance_desc)
          i.node_type = 'KVM'
          i.save

          ec2.create_tags(:resource_id => instance.instanceId, :tag => [{'Name' => dc.name + "-KVM"}])
        end
      end
      #{"instanceId"=>"i-2f046249", "imageId"=>"ami-a113c4c8", "instanceState"=>{"code"=>"0", "name"=>"pending"}, "privateDnsName"=>nil, "dnsName"=>nil, "reason"=>nil, "amiLaunchIndex"=>"0", "productCodes"=>nil, "instanceType"=>"m1.large", "launchTime"=>"2012-05-16T21:02:17.000Z", "placement"=>{"availabilityZone"=>"us-east-1a", "groupName"=>nil}, "kernelId"=>"aki-825ea7eb", "monitoring"=>{"state"=>"disabled"}, "stateReason"=>{"code"=>"pending", "message"=>"pending"}, "architecture"=>"x86_64", "rootDeviceType"=>"ebs", "rootDeviceName"=>"/dev/sda1", "blockDeviceMapping"=>nil, "virtualizationType"=>"paravirtual", "clientToken"=>nil}
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
            
      @instances = infrastructure.instances.find(:all)
      @instances.each do |i|
        ec2.terminate_instances(:instance_id => i.instanceId)
        i.destroy
      end
    
      infrastructure.deployed = false
      infrastructure.save
      
      respond_to do |format|
        format.html { redirect_to admin_infrastructure_path(infrastructure) }
        format.json { head :ok }
      end 
    end
    
    def get_it
      infrastructure = Infrastructure.find(params[:id])
      @instances = infrastructure.instances

      respond_to do |format|
        format.html # index.html.erb
        format.xml { render xml: @instances }
        format.json { render json: @instances }
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
      f.input :infrastructure_type, :label => 'Type', :as => :select, :collection => ["AWS"], :selected => "AWS"
      f.input :id_zone, :label => 'Zone', :as => :select, :collection => Zone.find(:all)
      
      f.has_many :datacenters do |datacenter_form|
        datacenter_form.input :name
        datacenter_form.input :hosts
        datacenter_form.input :id_zone, :label => 'Zone', :as => :select, :collection => Zone.find(:all)
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