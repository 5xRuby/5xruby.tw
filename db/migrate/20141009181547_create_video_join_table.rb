class CreateVideoJoinTable < ActiveRecord::Migration
  def change
    create_join_table :videos, :speakers do |t|
      t.index [:video_id, :speaker_id]
      t.index [:speaker_id, :video_id]
    end
  end
end
