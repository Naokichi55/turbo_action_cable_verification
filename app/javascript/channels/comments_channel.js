import consumer from "./consumer"

document.addEventListener('DOMContentLoaded', function() {
  const racketElement = document.querySelector('[data-racket-id]');
  const racketId = racketElement?.dataset.racketId;

 console.log('Racket I:', racketId);
 console.log('Racket Element:', racketElement);

if(racketID) {
  const subscription = consumer.subscriptions.create({
  channel: "CommentsChannel",
  racket_id: racketId
 }, {
  connected() {
    console.log("Connected to comments channel for racket")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    console.log("Disconnected from comments channel")
    // Called when the subscription has been terminated by the server
  },

  received(data) {
     console.log("Received data:", data); 
     //　リアルタイムでコメントを追加
    const commentsContainer = document.getElementById('table-comment')
    console.log("Comments container:", commentsContainer);

    if(commentsContainer && data.comment) {
      commentsContainer.insertAdjacentHTML('afterbegin', data.comment);
      console.log("Comment add successfully")
    }else{
     console.error("Comments container not found or no comment data");
    }
  }
  });
}else{
  console.log("No racket ID found, skipping WebSocket connection");
  }
    // Called when there's incoming data on the websocket for this channel
});
