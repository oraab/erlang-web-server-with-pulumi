.PHONY: init init-user

init: 
	cd init/ && ./init.sh
init-user:
	pulumi up -y --cwd pulumi/erlang_demo_user/
