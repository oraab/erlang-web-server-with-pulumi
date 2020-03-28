import * as pulumi from "@pulumi/pulumi";
import * as aws from "@pulumi/aws";

// Create a new group to contain relevant permissions for erlang web server 
const group = new aws.iam.Group("erlang-demo-group",{});

// Create a policy with relevant permissions for the group and attach it 
const policy = new aws.iam.Policy("erlango-demo-group-policy",{
    policy: JSON.stringify({
        Version: "2012-10-17",
	Statement: [{
	    Action: [
	      "ecr:Get*",
	      "ecr:List*",
	      "ecr:Describe*",
	      "ecr:BatchCheckLayerAvailability",
	      "ecr:CompleteLayerUpload",
	      "ecr:CreateRepository",
	      "ecr:UploadLayerPart",
	      "ecr:DeleteRepository",
	      "ecr:DeleteLifecyclePolicy",
	      "ecr:InitiateLayerUpload",
	      "ecr:PutImage",
	      "ecr:PutLifecyclePolicy"
	      ],
	      Effect: "Allow",
	    Resource: "*"
        },
	{
	    Action: [
	      "iam:*"
	    ],
            Effect: "Allow", 
	    Resource: "*"
	},
	{
        Action: [
	      "logs:Describe*",
	      "logs:Get*",
	      "logs:List*",
	      "logs:CreateLogGroup",
	      "logs:DeleteLogGroup",
	      "logs:PutRetentionPolicy"
	    ],
            Effect: "Allow", 
            Resource: "*"
        },
    {
        Action: [
	      "kms:CreateGrant"
	    ],
        Effect: "Allow", 
        Resource: "*"
    },
    {
        Action: [
           "ecs:Describe*",
           "ecs:Get*",
           "ecs:List*",
           "ecs:DiscoverPollEndpoint",
           "ecs:CreateService",
           "ecs:UpdateService",
           "ecs:DeleteService",
           "ecs:CreateCluster",
           "ecs:DeleteCluster",
           "ecs:Poll",
           "ecs:PutAccountSetting",
           "ecs:PutAttributes",
           "ecs:RegisterContainerInstance",
           "ecs:StartTask",
           "ecs:RunTask",
           "ecs:StopTask",
           "ecs:SubmitContainerStateChange",
           "ecs:SubmitTaskStateChange",
           "ecs:RegisterContainerInstance",
           "ecs:RegisterTaskDefinition",
           "ecs:DeregisterTaskDefinition"
    	],
        Effect: "Allow",
        Resource: "*"
		}]
    })
});

const policyAttachment = new aws.iam.PolicyAttachment("erlang-demo-group-policy-attachment",{
    groups: [group],
    policyArn: policy.arn
});

const ec2PolicyAttachment = new aws.iam.PolicyAttachment("erlang-demo-group-ec2-policy-attachment",{
    groups: [group],
    policyArn: aws.iam.AmazonEC2FullAccess
});

// Create a new user and attach it to the group 
const user = new aws.iam.User("erlang-demo-user",{});
const group_membership = new aws.iam.UserGroupMembership("erlang-demo-group-membership",{
    groups: [group.name],
    user: user.name,
});

