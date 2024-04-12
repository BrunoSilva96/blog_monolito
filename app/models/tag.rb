class Tag < ApplicationRecord
  validates :tag_text, presence: true, uniqueness: { case_sensitive: false }
end
