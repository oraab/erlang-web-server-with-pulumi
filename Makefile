.PHONY: init init-user deploy destroy destroy-user

init: 
	cd init/ && ./init.sh

init-user:
	cd pulumi/erlang_demo_user && npm install
	pulumi stack select dev --cwd pulumi/erlang_demo_user/ 
	pulumi up -y --cwd pulumi/erlang_demo_user/

deploy:
	cd pulumi/erlang_web_server && npm install 
	pulumi stack select dev --cwd pulumi/erlang_demo_user/ 
	pulumi up -y --cwd pulumi/erlang_web_server/

destroy:
	# deliberately not run with auto approval
	pulumi stack select dev --cwd pulumi/erlang_web_server/
	pulumi destroy --cwd pulumi/erlang_web_server/

destroy-user:
	# deliberately not run with auto approval
	pulumi stack select dev --cwd pulumi/erlang_web_server/
	pulumi destroy --cwd pulumi/erlang_demo_user/
