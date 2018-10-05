# Power DNS Setup for Single Node

This will allow you to run PowerDNS, the PowerDNS Admin website and the mysql server it requires.

Note: This will only install the services on a single Docker Linux machine. It is not intended for a Swarm or Kubernetes.

## Easy Installation

The easiest way to set up a box is to use the "powerdns" cloud config when provisioning a new machine, which essentially runs the `install.sh` script in this folder to build and install all the containers to get it all running.

## Manual Installation

Copy these files on to a linux machine that is just running docker. Run `.\install.sh` to install everything.

When first run you have to browse to /setup on the powerdns server and settings are as follows:

hostname: database
username: root
password: secretrootpassword
database: pdnsadmin

**NOTE:** There are two databases, one for powerdns, and another for powerdns admin. The SQL script `pdns.sql` will create the database schema for powerdns itself under the name "powerdns". The admin web UI will automatically create it's own schema when it is first set up, inside the "pdnsadmin" database, but it requires an empty database to be ready.

The file `start.sh` will ensure that the database is set up correctly for first use.
