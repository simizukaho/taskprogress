class TasksController < ApplicationController
before_action :set_tweet
  def create
    @task = @tweet.tasks.build(task_params)
    if @task.save
      redirect_to tweet_path(@tweet), notice: "タスクを追加しました"
    else
      redirect_to tweet_path(@tweet), alert: "タスクの追加に失敗しました"
    end
  end

  def edit
    @task = @tweet.tasks.find(params[:id])
  end
  def update
    @task = @tweet.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to tweet_path(@tweet), notice: "タスクを更新しました"
    else
      redirect_to tweet_path(@tweet), alert: "タスクの更新に失敗しました"
    end
  end

  def destroy
    @task = Task.find(params[:id])
      @task.destroy
      redirect_to tweet_path(@tweet), notice: "タスクを削除しました"
  end

  def update
  @tweet = Tweet.find(params[:tweet_id])
  @task = @tweet.tasks.find(params[:id])
  if @task.update(task_params)
    respond_to do |format|
      format.html { redirect_to tweet_path(@tweet), notice: '更新されました' }
      format.json { render json: { status: 'ok' } }
    end
  else
    respond_to do |format|
      format.html { render :edit }
      format.json { render json: { status: 'error' }, status: :unprocessable_entity }
    end
  end
end

def update
  @task = Task.find(params[:id])
  if @task.update(task_params)
    respond_to do |format|
      format.html { redirect_to @task.tweet }
      format.json { render json: { status: 'ok' } }
    end
  else
    respond_to do |format|
      format.html { render :edit }
      format.json { render json: { status: 'error' }, status: :unprocessable_entity }
    end
  end
end

  private
  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
  def task_params
    params.require(:task).permit(:content, :done)
  end
end

