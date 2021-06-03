class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  ADDRESSES = %w[ Chiyoda-ku Bunkyo-ku Shinjuku-ku Shibuya-ku Minato-ku Chuo-ku Taito-ku Toshima-ku Nakano-ku
                  Suginami-ku Setagaya-ku Meguro-ku Shinagawa-ku Ota-ku Koto-ku Edogawa-ku Sumida-ku Arakawa-ku
                  Katsushika-ku Nerima-ku Itamashi-ku Adachi-ku Kita-ku Musashino-shi Mitaka-shi Chofu-shi Komae-shi
                  Inagi-shi Tama-shi Fuchu-shi Koganei-shi Nishitokyo-shi Higashikurume-shi Kiyose-shi
                  Higashimurayama-shi Kodaira-shi Kokubunji-shi Kunitachi-shi Hino-shi Tachikawa-shi Higashiyamato-shi
                  Musashimurayama-shi Akishima-shi Fussa-shi Mizuho-machi Hamura-shi Oume-shi Hinode-machi Akiruno-shi
                  Okutama-machi Hinohara-mura Hachioji-shi Machida-shi].sort
  belongs_to :icon
  has_many :messages
  has_many :events
  has_many :participants
  has_many :rooms, through: :participants
  has_one_attached :photo
  validates :alias, presence: true, length: { in: 3..12 },
    uniqueness: { message: "this alias is being used by another user", case_sensitive: false }
  validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 20,
                                                  less_than_or_equal_to: 100 }
  validates :name, presence: true
  validates :municipality, presence: true, inclusion: { in: ADDRESSES }
  before_validation :add_default_icon, on: :create
  after_create :create_room_assignments
  def capitalize_first
    name.capitalize
  end

  def create_room_assignments
    rooms = Room.where(name: self.municipality.match(/(\w*)-/)[1].strip).or(Room.where(room_type: 'public'))
    rooms.each do |room|
      Participant.create(user: self, room: room)
    end
  end

  def add_default_icon
    default_icon = Icon.find_by(name: 'default_icon')
    self.icon = default_icon
  end
end
