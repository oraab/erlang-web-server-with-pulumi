import * as pulumi from "@pulumi/pulumi";
import * as awsx from "@pulumi/awsx";

// Create a load balancer to listen for requests and route them to the container
let lb = new awsx.lb.NetworkListener("nginx", { port: 80 });

let service = new awsx.ecs.FargateService("nginx", {
    desiredCount: 2,
    taskDefinitionArgs: {
        containers: {
	    nginx: {
	        image: awsx.ecs.Image.fromPath("nginx","./app"),
		memory: 512,
		portMappings: [ lb ],
	    },
	},
    },
});

export const url = lb.endpoint.hostname;
