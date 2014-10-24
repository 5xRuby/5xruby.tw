class ShowcasesController < ApplicationController
  def index
    @showcases = Showcase.includes(:translations).where(is_online: true).order(:sort_id)
  end
end
