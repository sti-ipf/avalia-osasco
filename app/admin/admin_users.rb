ActiveAdmin.register AdminUser do
  menu :parent => "Administração", :priority => 1

  filter :email

  form do |f|
    f.inputs "Usuário" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.buttons
    end
  end

  index do
  column :email
  column :sign_in_count
  column :last_sign_in_at
  column :last_sign_in_ip
  default_actions
  end
end