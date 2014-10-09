class ShowcasesController < ApplicationController
  def index
    @showcases = Showcase.where(is_online: true)
  end
end
