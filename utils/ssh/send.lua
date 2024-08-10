sender = {}

sender.new = function(args)
  return sender
end
sender.send = function(file, to, user, path)
  print("scp -r " .. file .. " " .. user .. "@" .. to .. ":" .. path)
  os.execute("scp -r " .. file .. " " .. user .. "@" .. to .. ":" .. path )
end


return sender
