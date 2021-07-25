FactoryBot.define do
  factory :user do
    name {"Tester"}
    # self.alias {"tester"}
    sequence(:alias) { |n| "tester#{n+1}" }
    municipality {"Chiyoda-ku"}
    sequence(:email) { |n| "test#{n+1}@example.com" }
    password {"1234567"}
    # icon {create(:icon)}
    ##since icon is connected with user we can use associations (three ways):
    icon factory: :icon #implicitly
    # association :icon, factory: :icon #explicitly
    # icon { association :icon } #inline
  end
end
