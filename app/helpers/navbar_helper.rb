module NavbarHelper
  def nav_li text, url, match: url, method: :start_with?, **link_to_options
    content_tag :li, class: (:active if request.path.send(method, match)) do
      link_to text, url, **link_to_options
    end
  end

  def nav_dropdown text, &block
    content_tag :li, class: :normal_drop_down do
      concat link_to text, '#'
      concat content_tag(:div, nil, class: :'mobnav-subarrow')
      concat content_tag(:ul, capture(&block))
    end
  end
end
