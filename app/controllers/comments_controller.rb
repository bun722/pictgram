class CommentsController < ApplicationController
  def new
    @topic = Topic.find_by(params[:topic_id])
    # @comment = Comment.new(user_id: current_user.id)
    # @current_user = User.find_by(id: session[:user_id])
    @comment = Comment.new(
        user_id: current_user.id,
        topic_id: params[:topic_id]
      )
  end
  
  def create
    @comment = current_user.comments.new(comment_params)
    # binding.pry
    if @comment.save
      redirect_to topics_path, success: 'コメント投稿に成功しました'
    else
      flash[:danger] = "コメント投稿に失敗しました"
      # Rails.logger.info(@comment.errors.inspect) 
      render :new
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:user_id, :topic_id, :content)
  end
end
