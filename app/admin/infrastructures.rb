ActiveAdmin.register Infrastructure do
  index do
    column :name do |infrastructure|
      link_to infrastructure.name, admin_infrastructure_path(infrastructure)
    end
    column :infrastructure_type

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
      end
    end
    f.buttons
  end
end