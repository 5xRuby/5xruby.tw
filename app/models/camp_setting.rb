class CampSetting < ApplicationRecord

  def initialize(_ = {})
    super
    self.payload ||= if last_camp_version = self.class.active.lang(self.lang).last
      last_camp_version.payload
    else
      Camp.to_hash
    end
    self.status ||= :inactive
  end
  
  # scope macros
  scope :active, -> {
    where(status: :active)
  }
  scope :lang, -> (lang) {
    where(lang: lang)
  }
  scope :lang_or_none, -> (lang) {
    where(lang: [lang, nil])
  }
  scope :lang_or_any, -> (lang) {
    where(lang: lang) if where(lang: lang).count > 0
  }

  # Concerns macros

  # Constants
  
  # Attributes related macros
  STATUSES = %i{active inactive}
  LOCALES = Settings.index_pictures.langs
  enum status: Hash[STATUSES.map {|x| [x.to_sym, x.to_s] }],
    lang: Hash[LOCALES.map {|x| [x.to_sym, x.to_s] }]

  def json
    self.payload.to_json
  end

  def json=(input)
    self.payload = JSON.parse(input)
  end

  def active!
    self.status = :active
    save!
  end
  
  def inactive!
    self.status = :inactive
    save!
  end

  def active?
    self.status.to_sym == :active
  end

  # association macros

  # validation macros
  validates :status, :payload, presence: true

  # callbacks
  # other

  protected
  # callback methods
  after_save :ensure_only_one_active
  def ensure_only_one_active
    return unless active?
    self.class.active.lang(self.lang).where.not(id: self.id).each do |cs|
      cs.inactive!
    end
  end

end
