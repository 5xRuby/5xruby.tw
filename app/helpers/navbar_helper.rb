module NavbarHelper
  def nav_li text, url, match: url, method: :start_with?, link_method: nil, **link_to_options
    link_to_options.merge!(method: link_method) if link_method.present?
    active = request.path.send(method, match) ? :active : nil
    content_tag :li, class: active do
      link_to text, url, **link_to_options
    end
  end

  def locale_li name, locale
    locale_link = link_to name, url_for(request.GET.merge(locale: locale == I18n.default_locale ? nil : locale))
    content_tag :li, locale_link unless locale == I18n.locale
  end
end
