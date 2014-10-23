class Admin::TranslationsController < AdminController
  def index
    model    = params.require(:model).constantize
    string_types = %i[string text]
    @models = Translation::AVAILABLE_MODELS.keys
    @records = model.page(params[:page])
    @translations = Translation.includes(:translatable).where(translatable: @records)
    @columns = model.columns.select{ |column| string_types.include? column.type }
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
