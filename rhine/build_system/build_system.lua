local build_system = {}

build_system.gnu = function()
  return {
    pre_install = function ()
      return "./configure"
    end,
    install = function ()
      return "make install"
    end,
    post_install = function ()
      return "echo done"
    end
  }
end

build_system.custom = function()
end


build_system.select = function(arg) 
    if arg == "gnu" then
      return build_system.gnu
    end
end

return build_system
