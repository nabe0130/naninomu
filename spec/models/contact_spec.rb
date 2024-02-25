require 'rails_helper'

RSpec.describe Contact, type: :model do
  it "有効な属性の場合は有効である" do
    contact = Contact.new(name: "Example User", email: "user@example.com", content: "This is a test message.")
    expect(contact).to be_valid
  end

  it "名前がない場合は無効である" do
    contact = Contact.new(name: nil)
    contact.valid?
    expect(contact.errors[:name]).to be_present
  end

  it "名前が20文字を超える場合は無効である" do
    contact = Contact.new(name: "a" * 21)
    contact.valid?
    expect(contact.errors[:name]).to be_present
  end

  # 他のバリデーションに関するテストを追加...
end
