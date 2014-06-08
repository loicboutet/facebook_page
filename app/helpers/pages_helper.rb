module PagesHelper
  
  def pretty_print(value)
    html = ""
    if value.is_a?(Hash)
      html << "<ul>".html_safe
      value.each do |key, value|
        if value.is_a?(Hash) || value.is_a?(Array)
          html << content_tag(:li, "#{key}")                
          html << pretty_print(value)
        else
          html << content_tag(:li, "#{key} : #{value}")      
        end
      end
      html << "</ul>".html_safe
    elsif value.is_a?(Array)
      value.each do |val|
        html << content_tag(:div, pretty_print(val))
      end
    else
      html << content_tag(:li, value)      
    end
    return html.html_safe
  end
  
end
