.PHONY: init init-user

init: 
	cd init/ && ./init.sh
init-user:
	cd pulumi/erlang_demo_server && npm install
	pulumi up -y --cwd pulumi/erlang_demo_user/
