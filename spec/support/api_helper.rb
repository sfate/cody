module ApiHelper
  def json_body
    JSON.load(response.body)
  end
end
