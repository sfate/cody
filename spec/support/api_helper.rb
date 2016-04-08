module ApiHelper
  def json_body
    JSON.load(response.body)
  end

  def api_headers(token_id, token)
    {
      "CONTENT_TYPE" => "application/json",
      "ACCEPT" => "application/json",
      "AUTHORIZATION" => "#{token_id}:#{token}"
    }
  end
end
