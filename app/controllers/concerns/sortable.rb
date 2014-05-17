module Sortable
  extend ActiveSupport::Concern

  def sort
    model_class = "Admin::#{controller_name.classify}".constantize
    params.require(:sort).each{|record_id, attributes| model_class.update(record_id, sort_id: attributes[:sort_id]) }
    redirect_to model_class
  end
end