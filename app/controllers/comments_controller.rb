class CommentsController < ApplicationController
  def create
    @racket = Racket.find(params[:racket_id])
    @comment = current_user.comments.build(comment_params)
    @comment.user = current_user
    # @comment.save
    # @comment.broadcast_prepend_later_to("comments_channel")
    #turboを使用するために以下を変更
    # comment = current_user.comments.build(comment_params)

        if @comment.save
          ActionCable.server.broadcast(
            "racket_#{@racket.id}_comments",
            {
              comment: render_to_string(
                partial: 'comments/comment',
                locals: { comment: @comment }
              )
            }
          )
        respond_to do |format| #リクエストされる処理を分けるメソッド
          format.turbo_stream do #turbo_streamのリクエストが来た際の処理
            # table-commentをracket-idに変更すると投稿がワンクリックで2こ反映される。
            render turbo_stream: [
              turbo_stream.prepend("table-comment", partial: "comments/comment", locals: { comment: @comment}),
              turbo_stream.replace("comment-form", partial: "comments/form", locals: { comment: Comment.new, racket: @racket})
            ]
          end
          format.html { redirect_to @racket}
        end
      else
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace("comment-form", partial: "comments/form", locals: { comment: @comment, racket: @racket })
          end
        #   @comment = Comment.new
        # format.html { redirect_to racket_comments_path }
        # format.turbo_stream
        # # redirect_to racket_path(comment.racket), success: "コメント投稿に成功しました"
        # else
        #   format.html{ render :comment, status: :unprocessable_empty }
        #   # redirect_to racket_path(comment.racket), danger: "コメント投稿に失敗しました"
        end
      end
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
