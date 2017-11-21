class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    @user = User.create_from_auth(auth_hash)
    redirect_to user_path(@user)
  end

end
