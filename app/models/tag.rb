class Tag < ApplicationRecord
  validates :tag_text, presence: true, uniqueness: { case_sensitive: false }

  has_and_belongs_to_many :posts
end
