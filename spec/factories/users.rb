FactoryBot.define do
  factory :user do
    name {"Tester"}
    self.alias {"tester"}
    municipality {"Chiyoda-ku"}
    email {"tester@example.com"}
    password {"1234567"}
    # icon {create(:icon)}
    ##since icon is connected with user we can use associations (three ways):
    icon factory: :icon #implicitly
    # association :icon, factory: :icon #explicitly
    # icon { association :icon } #inline
  end
end
