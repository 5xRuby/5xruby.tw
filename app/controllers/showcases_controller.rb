class ShowcasesController < ApplicationController

  breadcrumb I18n.t('breadcrumb.home'), :root_path
  def index
    breadcrumb I18n.t('breadcrumb.projects'), nil
    @showcases = Showcase.includes(:translations).where(category: :project, is_online: true).order(:sort_id)
  end
end
