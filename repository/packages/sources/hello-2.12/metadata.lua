-- METADATA.LUA

function version()
  return "2.12"
end
function fetch(mirror)
  return {
    url = mirror .. "/gnu/hello/hello-" .. version() .. ".tar.gz",
    sha256 = "sha256-jZkUKv2SV28wsM18tCqNxoCZmLxdYH2Idh9RLibH2yA=",
  }
end

function build_system()
  return "gnu"
end
function meta()
  return {
    description = "A program that produces a familiar, friendly greeting",
    longDescription = [[
    GNU Hello is a program that prints "Hello, world!" when you run it.
    It is fully customizable.
    ]],
    homepage = "https://www.gnu.org/software/hello/manual/",
    changelog = "https://git.savannah.gnu.org/cgit/hello.git/plain/NEWS?h=v$" .. version(),
    license = "GPL-3.0-or-later",
    maintainers = { "eikrt" },
    mainProgram = "hello",
    platforms = "all"
  }
end
