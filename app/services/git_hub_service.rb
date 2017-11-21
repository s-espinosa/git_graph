class GitHubService
  def initialize(user)
    @uid      = user.uid
    @token    = user.token
    @response = github_response
  end

  def username
    response["login"]
  end

  private
  attr_reader :token,
              :response

  def github_response
    resp = Faraday.post do |faraday|
      faraday.url 'https://api.github.com/graphql'
      faraday.body = request_body
      faraday.headers["Authorization"] = "bearer #{token}"
    end
    JSON.parse(resp.body)["data"]["viewer"]
  end

  def request_body
    {query: "query {viewer {login}}"}.to_json
  end
end
