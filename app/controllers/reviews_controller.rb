class ReviewsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @review = Review.new
    authorize @review
  end

  def create
    @user = current_user
    @review = Review.new(review_params)
    @review.user = @user
    authorize @review
    if @review.save
      redirect_to user_path(@user)
    else
      redirect_to user_path(@user) # add an alert to this so the user knows they can't create a review without a shop instance
    end
  end

  def destroy
    @user = current_user
    @review = review.find(params[:id])
    @room = @review.room
    authorize @review
    @review.destroy
    redirect_to user_room_path(@user, @room)
  end

  private

  def review_params
    params.require(:review).permit(:content, :room_id, :shop_id)
  end
end
