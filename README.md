# conda-audited
Wrapper script to audit conda and micromamba usage.

The wrapper echoes all commands that users try to run, along with their
username, to a port you can define in a file.

For micromamba it alters `shell init` and `shell hook` to set the micromamba to
the wrapper, and not the real executable.

## Install
First, download the real micromamba:

```
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)
[answer $PWD, n, Y]
```

Next, checkout this repo and cd to its directory. Then:

```
mv ../micromamba helpers/
```

Now add this directory to your $PATH and use `conda` and `micromamba` as normal.

To enable auditing, run an instance of:
https://github.com/wtsi-hgi/go-softpack-analytics
and tell the wrapper about the machine and port where it's listening:

```
echo "/dev/tcp/[machine]/[port]" > gsa
```
