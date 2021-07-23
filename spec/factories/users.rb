FactoryBot.define do
  factory :user do
    name {"Tester"}
    municipality {"Chiyoda-ku"}
    self.alias {"tester"}
    email {"tester@example.com"}
    password {"1234567"}
    icon {create(:icon)}
  end
end
