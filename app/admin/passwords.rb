ActiveAdmin.register Password do
  menu :parent => "Avaliação", :priority => 6
  actions :index, :show
  filter :school
  filter :segment

  scope :all, :default => true
  begin
    ServiceLevel.all.each do |sl|
      scope sl.name
    end
  rescue
  end

  actions :all, :except => [:edit, :update]
  member_action :download_letter, :method => :get, :format => :pdf do
    redirect_to passwords_generate_all_letters_path :id => params[:id], :format => :pdf
  end

  index do
    column :school
    column :segment
    column :password
    column() {|password| link_to 'Baixar carta', download_letter_admin_password_path(password, :format => :pdf), :target => :blank }
  end

  sidebar "Ações" do
    @passwords = Password.all
    render('/admin/password/actions')
  end
end

