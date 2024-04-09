class Post < ApplicationRecord
  validates_presence_of :text

  belongs_to :user
  has_many :comments, dependent: :destroy
end
