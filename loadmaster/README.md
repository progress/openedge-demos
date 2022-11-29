# Using PAS for OpenEdge with LoadMaster

### Prerequisites:
* Windows machine (host machine)
* VirtualBox 6.1
* Vagrant
* Vagrant box with openedge-12.6.0 (see openedge-12.6.0 demo for instructions)
* LoadMaster environment configured with access to the RESTful API
    * API key
* lm_apikey.txt: Text file with API key for LoadMaster 

Note: If running on a Linux machine, you can change the synced_folder for /files to point a Linux folder instead of c:/files.

## Steps
0. Run demo openedge-12.6.0 to create a Vagrant box for OpenEdge 12.6.

1. Configure Virtual Services and SubVSs in LoadMaster to demonstrate Blue/Green deployment.

2. Copy the following files to folder c:\files on the host machine:
* lm_apikey.txt

3. Clone the openedge-demos repository to your repository folder:
~~~
git clone https://github.com/progress/openedge-demos.git
~~~

4. Change to folder openedge-demos/openedge-12.6.0:
~~~
cd openedge-demos/loadmaster
~~~

5. Create infrastructure for the PASOE with LoadMaster demo:
~~~
vagrant up
~~~

6. Run test to detect whether "Blue Env" or "Green Env" is active:
~~~
vagrant ssh oedb -c "/vagrant/files/test.sh"
~~~

Note: You can use CTRL-C to stop the test program.

7. Demonstration of Blue/Green Deployment. Modify the status of the SubVSs for the Production environment to enable the "Green" env and disable the "Blue" env. The test program will show "Green Env".

The production traffic has been routed to the new environment.

The previous enviroment can be kept for a while in case that changes need to be rolled back. Rolling back is as simple as re-enabling the "Blue" env and disabling the "Green" env.
