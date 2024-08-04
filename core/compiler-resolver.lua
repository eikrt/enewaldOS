require("metadata")

local PACKAGES_LOCAL = "/home/eino/repo/enewald/enewald/packages.local/"
local STORE_LOCATION = "/home/eino/repo/enewald/enewald/estore/"

function compile(pkg, meta)
  local cd_prefix = "cd " .. PACKAGES_LOCAL .. pkg .. "-" .. meta["version"] .. "; "
  local pkg_path = pkg .. "-" .. meta["version"]

  local store_path = STORE_LOCATION .. pkg_path .. "-" .. "xxxx/"
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
  print("Done")
  print("Creating symlinks...")
  os.execute("ln -s " .. PACKAGES_LOCAL .. pkg_path .. "/" .. pkg .. " " .. store_path .. pkg)
  print("Done")
end

function fetch_pkg_with_meta(pkg, meta)
  -- TODO: fetch logic
  os.execute("wget " .. fetch("https://www.nic.funet.fi/pub/gnu/ftp.gnu.org/pub/")["url"] .. " -O " .. PACKAGES_LOCAL .. pkg .. "-" .. meta["version"])
  os.execute("tar " .. "-xf" .. PACKAGES_LOCAL .. pkg .. "-" .. meta["version"] .. " -C" .. PACKAGES_LOCAL)
end

function resolve(pkg, meta)
  print("Resolving package...")
  print("Resolving package " .. pkg .. " with version " .. meta["version"] .. " with USE-flags " .. meta["use"])
  fetch_pkg_with_meta(pkg,meta)
  compile(pkg,meta)
end
