class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
    #turboを使用するために以下を変更
    # comment = current_user.comments.build(comment_params)
    #   if comment.save
    #     comment = Comment.new
    #     format.html { redirect_to racket_comments_path }
    #     format.turbo_stream
    #     # redirect_to racket_path(comment.racket), success: "コメント投稿に成功しました"
    #   else
    #     format.html{ render :comment, status: :unprocessable_empty }
    #     # redirect_to racket_path(comment.racket), danger: "コメント投稿に失敗しました"
    #   end
  end

  def destroy
  @comment = current_user.comments.find(params[:id])
  @comment.destroy!
    # comment = current_user.comments.find(params[:id])
    # comment.destroy!
    # redirect_to racket_path(comment.racket), success: "コメントを削除しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(racket_id: params[:racket_id])
  end
end
