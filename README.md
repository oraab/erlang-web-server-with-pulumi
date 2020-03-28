# Erlang web server with Pulumi 

This demo erlang web server is using Pulumi to be deployed to AWS through an NLB and deployment of the container to Fargate ECS. 

# Prerequisites 
1. You should have the following executables installed on your system in order for the automated processes to run: `erlang`,`pulumi`,`AWS CLI`,`docker engine`,`node.js` and `npm`.  If you don't have them (or not sure), just run `make init` from the root and the script will figure it out and install what's missing. 
1. You should have an AWS IAM user that is capable of creating the required resources for the Pulumi stack. If you don't have one, you can create a user with the relevant permissions using `make init-user`.  Note that you will still need a user that has permissions to create users, groups and policies in IAM configured (either with `AWS_PROFILE` or `aws configure`).  For security purposes the access key and secret key are not output when the stack is created, you will need to retrieve them manually from the AWS console and configure before running the actual stack init. 
1. Docker engine needs to be running.  The init script will not attempt to mess with a running docker daemon so this either needs to be up before the init script is running or before the deployment is run.

# Deploying the application
1. Run `make deploy`.
1. If everything is set correctly, you will receive the URL to access the application as an output. 
1. Use that URL on a browser or with `curl` to see the results of the application. 
