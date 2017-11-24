class GitOrganization
  attr_reader :name,
              :url

  def initialize(org)
    @name = org["name"]
    @url  = org["url"]
  end
end
