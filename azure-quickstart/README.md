[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fprogress%2Fopenedge-demos%2Fazure-quickstart%2Fazure-quickstart%2Fazuredeploy.json
)

This template deploys the infrastructure to run an n-tier OpenEdge application using LoadMaster as a load balancer.

The template uses an image reference for an OpenEdge installation (on Ubuntu 22.04) to create the virtual machine for the OpenEdge database and the virtual machine scale set for PASOE.

The image with the OpenEdge instalation is built outside of this deployment.
