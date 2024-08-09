function adapter(pkg, pkg_path, store_path)
  print("Creating symlinks...")
  os.execute("ln -s " .. PACKAGES_LOCAL .. pkg_path .. "/" .. pkg .. " " .. store_path .. pkg)
  print("Done")
end


function transfer_to_filesystem(payload)
  
end
