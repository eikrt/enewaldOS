package.path = package.path .. ";../utils/?.lua"
local utils = require("utils")
local compiler_resolver = {}
PACKAGES_LOCAL = os.getenv("PACKAGES_LOCAL")
STORE_LOCATION = os.getenv("STORE_LOCATION")
compiler_resolver.create_profile = function(config)
  print("Creating profile...")
  local profile = "local profile={} profile.targets={ target_" .. config.metadata().id .. "= { username = \"eino\", host = \"localhost\" } } return profile"
  utils.store_string_to_file(STORE_LOCATION .. "/profile_" .. config.metadata().id .. "/profile.lua", profile)
  utils.store_string_to_file("current/profile.lua", profile)
  print("Done.")
  return profile
end

compiler_resolver.create_guide = function(pkg, meta)
  print("Creating guide...")
  print("Done.")
end

compiler_resolver.compile_and_install = function(pkg, meta, config) -- TODO: build-system like in guix
	local cd_prefix = "cd " .. PACKAGES_LOCAL .. pkg .. "-" .. meta["version"] .. "; "
	local hash = utils.hash(pkg .. "-" .. meta["version"])
	local pkg_path = pkg .. "-" .. meta["version"] .. "-" .. hash
	local store_path = STORE_LOCATION .. "/profile_" .. config.metadata().id .. "/" .. pkg_path
	local packages_location = PACKAGES_LOCAL .. pkg .. "-" .. meta["version"]
	local bin_path = store_path .. "/" .. pkg
	if utils.file_exists(bin_path) then
		print("Binary exists, exiting...")
		return bin_path
	end
	print("Preinstalling...")
	os.execute(cd_prefix .. PACKAGES_LOCAL .. pkg_path .. "/" .. metad.pre_install())
	print("Done")
	print("Installing...")
	os.execute(cd_prefix .. metad.install())
	print("Done")
	print("Postinstalling...")
	os.execute(cd_prefix .. metad.post_install())
	print("Creating directory in estore...")
	print(store_path)
	os.execute("mkdir -p " .. store_path)
	os.execute("ln -s " .. packages_location .. "/" .. pkg .. " " .. bin_path)
	print("Done")
	return bin_path
end

compiler_resolver.fetch_src_with_meta = function(pkg, meta)
	metad = require("current.metadata")
	os.execute(
		"wget "
			.. metad.fetch("https://www.nic.funet.fi/pub/gnu/ftp.gnu.org/pub/")["url"]
			.. " -O "
			.. PACKAGES_LOCAL
			.. pkg
			.. "-"
			.. meta["version"]
	)
	os.execute("tar " .. "-xf" .. PACKAGES_LOCAL .. pkg .. "-" .. meta["version"] .. " -C" .. PACKAGES_LOCAL)
end

compiler_resolver.resolve = function(pkg, meta, config)
	print("Resolving package...")
	print("Resolving package " .. pkg .. " with version " .. meta["version"] .. " with USE-flags " .. meta["use"])
	compiler_resolver.fetch_src_with_meta(pkg, meta)
	return compiler_resolver.compile_and_install(pkg, meta, config)
end

return compiler_resolver
