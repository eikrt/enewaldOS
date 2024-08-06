-- CLIENT_X.LUA
-- System configuration
-- Defines a system thoroughly

function users()
  return {
    admin = "",
    user = "",
  }
end

function boot()
  return {

  }
end

function packages()
  return {
    hello = {version = "2.12", use = "*"}
  }
end

function services()
  return {

  }
end

function ssh_keys()
  return {

  }
end

function network()
  return {

  }
end

function hardware()
  return {

  }
end
