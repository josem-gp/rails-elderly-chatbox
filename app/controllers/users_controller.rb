class UsersController < ApplicationController
  def index
    @users = User.last(8)
  end

  def show
    @user = User.find(params[:id])
    @default_icon = Icon.find(@user.icon.id)
    @icons = Icon.where.not(id: @default_icon)
    @message = Message.new
    authorize @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :age, :municipality, :alias)
  end
end
