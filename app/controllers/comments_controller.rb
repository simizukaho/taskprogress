class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    tweet = Tweet.find(params[:tweet_id])
    comment = tweet.comments.build(comment_params)
    comment.user_id = current_user.id
    if comment.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.user_id == current_user.id
      comment.destroy
      redirect_to tweet_path(comment.tweet_id), notice: "コメントを削除しました"
    else
      redirect_to tweet_path(comment.tweet_id), alert: "削除権限がありません"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end
