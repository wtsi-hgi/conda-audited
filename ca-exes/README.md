This ca-exes subdirectory is where you should install miniconda like this:

```
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
```
