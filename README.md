# conda-audited
Wrapper script to audit conda and micromamba usage.

The wrapper echoes all commands that users try to run, along with their
username, to a port you can define in a file.

For micromamba it alters `shell init` and `shell hook` to set the micromamba to
the wrapper, and not the real executable.

## Install
First, checkout this repo and cd to its ca-exes subdirectory and install
micromamba and conda in there. Eg:

```
cd ca-exes
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)
[answer ., n, n]

cd ..
```

Next, run an instance of https://github.com/wtsi-hgi/go-softpack-analytics and
note the machine and port you used.

Now, switch to the ca-scripts subdirectory and record those connection details
like this:

```
cd ca-scripts
echo "/dev/tcp/[machine]/[port]" > gsa
cd ..
```

Finally, add the repo directory to your $PATH and use `conda` and `micromamba`
as normal.
