-- METADATA.LUA
local metadata = {}
function metadata.version()
	return "2.12"
end
function metadata.fetch(mirror)
	return {
		url = mirror .. "/gnu/hello/hello-" .. metadata.version() .. ".tar.gz",
		sha256 = "sha256-jZkUKv2SV28wsM18tCqNxoCZmLxdYH2Idh9RLibH2yA=",
	}
end
function metadata.pre_install()
	return "configure"
end
function metadata.post_install()
	return 'echo "done"'
end
function metadata.install()
	return "make install"
end
function metadata.meta()
	return {
		description = "A program that produces a familiar, friendly greeting",
		longDescription = [[
    GNU Hello is a program that prints "Hello, world!" when you run it.
    It is fully customizable.
    ]],
		homepage = "https://www.gnu.org/software/hello/manual/",
		changelog = "https://git.savannah.gnu.org/cgit/hello.git/plain/NEWS?h=v$" .. metadata.version(),
		license = "GPL-3.0-or-later",
		maintainers = { "eikrt" },
		mainProgram = "hello",
		platforms = "all",
	}
end

return metadata
