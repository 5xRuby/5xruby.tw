<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros
<% if attributes.any?(&:password_digest?) -%>
  has_secure_password
<% end -%>

  # association macros
<% attributes.select(&:reference?).each do |attribute| -%>
  belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %>
<% end -%>

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
<% end -%>
