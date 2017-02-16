class ShowcasesController < ApplicationController
  def index
    @showcases = Showcase.includes(:translations).where(category: :project, is_online: true).order(:sort_id)
  end
end
