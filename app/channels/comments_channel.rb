class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_form "racket_#{params[:racket_id]}_comments"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
