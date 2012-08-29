class SystemController < ApplicationController
  def generate_answer_stats
    IPF::AnswerStat.generate
    flash[:notice] = 'Estatísticas das respostas geradas com sucesso'
    respond_to do |format|
      format.js
    end
  end

  def generate_passwords
    IPF::PasswordGenerator.new.generate_all
    flash[:notice] = 'Senhas geradas com sucesso'
    respond_to do |format|
      format.js
    end
  end

  def import_instrument
    if(params[:csv_file].nil?)
      respond_to do |format|
        format.html{render :layout => 'custom'}
        format.js
      end
    else
      file = params[:csv_file][:csv_file].tempfile.path
      Ipf::Instrument.import(file)
      flash[:notice] = 'Instrumental importado com sucesso'
      respond_to do |format|
        format.html{redirect_to(admin_questions_path)}
      end
    end
  end

  def import_service_levels
    if(params[:csv_file].nil?)
      respond_to do |format|
        format.html{render :layout => 'custom'}
        format.js
      end
    else
      file = params[:csv_file][:csv_file].tempfile.path
      Ipf::Import.services_levels(file)
      flash[:notice] = 'Arquivo importado com sucesso'
      respond_to do |format|
        format.html{redirect_to(admin_service_levels_path)}
      end
    end
  end

  def import_schools
    if(params[:csv_file].nil?)
      respond_to do |format|
        format.html{render :layout => 'custom'}
        format.js
      end
    else
      file = params[:csv_file][:csv_file].tempfile.path
      Ipf::Import.schools(file)
      flash[:notice] = 'Arquivo importado com sucesso'
      respond_to do |format|
        format.html{redirect_to(admin_schools_path)}
      end
    end
  end

  def import_dimensions
    if(params[:csv_file].nil?)
      respond_to do |format|
        format.html{render :layout => 'custom'}
        format.js
      end
    else
      file = params[:csv_file][:csv_file].tempfile.path
      Ipf::Import.dimensions(file)
      flash[:notice] = 'Arquivo importado com sucesso'
      respond_to do |format|
        format.html{redirect_to(admin_dimensions_path)}
      end
    end
  end

  def import_segments
    if(params[:csv_file].nil?)
      respond_to do |format|
        format.html{render :layout => 'custom'}
        format.js
      end
    else
      file = params[:csv_file][:csv_file].tempfile.path
      Ipf::Import.segments(file)
      flash[:notice] = 'Arquivo importado com sucesso'
      respond_to do |format|
        format.html{redirect_to(admin_segments_path)}
      end
    end
  end

  def import_indicators
    if(params[:csv_file].nil?)
      respond_to do |format|
        format.html{render :layout => 'custom'}
        format.js
      end
    else
      file = params[:csv_file][:csv_file].tempfile.path
      Ipf::Import.indicators(file)
      flash[:notice] = 'Arquivo importado com sucesso'
      respond_to do |format|
        format.html{redirect_to(admin_indicators_path)}
      end
    end
  end

end


