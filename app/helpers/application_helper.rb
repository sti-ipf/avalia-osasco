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


end

