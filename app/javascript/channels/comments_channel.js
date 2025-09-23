import consumer from "./consumer"

consumer.subscriptions.create(channel:"CommentsChannel", racket_id: document.querySelector('[data-racket-id')?.dataset.racketId {
  connected() {
    console.log("Connected to comments channel")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    console.log("Disconnected from comments channel")
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const commentsContainer = document.getElementById('table-comment')
    if(commentsContainer && data.comment) {
      commentsContainer.insertAdjacentHTML('afterbegin', data.comment)
    }
    // Called when there's incoming data on the websocket for this channel
  }
});
