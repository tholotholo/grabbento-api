import os
import pathlib
from dotenv import load_dotenv

current_file_path = pathlib.Path(__file__).parent.absolute()
load_dotenv(os.path.join(current_file_path, '.env'), override=True)

from .staging import *

