class RenameLinkToIframeInVideos < ActiveRecord::Migration
  def change
    rename_column(:videos, :link, :iframe)
  end
end
