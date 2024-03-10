# frozen_string_literal: true

# Userモデルは、ユーザー認証とブックマークとの関連付けを処理します。
# 認証にはDeviseを使用し、Google OAuth2統合にはomniauthを利用します。
# 各ユーザーは、異なるカクテルに関連付けられた複数のブックマークを持つことができます。
class User < ApplicationRecord
  has_many :bookmarks # Bookmarksと関連付け

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 line]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email.presence || "#{auth.uid}@example.com"
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def bookmarked?(cocktail)
    bookmarks.exists?(drink_id: cocktail.id)
  end

  def social_profile(provider)
    social_profiles.select { |sp| sp.provider == provider.to_s }.first
  end

  def set_values(omniauth)
    return if provider.to_s != omniauth["provider"].to_s || uid != omniauth["uid"]

    credentials = omniauth["credentials"]
    info = omniauth["info"]

    self.access_token = credentials["refresh_token"]
    self.access_secret = credentials["secret"]
    # ここではデータベースのカラム名を正確に指定する必要があります
    self.credentials = credentials.to_json
    self.name = info["name"]
    self.save!
  end

  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    self.save!
  end
end
