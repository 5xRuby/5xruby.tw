module AdminHelper
  def nav_li_for model, match: model.table_name
    content_tag :li, link_to(model.model_name.human, model),
                class: request.path[match] ? 'active' : nil
  end

  def th_for model, *attributes
    attributes.map{ |attribute|
      content_tag :th, model.human_attribute_name(attribute)
    }.join.html_safe
  end

  def attribute_appearance record, attribute
    case attribute
    when Array
      association = record.send(attribute[0])
      case attribute[1]
      when Proc
        attribute[1].call(record)
      when Symbol
        link_to association.send(attribute[1]), association rescue association.send(attribute[1]) if association.present?
      end
    when Symbol
      case val = record.send(attribute)
      when CarrierWave::Uploader::Base
        uploader = if val.version_exists?(:preview) && val.preview.present? then val.preview
                   elsif val.version_exists?(:thumb) && val.thumb.present? then val.thumb
                   else val end
        link_to image_tag(uploader, height: 100), record if uploader.present?
      when TrueClass, FalseClass then admin_boolean_tag(val)
      else val
      end
    end
  end

  def td_for record, *attributes
    attributes.map{ |attribute|
      text = attribute_appearance record, attribute
      content_tag :td, text
    }.join.html_safe
  end

  def tr_for record, *attributes, **html_options
    attributes.map{ |attribute|
      text = attribute_appearance record, attribute
      content_tag(:tr, content_tag(:td, record.class.human_attribute_name(Array === attribute ? attribute[0] : attribute), class: html_options[:first_el_class]) + content_tag(:td, text, class: html_options[:last_el_class]))
    }.join.html_safe
  end

  def td_action_for_post record
    content_tag(:td, link_to(admin_icon_tag(:'eye-open'), record, class: 'btn btn-default', title: t('crud.show'))) +
    content_tag(:td, link_to(admin_icon_tag(:'play'), [:preview, record], class: 'btn btn-default', title: t('crud.preview'))) +
    content_tag(:td, link_to(admin_icon_tag(:edit), [:edit, record], class: 'btn btn-default', title: t('crud.edit'))) +
    content_tag(:td, link_to(admin_icon_tag(:trash), record, method: :delete, data: {confirm: t('message.are_you_sure')}, class: 'btn btn-danger', title: t('crud.delete')))
  end

  def td_action_for record
    content_tag(:td, link_to(admin_icon_tag(:'eye-open'), record, class: 'btn btn-default', title: t('crud.show'))) +
    content_tag(:td, link_to(admin_icon_tag(:edit), [:edit, record], class: 'btn btn-default', title: t('crud.edit'))) +
    content_tag(:td, link_to(admin_icon_tag(:trash), record, method: :delete, data: {confirm: t('message.are_you_sure')}, class: 'btn btn-danger', title: t('crud.delete')))
  end

  def admin_label_tag text, type = :default
    # <span class="label label-default">Default</span>
    content_tag :span, text, class: "label label-#{type}"
  end

  def admin_icon_tag type, text = nil
    # <span class="glyphicon glyphicon-search"></span>
    text = ' ' + text if text.present?
    content_tag(:span, nil, class: "glyphicon glyphicon-#{type}") + text
  end

  def admin_boolean_tag bool
    text, klass = bool ? %i[是 success] : %i[否 danger]
    content_tag(:span, text, class: "label label-#{klass}")
  end

  def td_is_online record
    [
      :is_online,
      ->(record){
        record.is_online ? link_to(
          admin_label_tag('上線', :success),
          polymorphic_path(record, ref: request.path, dom_class(record) => {is_online: false}), method: :put)
        : link_to(
          admin_label_tag('下線'),
          polymorphic_path(record, ref: request.path, dom_class(record) => {is_online: true}), method: :put)
      }
    ]
  end

  def tr_speakers record
    [
      :speakers,
      ->(record){
        record.speakers.map{ |speaker| link_to speaker.name, speaker }.join(', ').html_safe
      }
    ]
  end

  def show_attr(record, attr)
    humanized_name = record.class.human_attribute_name attr
    value = case attr
    when Symbol
      record.send(attr)
    when Proc
      attr.call(record)
    end
    "#{humanized_name}: #{record.send attr}"
  end

  def render_react_component(id: '', data: {})
    content_tag :div, id: id, data: data do
    end
  end
end
