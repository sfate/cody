require 'rails_helper'

RSpec.describe ApiToken, type: :model do
  it { is_expected.to validate_presence_of :token_id }
  it { is_expected.to validate_uniqueness_of :token_id }

  describe ".make!" do
    it "returns the new token object" do
      expect(ApiToken.make!).to be_a(ApiToken)
    end

    it "returns the unencrypted token inside the token object" do
      new_token = ApiToken.make!
      expect(BCrypt::Password.new(new_token.token_digest)).to eq(new_token.token)
    end
  end

  describe "#authenticate" do
    it "returns true when the token is correct" do
      token = ApiToken.make!
      token_id = token.token_id
      unencrypted = token.token

      expect(ApiToken.find_by(token_id: token_id).authenticate(unencrypted)).to be_truthy
    end

    it "returns false when the token is not correct" do
      token = ApiToken.make!
      token_id = token.token_id
      unencrypted = "n0tc0rr3ct"

      expect(ApiToken.find_by(token_id: token_id).authenticate(unencrypted)).to be_falsey
    end
  end
end
