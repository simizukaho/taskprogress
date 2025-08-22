class LikesController < ApplicationController
  before_action :set_tweet
  def create
    @like = @tweet.likes.new(user_id: current_user.id)
    if @like.save
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.turbo_stream
      end
    end
  end

  def destroy
    @like = @tweet.likes.find_by(user_id: current_user.id)
    if @like
      @like.destroy
    end
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.turbo_stream
    end
  end
end

private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end