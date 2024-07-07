void main(MultiBuild::Workspace& workspace) {	
	auto project = workspace.create_project(".");
	auto properties = project.properties();

	project.name("HarfBuzz");
	properties.binary_object_kind(MultiBuild::BinaryObjectKind::eStaticLib);
	project.license("./COPYING");

	properties.project_includes({
		"icu",
		"FreeType"
	});

	project.include_own_required_includes(true);
	project.add_required_project_include({
		"./src"
	});

	properties.files({
		"./src/**.h",
		"./src/**.hh",

		"./src/hb-icu.cc",
		"./src/harfbuzz.cc"
	});

	properties.defines({
		"HAVE_ICU",
		"HAVE_FREETYPE",
		"HAVE_FT_GET_VAR_BLEND_COORDINATES"
	});

	{
		MultiBuild::ScopedFilter _(workspace, "project.compiler:VisualCpp");
		properties.disable_warnings({ "4805", "4267", "4244", "4996" });
	}
}