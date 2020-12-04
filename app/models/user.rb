class User < ApplicationRecord
  has_many :schedule_results
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :nickname, presence: true, length: { maximum: 12 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
