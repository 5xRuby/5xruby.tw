class Admin::TranslationsController < AdminController
  before_action :check_params, only: :index

  def index
    model    = params.require(:model).constantize
    string_types = %i[string text]
    @models = Translation::AVAILABLE_MODELS.keys
    @records = model.page(params[:page])
    @translations = Translation.includes(:translatable).where(translatable: @records)
    @columns = model.columns.select{ |column| string_types.include? column.type }
    @locales = I18n.available_locales.reject{ |i| i == I18n.default_locale }
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

  def check_params
    unless translatable_locales.map(&:to_s).include?(params[:lc]) && Translation::AVAILABLE_MODELS.keys.map(&:name).include?(params[:model])
      redirect_to url_for(lc: :en, model: :Faq)
    end
  end
end
