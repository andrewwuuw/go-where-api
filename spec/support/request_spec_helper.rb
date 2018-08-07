module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    OpenStruct.new(JSON.parse(response.body))
  end
end