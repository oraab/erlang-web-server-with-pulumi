# Erlang web server with Pulumi 

This demo erlang web server is using Pulumi to be deployed to AWS and available through an ALB over a set of containers in Fargate ECS.
It includes: 
1. A dedicated VPC and subnets with relevant security group for the ALB
1. ALB and Fargate ECS task for the containers 
1. A dockerized `erlang` application that shows the relevant request information (`host`,`port`,`method`,`scheme`,`version`,`query_params`,
   `headers` excluding `Cookie`,`query_params` (for a `GET` request) and `body` (for a `POST` or `PUT` request)). 

# Prerequisites 
1. You should have the following executables installed on your system in order for the automated processes to run: `pulumi`,`AWS CLI`,`docker engine`,`node.js` and `npm`.  If you don't have them (or not sure), just run `make init` from the root and the script will figure it out and install what's missing. 
1. You should have an AWS IAM user that is capable of creating the required resources for the Pulumi stack. If you don't have one, you can create a user with the relevant permissions using `make init-user`.  Note that you will still need a user that has permissions to create users, groups and policies in IAM configured (either with `AWS_PROFILE` or `aws configure` or with the `AWS_ACCESS_KEY_ID`/`AWS_SECRET_ACCESS_KEY` env variables).  For security purposes the access key and secret key are not created through pulumi and have to be created and retrieved manually from the AWS console and configured before running the actual stack init. 
1. Docker engine needs to be running.  The init script will not attempt to mess with a running docker daemon so this either needs to be up before the init script is running or before the deployment is run.

*Note* that if the `credStore` for docker on your machine is `ecr-login` the stack creation for pulumi will not work (not supported yet) - it needs to be `osxkeychain` for a mac based docker engine. 

# Initialization 
1. Run `make init` if you need to install any of the required executables: `pulumi`, `awcli`, `docker.io`,`nodejs` or `npm`.
1. Run `make init-user` to create a user with relevant permissions on AWS if one is not already configured 
1. Get the `AWS_ACCES_KEY_ID` and `AWS_SECRET_ACCESS_KEY` for the user from the AWS console (these are not exported for security reasons) and either store them in `~/.aws/credentials` and alter to the relevant user profile by setting `AWS_PROFILE`, or set the env variables.

# Deployment 
1. In order to run the application, run `make deploy`.  
1. If everything is set correctly, you will receive the URL to access the application as an output. 
1. Use that URL on a browser or with `curl` to see the results of the application. 

# Testing
Currently available maually through a Postman collection (`examples/erlang_web_server_examples.postman_collection.json`)

# Destroying 
In order to destroy the pulumi stacks, use either `make destroy` (for the application stack) or `make destroy-user` (for the user resources that were created with `init-user`).  Note that these are deliberately not using the auto approval (`-y` flag) so that you have a chance to regret it after initiating the rule. 

# Future improvements 
1. Automated integration and E2E tests
1. Fighting some more with the `jsone` module for erlang so that it can be used for JSON formatting of the response from `cowboy`.
1. Prettifying (?) of the response JSON
