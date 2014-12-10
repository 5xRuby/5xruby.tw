module NavbarHelper
  def nav_li text, url, match: url, method: :start_with?, **link_to_options
    active = nil
    @_nav_dropdown_active = active = :active if request.path.send(method, match)
    # @_nav_dropdown_active is used for nav_dropdown to check active
    content_tag :li, class: active do
      link_to text, url, **link_to_options
    end
  end

  def nav_dropdown text, &block
    @_nav_dropdown_active = nil
    items = content_tag(:ul, capture(&block))
    content_tag :li, class: "normal_drop_down #{@_nav_dropdown_active}" do
      concat link_to text, '#'
      concat content_tag(:div, nil, class: :'mobnav-subarrow')
      concat items
    end
  end
end
