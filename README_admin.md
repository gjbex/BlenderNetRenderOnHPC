# Running blender in client/server mode

## Preparation

### Account and credits

* Have the user register a VSC account.
* Have the user request credits


### VSC home directory

Copy the `Cluster` directory into the user's home directory as
`Blender`, and add it to the path by putting into the user's
`.bash_profile`:
```bash
export PATH="${VSC_HOME}/Blender:${PATH}"
export PATH="/apps/leuven/K40c/source/blender/blender-2.77a/:${PATH"
``

It may be a good idea to add the appropriate `-A` option as a PBS
directive in each of the PBS scripts.

The Blender preference file has to be copied to its proper directory as
well:
```bash
$ mkdir  -p  ~/.config/blender/2.77/config
$ cp  ~/Blender/userpref.blend  \
      ~/.config/blender/2.77/config/userpref.blend
```

### Client machine

Copy the `Client` directory into the user's home directory as
`Blender`, and add it to the path by putting the following their
`.bash_profile`:
```bash
export PATH="${HOME}/Blender:${PATH}
``
For MacOS X, put the following in the `.bash_profile` as well to avoid
some annoying locale warnings:
```bash
xport LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"
```

Add the following to `.ssh/config`, creating the file if necessary.
```
Host nx1
    Hostname 134.58.8.22
    User vsc30140
    ForwardX11 yes
    ServerAliveInterval 60
```
Don't forget to replace `vsc30140` by the user's VSC number.

Start Blender, in 'User prefrerences' from the 'File' menu, choose the
Add-ons tab, and enable the 'Network renderer' add-on.  Don't forget to
save the preferences.


## Master and slave configuration

A `master.blend` and `slave.blend` have to be creeted for the user.  Start
Blender on the login node, either using X11 or NX using:
```bash
$ blender  --addons netrender  -noaudio  -nojoystick
```

Select 'Network Render' as render engine.  In the renderer panel, select
the master.  The following settings need to be adapted:

* `Path`: set this to a directory, e.g., `Blender` on the user's scratch
    directory.
* `Address`: set the IP number of the login node, e.g., `134.58.8.22` for
    the first NX node.
* `Port`: use the user's VSC number to avoid conflicts with other users.

When the configuration is done. save a Blender as `master.blend` into
the `Blender` directory in the user's VSC home directory.

For the slave configuration, switch to the 'Slave' pane, and save as
`slave.blend` in the `Blender` directory.


## Additional information
[Blender Wiki](https://wiki.blender.org/index.php/Doc%3A2.6/Manual/Render/Performance/Netrender#Technical_Details)
