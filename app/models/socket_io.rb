class SocketIo
  def self.emit (message, data)
    $redis.publish('message', {action: 'emit', event: message, data: data}.to_json)
  end

  def self.send (user_id, message, data)
    $redis.publish('message', {action: 'send', user: user_id, event: message, data: data}.to_json)
  end
end