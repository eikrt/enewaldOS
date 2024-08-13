local sender = {}

sender.new = function(args)
	return sender
end

sender.send_remote = function(file, to, user, path)
	os.execute("scp -r " .. file .. " " .. user .. "@" .. to .. ":" .. path)
end

sender.send_local = function(file, path)
	os.execute("cp -r " .. file .. " " ..  path)
end

return sender
