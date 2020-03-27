.PHONY: init-user

init-user:
	pulumi up -y --cwd pulumi/erlang_demo_user/
