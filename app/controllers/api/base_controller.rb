class Api::BaseController < ApplicationController
  before_action :authenticate_with_token!

  protected

  def authenticate_with_token!
    auth_header = request.headers["Authorization"]
    unless auth_header.present?
      head :unauthorized
      return
    end

    token_id, token = auth_header.split(":")

    api_token = ApiToken.find_by(token_id: token_id)
    unless api_token.present? && api_token.authenticate(token)
      head :unauthorized
      return
    end
  end
end
