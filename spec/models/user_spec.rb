require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:session_token) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  subject(:user) { User.new(username: "Theo", password: "password") }

  it {should validate_uniqueness_of(:username) }

  describe "::find_by_credentials" do
    context "with valid credentials" do
      it "finds a user" do
        user.save
        expect(User.find_by_credentials("Theo", "password")).to eq(user)
      end
    end

    context "with invalid credentials" do
      it "returns nil when no user is found" do
        user.save
        expect(User.find_by_credentials("Adrian", "password")).to be nil
      end
      it "returns nil when the password is incorrect" do
        user.save
        expect(User.find_by_credentials("Theo", "not_password")).to be nil
      end
    end
  end
end
