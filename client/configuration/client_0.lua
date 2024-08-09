-- CLIENT_X.LUA
-- System configuration
-- Defines a system thoroughly
local configuration = {}

function configuration.users()
  return {
    admin = "",
    user = "",
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
