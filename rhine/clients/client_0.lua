-- CLIENT_X.LUA
-- System configuration
-- Defines a system thoroughly
local configuration = {}

function configuration.metadata()
  return {
    id = 0,
    estore_location = "/home/eino/repo/enewald/enewaldOS/nothung/estore/",
  }
end

function configuration.users()
  return {
    admin = "admin",
    user = "eino",
  }
end

function configuration.boot()
  return {

  }
end

function configuration.packages()
  return {
    hello = {version = "2.12", use = "*"}
  }
end

function configuration.services()
  return {

  }
end

function configuration.ssh_keys()
  return {

  }
end

function configuration.network()
  return {

  }
end

function configuration.hardware()
  return {

  }
end

return configuration
