class GitUser
  attr_reader :login,
              :name,
              :avatar_url,
              :url

  def initialize(user)
    @login      = user["login"]
    @name       = user["name"]
    @avatar_url = user["avatarUrl"]
    @url        = user["url"]
  end
end
