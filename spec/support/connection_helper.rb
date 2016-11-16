def connect
  Fishbowl::Connection.connect
end

def configure(configuration = {})
  Fishbowl.configure do |config|
    config.host = configuration[:host]
    config.username = configuration[:username]
    config.password = configuration[:password]
    config.port = configuration[:port]
  end

end

def configure_and_connect(configuration = {})
  configure(configuration)
  connect
end
