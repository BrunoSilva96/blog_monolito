require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to validate_presence_of(:text) }

  it { is_expected.to belong_to(:user).optional }
  it { is_expected.to belong_to(:post) }
end
