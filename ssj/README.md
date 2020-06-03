# SSJ Demo

## Requirements 

* OpenEdge 12.x

This version of the SSJ Demo code uses OpenEdge 12 and has been tested with OpenEdge 12.2.
The scripts are provided to run on a Linux environment.

You can run the ABL code on Linux, UNIX and Windows.

## Running the Demo Code

Use the following steps to setup the demo and run the demo code:
1) Run proenv to setup the environment for OpenEdge. The proenv command changes directory to $WRKDIR. You may create a separate folder to run the demo is you prefer.
Example:  
```/psc/122/dlc/bin/proenv```

2) Run script create_db.sh to create a copy of the sports2020 database and increase the number of records in customer, order and orderline tables.  
Example:  
```~/openedge-demos/ssj/create_db.sh```

3) Run script test_nossj.sh to show the performance running without the SSJ functionality.  
Example:  
```~/openedge-demos/ssj/test_nossj.sh```

4) Run script test_ssj.sh to show the performance running with the SSJ functionality. You will see that the query runs much faster.  
Example:  
```~/openedge-demos/ssj/test_ssj.sh```
  
**Notes:**
* The scripts are configured in a way that they can run using an absolute path to the Git project. Alternatively, you can copy the scripts to your working directory.
* The demo code generates a report.txt file for each of the tests. You can compare the files to verify that the execution of the program.
* You may need to update value of the promisedate used in the ssj.p program to use a value found in the copy of the sports2020 database.
* You may also run the scripts using the option `--with-logging` so that a client.log file is generated.

## Resources
* https://docs.progress.com/bundle/openedge-api-reference/page/Server-side-join-processing.html
* https://pugchallenge.org/downloads2018/Banville_Performance.pdf
* https://www.progress.com/blogs/openedge-12-great-performance-out-of-the-box-with-server-side-join
* https://docs.progress.com/bundle/openedge-videos/page/Server-Side-Joins-with-Dynamic-Queries.html
