FactoryBot.define do
  factory :user do
    name {"Tester"}
    self.alias {"tester"}
    municipality {"Chiyoda-ku"}
    email {"tester@example.com"}
    password {"1234567"}
    icon {create(:icon)}
  end
end
