import os

# See paths.py for where the data is stored

from HD_BET.paths import folder_with_parameter_files
from HD_BET.checkpoint_download import maybe_download_parameters

os.makedirs(folder_with_parameter_files)

maybe_download_parameters()
