class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @default_icon = Icon.find(@user.icon.id)
    @icons = Icon.where.not(id: @default_icon).order('name DESC')
    @event = Event.new
    @message = Message.new
    @shops = Shop.all
    @markers = @shops.geocoded.map do |shop|
      {
        lat: shop.latitude,
        lng: shop.longitude,
        info_window: render_to_string(partial: "info_window", locals: { shop: shop }),
        id: shop.id,
        marker: render_to_string(partial: "marker", locals: { shop: shop })
      }
    end
    authorize @user
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = current_user
    @icon = Icon.find(params[:icon_id])
    @user.icon = @icon
    @user.save
    redirect_to user_path(@user)
    authorize @user
  end
end
