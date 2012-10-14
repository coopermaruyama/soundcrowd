module ApplicationHelper
  
  def logo
    image_tag("logo.png", :alt => 'SoundCrowd', :class=> 'logo')
  end
  
  def nested_versions(versions)
    versions.map do |version, sub_versions|
      render(version) + content_tag(:div, nested_versions(sub_versions), :class => "nested_versions")
    end.join.html_safe
  end
end
