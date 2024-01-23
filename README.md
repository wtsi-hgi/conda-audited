# micromamba-restricted
Wrapper scripts to restrict and audit micromamba.

This is a light wrapper around micromamba that alters incoming command
line args if the user tries to do a create or an install:

- Limits to the use of conda-forge and Bioconda channels by ignoring
  any -c/--channel args, forcing --no-rc --no-env, and setting
  `-c conda-forge -c Bioconda`.
- Exits with an error if a supplied -f/--file contains a reference to
  any anaconda.org hosted channel that is not conda-forge.

## Install
First, download the real micromamba:

```
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)
[answer $PWD, n, Y]
```

Next, checkout this repo and cd to its directory. Then:

```
mv ../micromamba real
```

Now add this directory to your $PATH and use `micromamba` as normal.
