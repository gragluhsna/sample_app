module ApplicationHelper
  
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    return "#{base_title} | #{@title}" if !@title.nil? 
    return base_title
  end
  
  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end
end