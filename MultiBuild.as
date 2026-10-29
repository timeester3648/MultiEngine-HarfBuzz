void main(MultiBuild::Workspace& workspace) {	
	auto project = workspace.create_project(".");
	auto properties = project.properties();

	project.name("HarfBuzz");
	properties.binary_object_kind(MultiBuild::BinaryObjectKind::eStaticLib);
	project.license("./COPYING");
	properties.tags({ "use_header_only_mle", "utf8" });

	properties.project_includes("FreeType");

	project.include_own_required_includes(true);
	project.add_required_project_include({
		"./src"
	});

	properties.include_directories("./config");

	properties.files({
		"./src/**.h",
		"./src/**.hh",

		"./src/harfbuzz.cc",

		"./src/hb-gpu.cc",
		"./src/hb-gpu-draw.cc",
		"./src/hb-gpu-paint.cc",

		"./config/config.cc"
	});

	properties.defines({
		"HAVE_FREETYPE",
		"HAVE_CONFIG_H",
		"HAVE_FT_GET_VAR_BLEND_COORDINATES"
	});

	{
		MultiBuild::ScopedFilter _(project, "project.compiler:VisualCpp");
		properties.disable_warnings({ "4805", "4267", "4244", "4996" });
	}

	properties.pre_build_commands("{:copy_file:} \"{:project.root}/src/hb-gpu-vertex.glsl\" \"{:workspace.root}/resources/shaders/MultiEngine/general/vector/harfbuzz/hb-gpu-vertex.glsl\"");
	properties.pre_build_commands("{:copy_file:} \"{:project.root}/src/hb-gpu-fragment.glsl\" \"{:workspace.root}/resources/shaders/MultiEngine/general/vector/harfbuzz/hb-gpu-fragment.glsl\"");
	properties.pre_build_commands("{:copy_file:} \"{:project.root}/src/hb-gpu-draw-fragment.glsl\" \"{:workspace.root}/resources/shaders/MultiEngine/general/vector/harfbuzz/hb-gpu-draw-fragment.glsl\"");
	properties.pre_build_commands("{:copy_file:} \"{:project.root}/src/hb-gpu-paint-fragment.glsl\" \"{:workspace.root}/resources/shaders/MultiEngine/general/vector/harfbuzz/hb-gpu-paint-fragment.glsl\"");
}