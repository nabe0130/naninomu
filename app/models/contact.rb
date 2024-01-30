class Contact include ActiveModel::Model
    attr_accessor :name, :email, :content
   
    validates :name, presence: true, length: { maximum: 20 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  #emailのフォーマットを検証するために使われます。
    validates :email, presence: true, length: { maximum: 30 }, #emailが空でないこと、最大30文字であること
                      format: { with: VALID_EMAIL_REGEX }
    validates :content, presence: true, length: { maximum: 500 } #contentが空でないこと、そして最大500文字であること
end
