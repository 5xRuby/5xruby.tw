module PatchNestedAttributesAssignment
  extend ActiveSupport::Concern

  included do
    extend ClassMethods
  end

  module ClassMethods
    def patch(attribute_name, class_name: nil, foreign_key: nil)
      define_method :assign_nested_attributes_for_collection_association do |association_name, attributes_collection|
        class_name ||= attribute_name.to_s.split("_").map(&:singularize).join("_").camelize
        class_name = class_name.constantize if class_name.is_a?(String)

        foreign_key ||= [self.class.to_s.split("::").reject{|s| s == "Admin"}.map(&:downcase), "id"].join("_").to_sym

        if association_name == attribute_name && attributes_collection.is_a?(Hash)
          attributes_collection.each_pair do |key, value|
            resource = class_name.find_by(id: value['id'])
            next if resource.present? && resource.send(foreign_key).present?

            if resource.present?
              send(attribute_name).send(:<<, resource)
            else
              new_resource = class_name.new(value)
              new_resource.send(:"#{foreign_key}=", id)
              new_resource.save!
              send(attribute_name).send(:<<, new_resource)
            end
          end
        end

        super(association_name, attributes_collection)
      end

      private :assign_nested_attributes_for_collection_association
    end
  end
end
