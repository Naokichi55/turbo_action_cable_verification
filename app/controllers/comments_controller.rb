class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    respond_to do |format|
    if comment.save
      comment = Comment.new
      format.html { redirect_to racket_comments_path }
      format.turbo.stream
      # redirect_to racket_path(comment.racket), success: "コメント投稿に成功しました"
    else
      format.html { render: racket, status: unprocessable_enmpty}
      # redirect_to racket_path(comment.racket), danger: "コメント投稿に失敗しました"
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy!
    redirect_to racket_path(comment.racket), success: "コメントを削除しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(racket_id: params[:racket_id])
  end
end
