class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_one_attached :avatar

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end
