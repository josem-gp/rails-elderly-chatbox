class EventsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @event = Event.new
    authorize @event
  end

  def create
    @user = current_user
    @event = Event.new(event_params)
    @event.user = @user
    authorize @event
    if @event.save
      redirect_to user_path(@user)
    else
      redirect_to user_path(@user) # add an alert to this so the user knows they can't create a event without a shop instance
    end
  end

  def destroy
    @user = current_user
    @event = Event.find(params[:id])
    @room = @event.room
    authorize @event
    @event.destroy
    redirect_to user_room_path(@user, @room)
  end

  private

  def event_params
    params.require(:event).permit(:content, :room_id)
  end
end
