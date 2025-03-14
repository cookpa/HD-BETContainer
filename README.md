# HD-BETContainer

Docker container for [HD-BET](https://github.com/MIC-DKFZ/HD-BET).

The models are downloaded into the container at build time, to allow the container to be
run offline. The model cache directory is set outside the user's home directory for
compatibility with Singularity.


## Running the container

Run without args to see usage. Note input requirements from HD-BET:

>INPUT_FILENAME must be a nifti (.nii.gz) file containing 3D MRI image data. 4D image
>sequences are not supported (however can be splitted upfront into the individual temporal
>volumes using fslsplit). INPUT_FILENAME can be either a pre- or postcontrast T1-w, T2-w
>or FLAIR MRI sequence. Other modalities might work as well. Input images must match the
>orientation of standard MNI152 template! Use fslreorient2std upfront to ensure that this
>is the case.


## Multithreading

To enable multi-threading, pass the environment variable `OMP_NUM_THREADS=N` at run time.


## GPU mode

On Singularity, the GPU mode works well with `singularity run --nv`. I highly recommend
using a GPU if possible. If running on the CPU, use multiple threads and `--disable_tta`.


## Citation

If using HD-BET in published research, please cite

Isensee F, Schell M, Pflueger I, Brugnara G, Bonekamp D, Neuberger U, Wick A, Schlemmer
HP, Heiland S, Wick W, Bendszus M, Maier-Hein KH, Kickingereder P. Automated brain
extraction of multisequence MRI using artificial neural networks. Hum Brain Mapp. 2019 Dec
1;40(17):4952-4964. doi: 10.1002/hbm.24750. Epub 2019 Aug 12. PMID: 31403237; PMCID:
PMC6865732.
