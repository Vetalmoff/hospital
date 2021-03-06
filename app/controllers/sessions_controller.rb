class SessionsController < ApplicationController

  skip_before_action :authenticated?, only: [:new, :create, :welcome]

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to main_page_index_url, notice: "Hello #{@user.name}."
    else
      redirect_to login_url, alert: 'Invalid user/password combination'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to welcome_url
  end

  def welcome

  end
end
