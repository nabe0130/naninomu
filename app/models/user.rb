class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :bookmarks # Bookmarksと関連付け

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def bookmarked?(cocktail)
    bookmarks.exists?(drink_id: cocktail_id)
  end
end
