class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_initialize {self.role ||= :standard}

  enum role: [:standard, :admin, :premium]

  has_many :wikis, dependent: :destroy
end
