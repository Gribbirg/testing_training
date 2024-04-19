from distutils.dir_util import copy_tree
import shutil

copy_tree("assets", "build/web/assets")
shutil.rmtree("test")