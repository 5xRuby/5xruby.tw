class PagesController < ApplicationController
  breadcrumb I18n.t('breadcrumb.home'), :root_path
  def index
    @index_pictures = IndexPicture.includes(:index_picture_imgs).lang(I18n.locale).order(:ordering)
    @talks = Activity::Talk.includes(:translations).available.coming(3)
    @showcases = Showcase.includes(:translations).where(is_online: true).order(:sort_id).first 3
  end

  def contacts
    breadcrumb I18n.t('breadcrumb.contacts'), nil
    @contact = Contact.new
  end

  def faq
    breadcrumb I18n.t('breadcrumb.faq'), nil
    @faqs = Faq.where(is_online: true).includes(:translations).order(:sort_id)
  end

  def press
    breadcrumb I18n.t('breadcrumb.press'), nil
  end

  def training
    breadcrumb I18n.t('breadcrumb.training'), nil
    @showcases = Showcase.where(category: :training).first(3)
  end

  def members
    breadcrumb I18n.t('breadcrumb.members'), nil
  end

  def privacy_policy
  end

  def terms_of_service
  end

  def space
    breadcrumb I18n.t('breadcrumb.space'), nil
  end

  def about
    breadcrumb I18n.t('breadcrumb.about'), nil
  end
end
