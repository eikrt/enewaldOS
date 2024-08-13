package.path = package.path .. ";../utils/?.lua"
local build_system = require("build_system.build_system")
local utils = require("utils")
local compiler_resolver = {}
PACKAGES_LOCAL = os.getenv("PACKAGES_LOCAL")
STORE_LOCATION = os.getenv("STORE_LOCATION")
REPOSITORY_URL = os.getenv("REPOSITORY_URL")
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

compiler_resolver.compile_and_install = function(pkg, meta, config)
	local cd_prefix = "cd " .. PACKAGES_LOCAL .. pkg .. "-" .. meta["version"] .. "; "
	local hash = utils.hash(pkg .. "-" .. meta["version"])
	local pkg_path = pkg .. "-" .. meta["version"] .. "-" .. hash
	local store_path = STORE_LOCATION .. "/profile_" .. config.metadata().id .. "/" .. pkg_path
	local packages_location = PACKAGES_LOCAL .. pkg .. "-" .. meta["version"]
	local bin_path = store_path .. "/" .. pkg
  local bsystem = build_system.select(recipe.build_system())
	if utils.file_exists(bin_path) then
		print("Binary exists, exiting...")
		return bin_path
	end
	print("Preinstalling...")
	os.execute(cd_prefix .. bsystem().pre_install())
	print("Done")
	print("Installing...")
	os.execute(cd_prefix .. bsystem().install())
	print("Done")
	print("Postinstalling...")
	os.execute(cd_prefix .. bsystem().post_install())
	print("Creating directory in estore...")
	print(store_path)
	os.execute("mkdir -p " .. store_path)
	os.execute("ln -s " .. packages_location .. "/" .. pkg .. " " .. bin_path)
	print("Done")
	return bin_path
end

compiler_resolver.fetch_src_with_meta = function(pkg, meta)
	recipe = require("current.recipe")
	os.execute(
		"wget "
    .. recipe.fetch("https://www.nic.funet.fi/pub/gnu/ftp.gnu.org/pub/")["url"]
    .. " -O "
    .. PACKAGES_LOCAL
    .. pkg
    .. "-"
    .. meta["version"]
	)
	os.execute("tar " .. "-xf" .. PACKAGES_LOCAL .. pkg .. "-" .. meta["version"] .. " -C" .. PACKAGES_LOCAL)
end
compiler_resolver.fetch_recipe = function(pkg,meta)
  print("Fetching recipe...")
  print("wget " .. REPOSITORY_URL .. "/packages/sources/".. pkg .. meta["version"] .. "/recipe.lua" .. " -O " .. "current/recipe.lua")
  os.execute("wget " .. REPOSITORY_URL .. "/packages/sources/".. pkg .. "-" .. meta["version"] .. "/recipe.lua" .. " -O " .. "current/recipe.lua")
  print("Done.")
end
compiler_resolver.resolve = function(pkg, meta, config)
	print("Resolving package...")
	print("Resolving package " .. pkg .. " with version " .. meta["version"] .. " with USE-flags " .. meta["use"])
  compiler_resolver.fetch_recipe(pkg,meta)
	compiler_resolver.fetch_src_with_meta(pkg, meta)
	return compiler_resolver.compile_and_install(pkg, meta, config)
end

return compiler_resolver
