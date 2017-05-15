class AddNameColumnToCampTemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :camp_templates, :title, :string

    CampTemplate.reset_column_information
    CampTemplate.all.each do |camp_template|
      title = camp_template.payload["title"] ||
        "衝刺班模板 #{CampTemplate.count + 1}"
      camp_template.update_attributes(title: title)
    end
  end
end
