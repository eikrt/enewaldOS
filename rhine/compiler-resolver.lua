package.path = package.path .. ";../utils/?.lua"
utils = require("utils")
local PACKAGES_LOCAL = "/home/eino/repo/enewald/enewaldOS/rhine/packages.local/"
local STORE_LOCATION = "/home/eino/repo/enewald/enewaldOS/rhine/estore/"
compiler_resolver = {}

compiler_resolver.compile_and_install = function(pkg, meta) -- TODO: build-system like in guix
	local cd_prefix = "cd " .. PACKAGES_LOCAL .. pkg .. "-" .. meta["version"] .. "; "
	local pkg_path = pkg .. "-" .. meta["version"] .. "-" .. "xxxx/"
	local store_path = STORE_LOCATION .. pkg_path
	local packages_location = PACKAGES_LOCAL .. pkg .. "-" .. meta["version"]
	local bin_path = store_path .. pkg
	if utils.file_exists(bin_path) then
		print("Binary exists, exiting...")
		return bin_path
	end
	print("Preinstalling...")
	os.execute(cd_prefix .. PACKAGES_LOCAL .. pkg_path .. "/" .. pre_install())
	print("Done")
	print("Installing...")
	os.execute(cd_prefix .. install())
	print("Done")
	print("Postinstalling...")
	os.execute(cd_prefix .. post_install())
	print("Creating directory in estore...")
	os.execute("mkdir " .. store_path)
	os.execute("ln -s " .. packages_location .. "/" .. pkg .. " " .. bin_path)
	print("Done")
	return bin_path
end

compiler_resolver.fetch_src_with_meta = function(pkg, meta)
	require("current.metadata")
	os.execute(
		"wget "
			.. fetch("https://www.nic.funet.fi/pub/gnu/ftp.gnu.org/pub/")["url"]
			.. " -O "
			.. PACKAGES_LOCAL
			.. pkg
			.. "-"
			.. meta["version"]
	)
	os.execute("tar " .. "-xf" .. PACKAGES_LOCAL .. pkg .. "-" .. meta["version"] .. " -C" .. PACKAGES_LOCAL)
end

compiler_resolver.resolve = function(pkg, meta)
	print("Resolving package...")
	print("Resolving package " .. pkg .. " with version " .. meta["version"] .. " with USE-flags " .. meta["use"])
	compiler_resolver.fetch_src_with_meta(pkg, meta)
	return compiler_resolver.compile_and_install(pkg, meta)
end

return compiler_resolver
