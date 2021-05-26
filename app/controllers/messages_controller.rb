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
    if @message.save
      redirect_to user_path(@user)
    else
      render '/users/index'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
