module ApplicationHelper
  def notice_message
    ret = ''.html_safe
    ret += content_tag :div, alert, class: 'alert alert-danger' if alert
    ret += content_tag :div, notice, class: 'alert alert-success' if notice
    ret
  end

  def has_error_class record, attribute
    'has-error' if record.errors[attribute].present?
  end

  def help_block record, attribute
    @contact.errors.messages[attribute].map do |msg|
      content_tag :p, msg, class: 'help-block'
    end.join.html_safe
  end
end
