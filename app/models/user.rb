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

  def avatar_url
    service.avatar_url
  end

  def followers
    convert_git_array_to_objects(service.followers, GitUser)
  end

  def following
    convert_git_array_to_objects(service.following, GitUser)
  end

  def starred_repositories
    convert_git_array_to_objects(service.starred_repositories, GitRepo)
  end

  def repositories
    convert_git_array_to_objects(service.repositories, GitRepo)
  end

  def organizations
    convert_git_array_to_objects(service.organizations, GitOrganization)
  end

  private
  def service
    @service ||= GitHubService.new(self)
  end

  def convert_git_array_to_objects(git_array, git_object)
    git_array.map do |git_element|
      git_object.new(git_element["node"])
    end
  end
end
