module ApplicationHelper
  def sub_header title: nil, lead_box: nil, lead: nil
    content_tag(:section, id: :'sub-header'){
      concat content_tag(:div, class: :container){
        content_tag(:div, class: :row){
          content_tag(:div, class: 'col-md-10 col-md-offset-1 text-center'){
            concat content_tag(:h1, title) if title
            concat content_tag(:p, lead_box, class: 'lead boxed') if lead_box
            concat content_tag(:p, lead, class: :lead) if lead
          }
        }
      }
      concat content_tag(:div, nil, class: :divider_top)
    }
  end

  def html_tag_attributes
    @html_tag_attributes ||= {}
    if @seo
      @html_tag_attributes.merge! prefix: 'og: http://ogp.me/ns#' if @seo[:og]
      @html_tag_attributes.merge! itemscope: true, itemtype: "http://schema.org/#{@seo[:google][:item_type]}" if @seo[:google] && @seo[:google][:item_type]
    end
    @html_tag_attributes
  end

  def notice_message
    # <div class="alert alert-warning alert-dismissable">
    #   <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
    #   <strong>Warning!</strong> Better check yourself, you're not looking too good.
    # </div>
    ret = ''.html_safe
    %i[alert notice].each do |alert_type|
      if flash[alert_type]
        alert_class = case alert_type
                      when :alert then 'alert-danger'
                      when :notice then 'alert-success'
                      end
        ret += content_tag :div, class: "alert #{alert_class} alert-dismissable" do
                concat button_tag('×', class: 'close', data: {dismiss: :alert, hidden: true})
                concat flash[alert_type]
               end
      end
    end
    ret
  end

  def has_error_class record, attribute
    'has-error' if record.errors[attribute].present?
  end

  def help_block record, attribute
    record.errors.messages[attribute].map do |msg|
      content_tag :p, msg, class: 'help-block'
    end.join.html_safe if record.errors[attribute].present?
  end

  def course_charger(course)
    counter = @course.need_attendees_count
    (counter > 0) ? t('.charger', num: counter) : t('.charger_complete')
  end

  def show_hours hours
    '%.2g' % hours
  end

  def breadcrumb *links
    content_tag :ol, class: :breadcrumb do
      concat content_tag(:li, link_to(t('breadcrumb.home'), root_path))
      last = links.pop
      links.each do |link|
        concat content_tag(:li, link)
      end
      concat content_tag(:li, last, class: 'active')
    end
  end

  def icon_tag name, text = nil
    content_tag :i, text, class: "icon-#{name}"
  end

  def locale_li name, locale
    locale_link = link_to name, url_for(request.GET.merge(locale: locale == I18n.default_locale ? nil : locale))
    content_tag :li, locale_link unless locale == I18n.locale
  end

  def image_set_tag(src_folder, sizes, options = {})
    srcset = sizes.map do |s|
      "#{path_to_image "#{src_folder}/#{s}"} #{s}"
    end.join(', ')
    image_tag "#{src_folder}/#{sizes.last}", {alt: src_folder.split('/').last, srcset: srcset}.merge(options)
  end

  def public_path(file_path)
    file_path.start_with?('/') ? file_path : "/#{file_path}"
  end
end
