var http = require('http')
var redis = require('redis')
var socketIo = require('socket.io')

var redisSub = redis.createClient(19539, 'pub-redis-19539.us-east-1-4.3.ec2.garantiadata.com', {
  auth_pass: 'lenyt2015'
})
var server = http.createServer()

server.listen(9000)

var io = socketIo.listen(server)
io.sockets.setMaxListeners(0)
var users = {}

var findUserBySession = function (sessionId) {
  for (var id in users) {
    for (var i = 0, l = users[id].sessions.length; i < l; i++) {
      if (users[id].sessions[i] === sessionId) {
        return id
      }
    }
  }
  return -1
}
var emitToUser = function (userId, key, data) {
  users[userId].sockets.forEach(function (socket) {
    socket.emit(key, data)
  })
}

redisSub.on('message', function (where, data) {
  try {
    var parsed = JSON.parse(data)
  } catch (e) {
    return console.error(e)
  }
  if (where === 'sess') {
    if (!users[parsed.user_id]) {
      users[parsed.user_id] = {
        sockets: [],
        sessions: []
      }
    }
    if (users[parsed.user_id].sessions.indexOf(parsed.session) === -1) {
      users[parsed.user_id].sessions.push(parsed.session)
    }
    return
  }
  emitToUser(parsed.recipient_id, 'messageGot', parsed)
// {"recipient_id":2,"recipient_name":"testuser2","sender_id":1,"sender_name":"testuser1","body":"fasgashgash"}
})

io.on('connection', function (socket) {
  socket.on('login', function (session) {
    var userId = findUserBySession(session)
    if (users[userId].sessions.indexOf(socket) === -1) {
      users[userId].sockets.push(socket)
    }
  })
})

redisSub.subscribe('message')
redisSub.subscribe('sess')
