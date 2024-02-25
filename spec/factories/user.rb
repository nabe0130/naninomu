FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    password { "password" }
    # 他の属性があればここに追加
  end
end
