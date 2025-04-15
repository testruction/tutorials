# Websockets _(Exercise 11 of 17)_

In this adventure, write a websocket client that uses the `ws`{{}}
module, generate a stream on top of the websocket client, write
the string "hello\n" to the stream and pipe it to `process.stdout`{{}}.

To open a stream with `ws`{{}} on localhost:8099, just write:

```js
const WebSocket = require('ws')
const ws = new WebSocket('ws://localhost:8099')
const stream = WebSocket.createWebSocketStream(ws)
```{{copy}}

The readme for `ws`{{}} has more info if you're curious about how to
write the server side code: https://github.com/websockets/ws

Make sure to `npm install ws` in the directory where your solution
file lives.

To verify your solution run:

```sh
stream-adventure verify websockets.js
```{{exec}}