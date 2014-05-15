class AddMoreAttrToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :role, :string, null: false, default: :consultant
    add_column :speakers, :title, :string
    add_column :speakers, :facebook_url, :string
    add_column :speakers, :twitter_url, :string
    add_column :speakers, :google_url, :string
    add_column :speakers, :blog_url, :string
  end
end
