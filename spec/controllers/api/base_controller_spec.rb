require 'rails_helper'

RSpec.describe Api::BaseController, type: :controller do
  controller do
    def index
      head :ok
      return
    end
  end

  describe "authentication" do
    context "when no header is present" do
      it "returns 401 Unauthorized" do
        get :index

        expect(response.status).to be(401)
      end
    end

    context "when a valid token and token_id are passed in" do
      it "returns 200 OK" do
        new_token = ApiToken.make!
        token_id = new_token.token_id
        token = new_token.token

        request.env["HTTP_AUTHORIZATION"] = "#{token_id}:#{token}"
        get :index

        expect(response.status).to be(200)
      end
    end
  end
end
