ActiveAdmin.register AdminUser do
  config.comments = false
  
  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    default_actions
  end
  form do |f|
    f.inputs "Admin Details" do
      f.input :email
    end
    f.buttons
  end
  
  filter :email
  filter :name
end
