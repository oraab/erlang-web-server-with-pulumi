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
	      "ecr:CreateRepository"
	      ],
	      Effect: "Allow",
	    Resource: "*"
        },
	{
	    Action: [
	      "iam:Get*",
	      "iam:List*",
	      "iam:Describe*",
	      "iam:AttachRolePolicy",
	      "iam:CreateRole"
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
	      "logs:PutRetentionPolicy"
	    ],
            Effect: "Allow", 
            Resource: "*"
        },
        {
            Action: [
               "ecs:Describe*",
               "ecs:Get*",
               "ecs:List*",
               "ecs:CreateCluster"
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

