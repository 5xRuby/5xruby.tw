class Admin::TranslationsController < AdminController
  def index
    model    = params.require(:model).constantize
    matching = %i[string text]
    @records = model.page(params[:page])
    @columns = model.columns.select{ |column| matching.include? column.type }
  end

  def create
    @translation = Translation.find_or_initialize_by translation_params.slice(:translatable_id, :translatable_type, :column, :locale)
    @translation.text = translation_params[:text]
    head @translation.save ? :accepted : :bad_request
  end

  def update
    create
  end

  private

  def translation_params
    params.require(:translation).permit(:translatable_id, :translatable_type, :text, :column, :locale)
  end
end
