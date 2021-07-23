FactoryBot.define do
  factory :icon do
    name {'default_icon'}
    url {Icon::IMAGES[0]}
  end
end
