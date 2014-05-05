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
      link_to association.send(attribute[1]), association rescue association.send(attribute[1])
    when Symbol
      case val = record.send(attribute)
      when CarrierWave::Uploader::Base
        uploader = if val.version_exists?(:preview) && val.preview.present? then val.preview
                   elsif val.version_exists?(:thumb) && val.thumb.present? then val.thumb
                   else val end
        link_to image_tag(uploader, height: 100), val.url
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

  def tr_for record, *attributes
    attributes.map{ |attribute|
      text = attribute_appearance record, attribute
      content_tag(:tr, content_tag(:td, record.class.human_attribute_name(Array === attribute ? attribute[0] : attribute)) + content_tag(:td, text))
    }.join.html_safe
  end

  def td_action_for record
    content_tag(:td, link_to(t('crud.show'), record)) +
    content_tag(:td, link_to(t('crud.edit'), [:edit, record])) +
    content_tag(:td, link_to(t('crud.destroy'), record, method: :delete, data: { confirm: t('message.are_you_sure') }))
  end

  def notice_message
  end
end
