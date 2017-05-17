class Omniauth < ApplicationRecord
  OMNIAUTH_PROVIDERS = [:facebook, :google_oauth2, :github]
  enum provider: Hash[OMNIAUTH_PROVIDERS.map {|x| [x.to_sym, x.to_s] }]

  class << self
    def from_auth_hash(auth_hash)
      query_hash = { provider: auth_hash['provider'], uid: auth_hash['uid'] }
      Omniauth.where(query_hash).first ||
        Omniauth.create(query_hash.merge(payload: auth_hash))
    end

  end

  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros
  def email
    payload_attrs[:email]
  end

  def name
    payload_attrs[:name]
  end

  def payload_attrs
    @payload_attrs ||=
      case self.payload['provider'].to_sym
      when :google_oauth2
        {
          email: self.payload['info']['email'],
          name: self.payload['info']['name']
        }
      when :facebook
        {
          email: self.payload['info']['email'],
          name: self.payload['info']['name']
        }
      when :github
        {
          email: self.payload['info']['email'],
          name: self.payload['info']['name']
        }
      end
  end

  # association macros
  belongs_to :user

  # validation macros
  validates :provider, :uid, :payload, presence: true

  # callbacks

  # other

  protected

  # callback methods
end
