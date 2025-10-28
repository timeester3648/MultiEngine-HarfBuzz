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
}