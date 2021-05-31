class MessagesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @message = Message.new
    authorize @message
  end

  def create
    @user = current_user
    @message = Message.new(message_params)
    @message.user = @user
    authorize @message
    if @message.save
      redirect_to user_path(@user)
    else
      redirect_to user_path(@user) # add an alert to this so the user knows they can't create a message without a shop instance
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id, :shop_id)
  end
end
