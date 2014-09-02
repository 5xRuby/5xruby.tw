class CreateSpeakerJoinTable < ActiveRecord::Migration
  def change
    create_join_table :courses, :speakers do |t|
      t.index [:course_id, :speaker_id], unique: true
      t.index [:speaker_id, :course_id], unique: true
    end
  end
end
