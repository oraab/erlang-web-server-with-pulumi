{application, 'demo_web_server', [
	{description, "New project"},
	{vsn, "0.1.0"},
	{modules, ['demo_web_server_app','demo_web_server_sup','request_data']},
	{registered, [demo_web_server_sup]},
	{applications, [kernel,stdlib,cowboy]},
	{mod, {demo_web_server_app, []}},
	{env, []}
]}.