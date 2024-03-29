# Running the container sample application for PASOE
	
### Prerequisites:
* To run using Docker:
    * Machine running Ubuntu Server 18.04 LTS or greater (2 vCPUs, 4 GiB memory, 20 GiB storage)
    * Docker Engine
* To run using Podman:
    * Machine running Ubuntu Server 22.04 LTS (2 vCPUs, 4 GiB memory, 20 GiB storage)
    * (Scripts install Podman if a docker executable is not found on the machine)
* OpenEdge media: PROGRESS_OE_12.2.9_LNX_64.tar.gz (ESD download)
* PAS for OpenEdge container image and deploy scripts: PROGRESS_PASOE_CONTAINER_IMAGE_12.2.9_LNX_64.zip (ESD download)
* response.ini with your control codes for OpenEdge (you can use the reponse.ini include with the scripts as a template)

These scripts have been tested using using a virtual machine running on AWS, Azure, and VirtualBox with Vagrant.

### Tested Platforms
|              | Docker           | Podman |
| ------------ | ---------------- | ------------ |
| AWS          | Cloud9 instance with Ubuntu 18.04 LTS | Ubuntu Server 22.04 LTS |
| Azure        |  | Ubuntu Server 22.04 LTS |
| VirtualBox/Vagrant   |   | ubuntu/jammy64 |


### Steps
1. Copy the following files to folder ~/Downloads on the virtual machine:
    * PROGRESS_OE_12.2.9_LNX_64.tar.gz
    * PROGRESS_PASOE_CONTAINER_IMAGE_12.2.9_LNX_64.zip
    * response.ini
    * Notes:
        * Environment variables S3_BUCKET and WEBFILES can be set to copy these files from either an S3 bucket or from an HTTP server respectively.
        * In practice, you can use a Repository Manager to host these files and use it from within your environment.

2. Clone the openedge-demos repository.
~~~
git clone https://github.com/progress/openedge-demos.git
~~~

3. Change to folder ~/openedge-demos/pasoe_sample_app_using_scripts. ( ~/openedge-demo/environment/pasoe_sample_app_using_scripts if using Cloud9 )
~~~
cd ~/openedge-demos/pasoe_sample_app_using_scripts
~~~

4. The scripts have code to determine the IP address of the virtual machine. In some cases, you might need to edit the script run-pasoe-sample-app.sh and set PUBLIC_IP_ADDRESS and PRIVATE_IP_ADDRESS to point to your environment.

5. Run script ./install-demo.sh from the pasoe_sample_app_using_scripts folder.
~~~
./install-demo.sh
~~~

The script will take few minutes to run.
After the command prompt returns, you can use htop to monitor the CPU activity and wait for it to settle to see when the services are ready.

6. Run ./test.sh to verify that the services are running.
~~~
./test.sh
~~~

You can open access to ports 8811 and 8080 for the virtual machine to access the PASOE service and the sample app via a web browser:
1. Access https://<PUBLIC_IP_ADDRESS>:8811 so you can accept the self signed certificate used by the PASOE service.
2. Access http://<PUBLIC_IP_ADDRESS>:8080 to load the sample application.

You should be able to see a Kendo UI Grid showing data from the customer table from a sample OpenEdge database.

**Notes:**
* The scripts automate the steps listed in the following article:
    * https://community.progress.com/s/question/0D54Q00007pHA0KSAW/use-the-container-image-for-pas-for-openedge-122x-or-125-with-a-sample-application
* The scripts are implemented in a way that they can be run more than once without issues. They are intended to set the desired state of having the PASOE sample application running.
* The scripts would use Docker if it is already installed on the machine. Otherwise, it would attempt to install Podman from the main repository for Ubuntu.
* The deploy scripts for PASOE (included in zip file from ESD) use Docker. The Podman compatibility makes it possible to work with minor changes. Namely, changing short container image names to point to docker.io.
