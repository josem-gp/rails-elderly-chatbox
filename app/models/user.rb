class User < ApplicationRecord
  ADDRESSES = %w[ Chiyoda-ku Bunkyo-ku Shinjuku-ku Shibuya-ku Minato-ku Chuo-ku Taito-ku Toshima-ku Nakano-ku
                  Suginami-ku Setagaya-kuMeguro-ku Shinagawa-ku Ota-ku Koto-ku Edogawa-ku Sumida-ku Arakawa-ku
                  Katsushika-ku Nerima-ku Itamashi-ku Adachi-ku Kita-ku Musashino-shi Mitaka-shi Chofu-shi Komae-shi
                  Inagi-shi Tama-shi Fuchu-shi Koganei-shi Nishitokyo-shi Higashikurume-shi Kiyose-shi
                  Higashimurayama-shi Kodaira-shi Kokubunji-shi Kunitachi-shi Hino-shi Tachikawa-shi Higashiyamato-shi
                  Musashimurayama-shi Akishima-shi Fussa-shi Mizuho-machi Hamura-shi Oume-shi Hinode-machi Akiruno-shi
                  Okutama-machi Hinohara-mura Hachioji-shi Machida-shi]

  has_many :messages
  has_many :rooms, through: :participants
  validates :alias, presence: true, length: { in: 3..12 },
                    uniqueness: { message: "this alias is being used by another user",
                                  case_sensitive: false }
  validates :first_name, uniqueness: { scope: :last_name,
                                       message: "user already registered with this first and last name" },
                         presence: true
  validates :last_name, presence: true
  validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 20,
                                                  less_than_or_equal_to: 100 }
  validates :municipality, presence: true, inclusion: { in: ADDRESSES }

  def capitalize_first
    first_name.capitalize
  end

  def capitalize_first
    last_name.capitalize
  end
end
