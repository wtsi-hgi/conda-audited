# conda-audited
This repo provides instructions on how you can install, configure and alter
miniforge so that it audits what users do with it.

The alterations also set CONDA_GROUP so that you can use that in your
miniforge .condarc to set up envs_dirs and pkgs_dirs to have all end-users
install to a location based on their primary group.

The suggested config allows for multiple users using the same conda installation
while each using their own envs_dirs and pkgs_dirs in a central location.

## Install
First, run an instance of https://github.com/wtsi-hgi/go-softpack-analytics and
use the server's host for [gsa host] and port [gsa port] below.

Next, checkout this repo and cd to its directory and install miniforge in there
like this (changing the /location/for/end-user/envs):

```bash
wget -O miniforge.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash ./miniforge.sh -b -p $PWD/miniforge
rm miniforge.sh
$PWD/miniforge/bin/conda update --all

cat <<EOT > miniforge/.condarc
channels:
- conda-forge
- nodefaults
- bioconda
denylist_channels: [defaults, anaconda, r, main, pro] #!final
auto_update_conda: false #!final
notify_outdated_conda: false #!final
env_prompt: '({name}) '
envs_dirs: [/location/for/end-user/envs/\$CONDA_GROUP/\$USER] #!final
pkgs_dirs: [/location/for/end-user/envs/\$CONDA_GROUP/\$USER/pkgs, $PWD/miniforge/pkgs] #!final
EOT

mkdir -p miniforge/etc/conda/activate.d
cat <<EOT > miniforge/etc/conda/activate.d/env_vars.sh
#!/bin/sh

export CONDA_GROUP=\$(id -gn \$USER)
EOT

cat <<EOT > miniforge/etc/gsa
[gsa host]
[gsa port]
EOT

patch miniforge/lib/python3.12/site-packages/conda/cli/main.py main.py.diff
```

Finally, add the [repo directory]/miniforge/bin to your $PATH and export the
CONDA_GROUP env var:

```bash
export PATH=$PWD/miniforge/bin:$PATH
export CONDA_GROUP=$(id -gn $USER)
```

Now you can use `conda` as normal.

## Module
An example module file is included in this repo. You'll need to change the
help text and path, but otherwise can install it in your modules location to
make it easier for people to use this install of miniconda.
