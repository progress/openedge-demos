# OpenEdge 12.6.0 Environment

### Prerequisites:
* Windows machine (host machine)
* VirtualBox 6.1
* Vagrant
* OpenEdge 12.6 media: PROGRESS_OE_12.6_LNX_64.tar.gz (ESD download)
* response_12.6.ini: respose.ini file with your control codes for OpenEdge used for silent install (you can use the reponse.ini include with the scripts as a template)

Note: If running on a Linux machine, you can change the synced_folder for /files to point a Linux folder instead of c:/files.

## Steps

1. Copy the following files to folder c:\files on the host machine:
* PROGRESS_OE_12.6_LNX_64.tar.gz
* response_12.6.ini

2. Clone the openedge-demos repository:
~~~
git clone https://github.com/progress/openedge-demos.git
~~~

3. Change to folder openedge-demos/openedge-12.6.0:
~~~
cd openedge-demos/openedge-12.6.0
~~~

4. Create infrastructure for an OpenEdge 12.6 VM:
~~~
vagrant up
~~~

5. Package the Virtual Machine for OpenEdge 12.6:
~~~
vagrant package
~~~

Alternatively, you can use `vagrant package --output openedge-12.6.0.box` to specify a name for the package if you want to backup the file.

6. Add the package for OpenEdge 12.6 as a box to Vagrant:
~~~
vagrant box add -f --name openedge-12.6.0 package.box
~~~

You can now use "openedge-12.6.0" as a box in a Vagrantfile.
In particular, this box is required by the loadmaster demo.

This OpenEdge 12.6.0 environment is used to create the OpenEdge 12.6.0 Vagrant box. 
You can use this environment to either:
* use OpenEdge in the VM (`vagrant ssh`)
* stop the VM to use it later (`vagrant halt` or `vagrant suspend`)
* or destroy the configuration if it is not longer needed (`vagrant destroy`). You can always use `vagrant up` to re-create it.
