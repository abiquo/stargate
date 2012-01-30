ActiveAdmin.register Preference do
  menu :priority => 99
  
  config.comments = false
  
  index do
    column :option
    column :value

    default_actions
  end
  filter  :option
end
