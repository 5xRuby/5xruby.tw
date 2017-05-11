class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros

  # association macros

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
