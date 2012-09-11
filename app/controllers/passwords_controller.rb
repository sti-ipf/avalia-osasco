class PasswordsController < ApplicationController
  def generate_creche_conveniadas_letters
    @passwords = Password.where("service_level_id = ?", 6)
    respond_to do |format|
      format.html {render :layout => false}
      format.pdf do
        headless = Headless.new
        headless.start
        render :layout => false, :pdf => "password_letters"
        headless.destroy
      end
    end
  end

  def generate_all_letters
    if params[:id].nil?
      @passwords = Password.all(:order => "schoold_id, segment_id")
    else
      @passwords = [Password.find(params[:id])]
    end
    respond_to do |format|
      format.html {render :layout => false}
      format.pdf do
        #headless = Headless.new
        #headless.start
        render :layout => false, :pdf => "password_letters"
        #headless.destroy
      end
    end
  end

  def generate_all_passwords
    IPF::PasswordGenerator.new.generate_all
    redirect_to admin_passwords_path, :notice => "Senhas geradas com sucesso."
  end
end

