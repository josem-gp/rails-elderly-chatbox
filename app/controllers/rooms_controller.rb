class RoomsController < ApplicationController
  def show
    @room = Room.find(params[:id])
    @user = User.find(params[:user_id])
    @shops = Shop.all
    authorize @room
  end
end
