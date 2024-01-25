# conda-audited
Wrapper script to audit conda and micromamba usage.

The wrapper echoes all commands that users try to run, along with their
username, to a port you can define in a file.

For micromamba it alters `shell init` and `shell hook` to set the micromamba to
the wrapper, and not the real executable.
Likewise, for miniconda it alters `init`. It also implements setting CONDA_GROUP
so that you can use that in your miniconda .condarc to set up envs_dirs and
pkgs_dirs to have all end-users install to a location based on their primary
group.

## Install
First, checkout this repo and cd to its ca-exes subdirectory and install
micromamba and miniconda in there. Eg:

```
cd ca-exes
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)
[answer ., n, n]

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ./miniconda.sh
bash ./miniconda.sh -b -p $PWD/miniconda
rm miniconda.sh
ln -s $PWD/miniconda/bin/conda conda

cat <<EOT > miniconda/.condarc
channels:
- conda-forge
- nodefaults
- bioconda
auto_update_conda: false #!final
envs_dirs: [/location/for/end-user/envs/\$CONDA_GROUP/\$USER] #!final
pkgs_dirs: [/location/for/end-user/envs/\$CONDA_GROUP/\$USER/pkgs, $PWD/miniconda/pkgs] #!final
EOT

sed -i 's@/ca-exes/miniconda/bin/conda@/conda@g' miniconda/etc/profile.d/conda.sh
echo 'export CONDA_GROUP=$(id -gn $USER)' >> miniconda/etc/profile.d/conda.sh

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
