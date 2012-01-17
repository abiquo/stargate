ActiveAdmin.register Preference do
  config.comments = false
  
  index do
    column :option
    column :value

    default_actions
  end
  filter  :option
end
