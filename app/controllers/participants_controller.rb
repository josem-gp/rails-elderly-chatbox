class ParticipantsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @participant = Participant.new
    @rooms = Room.where(name: @user.municipality.match(/(\w*)-/)[1].strip).or(Room.where(room_type: 'public'))
  end

  def create
    @user = User.find(params[:user_id])
    @participant = Participant.new(participant_params)
    @participant.user = @user
    if @participant.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private

  def participant_params
    params.require(:participant).permit(:room_id)
  end
end
