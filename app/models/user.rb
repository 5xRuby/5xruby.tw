class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: Omniauth::OMNIAUTH_PROVIDERS

  class << self
    def from_omniauth(omniauth)
      if user = omniauth.user
        user
      elsif user = User.find_by(email: omniauth.email)
        user.omniauths << omniauth
        user
      else
        User.new.fill_from_omniauth(omniauth)
      end
    end

  end

  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros
  def fill_from_omniauth(omniauth)
    self.assign_attributes(
      name: omniauth.name,
      email: omniauth.email,
      omniauth: omniauth
    )
    self
  end

  def omniauth=(value)
    @omniauth = value
    self.omniauths.push value
  end

  def omniauth
    @omniauth ||= self.omniauths.last
  end

  def omniauth_key=(key)
    @omniauth_key = key
    return if key.blank?
    begin
      self.omniauth = Omniauth.find(
        ActiveSupport::MessageEncryptor
          .new(Rails.application.secrets.secret_key_base)
          .decrypt_and_verify(key)
      )
    rescue => e
      raise e if Rails.env.development? || Rails.env.test?
      raise ActiveRecord::RecordNotFound
    end
  end

  def omniauth_key
    @omniauth_key ||=
      if self.omniauth.present?
        ActiveSupport::MessageEncryptor
          .new(Rails.application.secrets.secret_key_base)
          .encrypt_and_sign(self.omniauth.id)
      else
        ''
      end
  end

  def password_required?
    omniauth.blank? && super
  end

  # association macros
  has_many :omniauths

  # validation macros
  validates :name, :phone, presence: true
  validates :phone, format: /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/

  # callbacks

  # other

  protected

  # callback methods
end
