class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_initialize :init

    def init
      self.role = "Standard"           #will set the default value only if it's nil
    end

  has_many :wikis, dependent: :destroy
end
