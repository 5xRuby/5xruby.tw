class ShowcasesController < ApplicationController
  def index
    @showcases = Showcase.where(is_online: true).order(:sort_id)
  end
end
