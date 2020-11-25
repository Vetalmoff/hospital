class UsersController < ApplicationController

  skip_before_action :authenticated?, only: [:new, :create]

  before_action :authorized?, only: [:index]
  before_action :the_same_user?, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.order(:name)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    @users = User.order(:name)
    if  @users.length === 0
      @user.role = 'admin'
    end

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to main_page_index_url, notice: "User #{@user.name} was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to welcome_url, notice: "User #{@user.name} was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    respond_to do |format|
      @user.destroy
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
    end
  end

  rescue_from 'User::Error' do |exception|
    redirect_to users_url, alert: exception.message
  end

  rescue_from 'Mysql2::Error' do |exception|
    redirect_to users_url, alert: "We are unable to delete the user #{@user.email} because he has some appointments"
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :email, :role)
    end

  def the_same_user?
    redirect_to '/welcome', alert: 'Permission denied' unless is_admin? || current_user.id.to_s == params[:id]
  end
end
