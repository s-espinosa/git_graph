class User < ApplicationRecord
  def self.create_from_auth(auth_hash)
    if User.find_by(uid: auth_hash["uid"])
      user = User.find_by(uid: auth_hash["uid"])
      user.update(token: auth_hash["credentials"]["token"])
      user
    else
      User.create(uid: auth_hash["uid"],
                  token: auth_hash["credentials"]["token"]
                 )
    end
  end

  def username
    service.username
  end

  private
  def service
    @service ||= GitHubService.new(self)
  end
end
