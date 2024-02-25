require 'rails_helper'

RSpec.describe Contact, type: :model do
  it "is valid with valid attributes" do
    contact = Contact.new(name: "Example User", email: "user@example.com", content: "This is a test message.")
    expect(contact).to be_valid
  end

  it "is invalid without a name" do
    contact = Contact.new(name: nil)
    contact.valid?
    expect(contact.errors[:name]).to be_present
  end

  it "is invalid with a name longer than 20 characters" do
    contact = Contact.new(name: "a" * 21)
    contact.valid?
    expect(contact.errors[:name]).to be_present
  end

  # 他のバリデーションに関するテストを追加...
end
