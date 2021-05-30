class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @default_icon = Icon.find(@user.icon.id)
    @icons = Icon.where.not(id: @default_icon)
    @message = Message.new
    @shops = Shop.all
    @markers = @shops.geocoded.map do |shop|
      {
        lat: shop.latitude,
        lng: shop.longitude
      }
    end
    authorize @user
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    @icon = Icon.find(params[:icon_id])
    # @user.icon = @icon
    # @user.update(icon: @icon)
    redirect_to user_path(@user)
    authorize @user
  end
end
