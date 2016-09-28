# Running blender in client/server mode

## Preparation

### Account & credits

Please request a VSC account, see the following webpage for the procedure:
https://www.vscentrum.be/cluster-doc/account-request

Once your account is active, please request credits, see:
https://www.vscentrum.be/cluster-doc/running-jobs/credit-system-basics

Once these two steps have been completed, you have access to the cluster,
and you can compute.

If you are unfamiliar with linux, contact the help desk for help with
the installation, otherwise, consult `README_admin.md` for instructions
on how to set up your environment.


### Client configuration

Start Blender, in 'User prefrerences' from the 'File' menu, choose the
Add-ons tab, and enable the 'Network renderer' add-on.  Don't forget to
save the preferences.


## Rendering

From the client machine, open a termimnal, log into the nx node, creating
a tunnel in the process for port forwarding the connection from client to
master:
```bash
$ start_tunnel.sh
```
This starts an SSH session, in that session, start the Blender master:
```bash
$ start_master.sh
```
The Blender process will be running in the background with `nohup`, so it
will keep running even when the connection is lost.  Note that it is
necessary to reestablish the connection when that happens, because the
port forwarding tunnel will be broken.

Slaves will run on compute nodes, potentially the GPU or visualization
nodes.  A slave is started by submitting a job using a PBS script

* `start_slave_ivybridge.sh
* `start_slave_haswell.sh

To start a slave on, e.g., an ivybridge compute node (no GPU), use the
following command on the NX node:
```bash
$ start_slave_ivybridge.sh
```
Notes:

* Submitting the job doesn't mean it starts immediately, that depends on
    the load of the cluster.
* If you want multiple nodes as slaves, submit multiple jobs.
* the default walltime for slaves is 1 hour, if you want a different value,
    use, e.g., `-l walltime=05:00:00'.  This would give you a walltime
    of 5 hours.

To check whether jobs (and hence slaves) are running when on the NX node,
use:
```bash
$ qstat
```

To check the status of the job to, e.g., detect problems with the job
submission, use:
```bash
$ checkjob <job-id>
```

On the client machine, start Blender in the normal way.

To ensure that the network rendering will be done with the settings for
the original renderer, don't forget to save the `.blend' file with those
settings.

Set the renderer from the menu to 'Network renderer', in the 'Client'
panel, set `Address` to `localhost`.

Click the refresh button.  As soon as the master is detected, you can
click the 'Open Master Monitor' button that will show a status page for
the master in your web browser.

In the client panel, set the renderer you want to use, e.g., 'Cycles'.

In the Blender's client pannel, click the refresh button next to the list
of slaves to see whether the master has picked them up.

When slaves are available, you can render as usual.  The progress of the
network renderer can be followed either in the client panel's job list, or
more conveniently, via the 'Master Monitor' in your web browser.


## Stopping to blend

It is recommented to stop the slaves before you stop the master.

When done rendering on the cluster, don't forget to stop the slaves, as
well as the master. To stop the slaves, use:
```bash
$ stop_slaves
```
To stop the master, use, surprise, surprise:
```bash
$ stop_master
```

To stop the lot with one command, use:
```bash
$ stop_blending
```

Note that if you do not stop the slaves, they will run until they reach
the walltime limit, and you will be charged for their idle time.


## Additional information
[Blender Wiki](https://wiki.blender.org/index.php/Doc%3A2.6/Manual/Render/Performance/Netrender#Technical_Details)
