include "../../premake/common_premake_defines.lua"

project "HarfBuzz"
	kind "StaticLib"
	language "C++"
	cppdialect "C++latest"
	cdialect "C17"
	targetname "%{prj.name}"
	inlining "Auto"

	files {
		"./src/**.h",
		"./src/**.hh",

		"./src/harfbuzz.cc"
	}

	includedirs {
		"%{IncludeDir.harfbuzz}",
		"%{IncludeDir.freetype}"
	}

	defines {
		"HAVE_FREETYPE"
	}

	filter "action:vs*"
		disablewarnings { "4805" }