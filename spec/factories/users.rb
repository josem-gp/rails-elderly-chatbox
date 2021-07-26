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

  trait :with_rooms do
    after(:create) do |user|
      room = Room.create(name: "Adachi", room_type: "private")
      room_public = Room.create(name: "General", room_type: "public")
      [room, room_public].each do |r|
        participant = Participant.create(user: user, room: r)
      end
    end
  end
end
