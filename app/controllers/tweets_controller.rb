class TweetsController < ApplicationController
  before_action :authenticate_user!  #, only: [:new, :create]


  def index
    @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(6)
  end

  #def index
  #      @tweets = Tweet.all
  #end


  def new
    @tweet = Tweet.new
  end

  def create
  @tweet = current_user.tweets.build(tweet_params)
  if @tweet.save
    redirect_to tweets_path, notice: "投稿が完了しました！"
  else
    render :new
  end
end

 # def create
 #   @tweet = Tweet.new(tweet_params)
 #   @tweet.user_id = current_user.id
 #   if @tweet.save
 #     redirect_to action: "index"
 #   else
 #     redirect_to action: "new"
 #   end
 # end
#  def create
#    tweet = Tweet.new(tweet_params)
#    tweet.user_id = current_user.id
#    if tweet.save!
#      redirect_to :action => "index"
#    else
#      redirect_to :action => "new"
#    end
#  end
  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments
    @comment = Comment.new
    @tasks = @tweet.tasks
  end
  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
  @tweet = Tweet.find(params[:id])
  if @tweet.update(tweet_params)
    respond_to do |format|
      format.html { redirect_to @tweet, notice: "更新されました" }
      format.json { render json: { status: "ok" }, status: :ok }
      format.turbo_stream
    end
  else
    respond_to do |format|
      format.html { render :edit }
      format.json { render json: { status: "error" }, status: :unprocessable_entity }
    end
  end
end

  #def update
  #  tweet = Tweet.find(params[:id])
  # comments = tweet.comments
  #  if tweet.update(tweet_params)
  #    redirect_to :action => "show", :id => tweet.id
  #  else
  #    redirect_to :action => "new"
  #  end
  #end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to fallback_location: tweets_path, notice: "ツイートを削除しました"
  end


#  def destroy
#    tweet = Tweet.find(params[:id])
#    tweet.destroy
#    # ここが「削除後にどこに飛ばすか」の設定！
#    redirect_to fallback_location: tweets_path, notice: "ツイートを削除しました"
#  end


  def correct_user
  @tweet = Tweet.find(params[:id])
  unless current_user == @tweet.user
    redirect_to tweets_path, alert: "権限がありません"
  end
  end
#def index
#  @tweets = Tweet.order(created_at: :desc)
#end

#def update
#  @tweet = Tweet.find(params[:id])
#  if @tweet.update(tweet_params)
#    respond_to do |format|
#      format.html { redirect_to @tweet, notice: "更新されました" }
#      format.json { render json: { status: "ok" } }
#      format.json { render json: { status: 'ok' } }
#    end
#  else
#    respond_to do |format|
#      format.html { render :edit }
#      format.json { render json: { status: 'error' }, status: :unprocessable_entity }
#    end
#  end
#end

  private
  def tweet_params
    params.require(:tweet).permit(:name, :title, :user_id)
  end
end