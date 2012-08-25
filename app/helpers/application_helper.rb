module ApplicationHelper

  def flash_messages
    @messages = ''
    flash.each do |type, message|
      @messages = "#{@messages}<br>#{message}"
      @type = type
    end
    javascript = "<script type=\"text/javascript\"> jQuery(function(message) {jQuery.jGrowl(\"#{@messages}\", {easing: \"linear\", life: 4000,theme: \"#{@type}\"});});</script>"
    if defined?(@type)
      javascript 
    else
      ''
    end
  end

  def custom_title
    if request.path.include?("mapa")
      "Mapa das Respostas"
    elsif request.path.include?("niveis_de_servico")
      "Importar Níveis de Serviço"
    elsif request.path.include?("escolas")
      "Importar Escolas"
    elsif request.path.include?("segmentos")
      "Importar Segmentos"
    elsif request.path.include?("dimensoes")
      "Importar Dimensões"
    elsif request.path.include?("indicadores")
      "Importar Indicadores"
    else
      "Importar Instrumental"
    end
  end


end

