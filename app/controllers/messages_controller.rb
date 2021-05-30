class MessagesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @message = Message.new
    authorize @message
  end

  def create
    @user = User.find(params[:user_id])
    @room = Room.find(params[:message][:room_id])
    @message = Message.new(message_params)
    @message.user = @user
    @message.room = @room
    authorize @message
    if @message.save
      redirect_to user_path(@user)
    else
      redirect_to user_path(@user) # add an alert to this so the user knows they can't create a message without a shop instance
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
