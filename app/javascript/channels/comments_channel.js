import consumer from "./consumer"

document.addEventListener('DOMContentLoaded', function() {
  //constにて変数を定義
  const racketElement = document.querySelector('[data-racket-id]');
  const racketId = racketElement?.dataset.racketId;

 console.log('Racket I:', racketId);
 console.log('Racket Element:', racketElement);

if(racketId) {
  const subscription = consumer.subscriptions.create({
  channel: "CommentsChannel",
  racket_id: racketId
 }, {
  connected() {
    console.log("Connected to comments channel for racket")
    // Called when the subscription is ready for use on the server
  },
//接続が切断された時の処理。デバッグとし記録。
  disconnected() {
    console.log("Disconnected from comments channel")
    // Called when the subscription has been terminated by the server
  },
//データを受け取った時の処理について記載。
  received(data) {
     console.log("Received data:", data); 
     //　リアルタイムでコメントを追加
     //table-commentをracket-idに変更すると投稿がワンクリックで2回コメントが投稿される。
    const commentsContainer = document.getElementById('racket-id')
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
