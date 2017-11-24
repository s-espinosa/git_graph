class GitHubService
  def initialize(user)
    @uid      = user.uid
    @token    = user.token
    @response = github_response
  end

  def username
    response["login"]
  end

  def avatar_url
    response["avatarUrl"]
  end

  def followers
    response["followers"]["edges"]
  end

  def following
    response["following"]["edges"]
  end

  def repositories
    response["repositories"]["edges"]
  end

  def starred_repositories
    response["starredRepositories"]["edges"]
  end

  def organizations
    response["organizations"]["edges"]
  end

  private
  attr_reader :token,
              :response

  def github_response
    resp = Faraday.post do |faraday|
      faraday.url 'https://api.github.com/graphql'
      faraday.headers["Authorization"] = "bearer #{token}"
      faraday.body = request_body
    end
    JSON.parse(resp.body)["data"]["viewer"]
  end

  def request_body
    {query: "query
      {viewer
        {login
         avatarUrl
         followers (first: 100)
           { edges
             { node
               { login
                 name
                 avatarUrl
                 url
               }
             }
           }
         following (first: 100)
           { edges
             { node
               { login
                 name
                 avatarUrl
                 url
               }
             }
           }
         starredRepositories (first: 100)
           { edges
             { node
               { name
                 url
               }
             }
           }
         repositories (first: 100)
           { edges
             { node
               { name
                 url
               }
             }
           }
         organizations (first: 100)
           { edges
             { node
               { name
                 url
               }
             }
           }
         }
       }"
    }.to_json
  end
end
