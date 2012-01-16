ActiveAdmin.register Configuration do
  index do
    column :option
    column :value
    default_actions
  end
  
  filter :option
  filter :value
end