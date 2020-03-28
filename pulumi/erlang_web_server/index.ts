import * as pulumi from "@pulumi/pulumi";
import * as aws from "@pulumi/aws";
import * as awsx from "@pulumi/awsx";


let vpc = new awsx.ec2.Vpc("prod-vpc", {
	cidrBlock: "172.20.0.0/16",
	numberOfAvailabilityZones: 2,
	subnets: [{ type: "public" }],
});

let sg = new awsx.ec2.SecurityGroup("prod-sg", { vpc });

sg.createIngressRule("app-server-http-access", {
    location: new awsx.ec2.AnyIPv4Location(),
    ports: new awsx.ec2.TcpPorts(8080),
    description: "allow web service HTTP access from anywhere",
});

sg.createIngressRule("generic-http-access", {
    location: new awsx.ec2.AnyIPv4Location(),
    ports: new awsx.ec2.TcpPorts(80),
    description: "allow generic HTTP access from anywhere",
});

sg.createEgressRule("outbound-access", {
    location: new awsx.ec2.AnyIPv4Location(),
    ports: new awsx.ec2.AllTcpPorts(),
    description: "allow outbound access to anywhere",
});

let cluster = new awsx.ecs.Cluster("prod-cluster",{ vpc });

// Create a load balancer to listen for requests and route them to the container
let lb = new awsx.lb.ApplicationListener("demo-web-server", { port: 8080, vpc: vpc});

let service = new awsx.ecs.FargateService("demo-web-server", {
	cluster,
    desiredCount: 2,
    taskDefinitionArgs: {
        containers: {
		    demo_web_server: {
		        image: awsx.ecs.Image.fromPath("demo-web-server","../../demo_web_server"),
				memory: 512,
				portMappings: [ lb ],
		    },
		},
    },
});

let hostname = lb.endpoint.hostname;
export const url = pulumi.all([hostname]).apply(([hostname]) => `http://${hostname}:8080`) 
