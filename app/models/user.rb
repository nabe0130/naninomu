class User < ApplicationRecord
  has_many :bookmarks # Bookmarksと関連付け

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    # ※deviseのuserカラムに nameやprofile を追加している場合は下のコメントアウトを外して使用

    #user.name = auth.info.name
    #user.profile = auth.info.profile
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    end
  end

  def bookmarked?(cocktail)
    bookmarks.exists?(drink_id: cocktail_id)
  end
end
