# conda-audited
Wrapper script to audit miniconda usage.

For micromamba it alters `shell init` and `shell hook` to set the micromamba to
the wrapper, and not the real executable.
It alters `init` and the shell commands to set conda to the wrapper, not the
real conda executable.

It also implements setting CONDA_GROUP so that you can use that in your
miniconda .condarc to set up envs_dirs and pkgs_dirs to have all end-users
install to a location based on their primary group.

## Install
First, checkout this repo and cd to its ca-exes subdirectory and install
miniconda in there as per the README.md in the ca-exes subdirecory.

Next, run an instance of https://github.com/wtsi-hgi/go-softpack-analytics and
note the machine and port you used.

Now, record those connection details like this:

```
echo "/dev/tcp/[machine]/[port]" > ca-scripts/gsa
```

Finally, add the repo directory to your $PATH, call
`export CONDA_GROUP=$(id -gn $USER)` and use `conda` as normal.
