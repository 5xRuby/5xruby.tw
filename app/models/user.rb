class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, omniauth_providers: Omniauth::OMNIAUTH_PROVIDERS


  class << self
    def from_omniauth(auth_hash)
      omniauth = Omniauth.from_omniauth(auth_hash)
      omniauth.user ||
        User.new(
          omniauths: [omniauth],
          name: omniauth.name,
          email: omniauth.email
      )
    end

  end
  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros

  # association macros
  has_many :omniauths

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
