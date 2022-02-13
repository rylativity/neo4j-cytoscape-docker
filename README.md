# Neo4j-Cytoscape Desktop Docker

A docker-compose stack for running Neo4j and Cytoscape Desktop in Docker.  

## Setup
-----IMPORTANT NOTE-----
Using Cytoscape is not required and can be disabled by simply commenting out the cytoscape service in the docker-compose.yml and ignoring the Cytoscape section in the setup instructions below.  If you want to be able to view the Cytoscape Desktop application running inside it's container, you will need to install a VNC viewer for your operating system.

Create the following directories in the root folder of this project.  These folders will be mounted to your neo4j container and serve as persistent storage.
- data/
- import/
- logs/
- plugins/

You can create all the folders at once with `mkdir data import logs plugins`.  You may also need to set permissions in order to build the docker image (e.g. `chmod a+rwx -R data import logs plugins`)

### Neo4j Container
The neo4j user's password ("test" by default) can be changed under the Neo4j service's environment section in the docker-compose.yml

### Cytoscape Desktop Container
Cytoscape Desktop runs in an ubuntu container with xvbf and supervisor, and requires a VNC viewer application on your local machine to connect to the xvbf instance.

Note: if you look at the docker-compose logs (`docker-compose logs -f`,) you will see an error about a missing OpenCL library.  This is expected, and the OpenCL library is not necessary since the desktop GUI will be rendered remotely by our VNC viewer. The Cytoscape container uses a "disable-opencl.dummy" file as explained in the cytoscape documentation - https://cytoscape.org/common_issues.html#opencl)

## Running The Stack

Run the command `docker-compose up -d` to run the stack.  

When Services are Running, you can connect to Neo4j through your web browser at localhost:7474.  To connect to Cytoscape Desktop, download a VNC viewer for your operating system (tested using Vinagre on Ubuntu 20.04) and point it to localhost:5900 using VNC protocol.
Once connected with the Cytoscape desktop opened in your VNC viewer, select Apps -> App Manager, search for "neo4j" and install the "Cytoscape Neo4j Plugin".  Once the plugin is installed, go to Apps -> Cypher Queries -> Connect to Neo4j Instance.  The hostname (which is just the container service name) should be changed from `localhost` to `neo4j` (which is just the discoverable service name defined in our docker-compose.yml that the Cytoscape container can use to connect to the Neo4j container).  Enter your password.  As long as you enter the password ("test" by default as set in the docker-compose.yml) and set the hostname to the neo4j service name (i.e. `neo4j` by default) , the other default values should work if you haven't modified any other values in the docker-compose.yml (set any other values as needed if you changed usernames, ports, database name, etc).  If the connection is successful, you will see "Connected".
You can now select Apps -> Cypher Queries, and execute queries against the Neo4j container.
