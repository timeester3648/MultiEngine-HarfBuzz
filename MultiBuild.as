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

		// Note: HarfBuzz
		"./src/harfbuzz.cc",

		// Note: HarfBuzz-GPU
		"./src/hb-gpu.cc",
		"./src/hb-gpu-draw.cc",
		"./src/hb-gpu-paint.cc",

		// Note: HarfBuzz-subset
		// "./src/OT/Var/VARC/VARC.cc", 	// already in base .cc
		// "./src/hb-number.cc",			// already in base .cc
		//"./src/hb-ot-cff1-table.cc",		// already in base .cc
		//"./src/hb-ot-cff2-table.cc",		// already in base .cc
		// "./src/hb-static.cc",			// already in base .cc
		"./src/hb-subset-cff-common.cc",
		"./src/hb-subset-cff1.cc",
		"./src/hb-subset-cff2.cc",
		"./src/hb-subset-input.cc",
		"./src/hb-subset-instancer-iup.cc",
		"./src/hb-subset-instancer-solver.cc",
		"./src/hb-subset-plan.cc",
		"./src/hb-subset-plan-layout.cc",
		"./src/hb-subset-plan-var.cc",
		"./src/hb-subset-serialize.cc",
		"./src/hb-subset-table-layout.cc",
		"./src/hb-subset-table-var.cc",
		"./src/hb-subset-table-cff.cc",
		"./src/hb-subset-table-color.cc",
		"./src/hb-subset-table-other.cc",
		"./src/hb-subset.cc",
		"./src/graph/gsubgpos-context.cc",
		
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