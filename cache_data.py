import os

# See paths.py for where the data is stored

from HD_BET.paths import folder_with_parameter_files
from HD_BET.utils import maybe_download_parameters

os.makedirs(folder_with_parameter_files)

for fold in range(0,5):
    maybe_download_parameters(fold)
    fold_file = f"{folder_with_parameter_files}/{fold}.model"
    if not os.path.isfile(fold_file):
        raise FileNotFoundError(f"Could not download fold {fold} to {fold_file}")
