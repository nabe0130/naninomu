# frozen_string_literal: true

# Userモデルは、ユーザー認証とブックマークとの関連付けを処理します。
# 認証にはDeviseを使用し、Google OAuth2統合にはomniauthを利用します。
# 各ユーザーは、異なるカクテルに関連付けられた複数のブックマークを持つことができます。
class User < ApplicationRecord
  has_many :bookmarks # Bookmarksと関連付け

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # ※deviseのuserカラムに nameやprofile を追加している場合は下のコメントアウトを外して使用

      # user.name = auth.info.name
      # user.profile = auth.info.profile
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def bookmarked?(cocktail)
    bookmarks.exists?(drink_id: cocktail.id)
  end
end
