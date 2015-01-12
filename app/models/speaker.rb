class Speaker < ActiveRecord::Base
  # scope macros
  scope :online, -> { where(is_online: true) }

  # Concerns macros
  extend Enumerize
  include Select2Concern

  # Constants

  # Attributes related macros
  mount_uploader :avatar, SpeakerAvatarUploader

  # association macros
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :videos
  has_many :translations, as: :translatable

  # validation macros
  validates :name, :role, presence: true
  validates :name, uniqueness: true
  select2_white_list :name
  enumerize :role, in: %i[author consultant speaker parttime-speaker assistant-speaker]

  # callbacks
end
