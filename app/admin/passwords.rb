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

  member_action :download_letter, :method => :get, :format => :pdf do
    @passwords = []
    @passwords << Password.find(params[:id])
    puts @passwords.class
    puts @passwords.size
    respond_to do |format|
      format.html {render "/passwords/generate_all", :layout => false}
      format.pdf {render "/passwords/generate_all", :layout => false, :pdf => "password_letter"}
    end
  end

  index do
    column :school
    column :segment
    column :password
    actions :all, :except => [:edit, :destroy]
  end

  sidebar "Ações" do
    render('/admin/password/actions')
  end
end

