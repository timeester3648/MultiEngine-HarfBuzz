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
		"%{IncludeDir.icu}",
		"%{IncludeDir.harfbuzz}",
		"%{IncludeDir.freetype}"
	}

	defines {
		"HAVE_ICU",
		"HAVE_FREETYPE",
	}

	filter "toolset:msc"
		disablewarnings { "4805" }