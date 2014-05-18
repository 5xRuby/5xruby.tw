module ApplicationHelper
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

  def nav_li text, url, match: url
    content_tag :li, class: (:active if request.path == match) do
      link_to text, url
    end
  end
end
