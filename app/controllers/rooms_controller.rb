class RoomsController < ApplicationController
  def show
    @room = Room.find(params[:id])
    @user = User.find(params[:user_id])
    @shops =
    if params[:query]
      Shop.search_by_name_and_address(params[:query])
    else
      Shop.all
    end
    authorize @room
  end
end
