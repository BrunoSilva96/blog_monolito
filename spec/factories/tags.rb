FactoryBot.define do
  factory :tag do
    tag_text { Faker::Name.unique.name }
  end
end
