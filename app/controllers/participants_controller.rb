class ParticipantsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @participant = Participant.new
    @rooms = Room.where.not(id: @user.room_ids)
    authorize @participant
  end

  def create
    @user = User.find(params[:user_id])
    @room = Room.find(params[:participant][:room_id])
    @participant = Participant.new(participant_params)
    @participant.user = @user
    authorize @participant
    if @participant.save
      redirect_to user_room_path(@user, @room)
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @room = Room.find(params[:room_id])
    @participant = Participant.find_by(user: @user, room: @room)
    @participant.destroy
    authorize @participant
    redirect_to user_path(@user)
  end

  private

  def participant_params
    params.require(:participant).permit(:room_id)
  end
end
