import os
import sys
#from distutils.core import setup
from setuptools import setup
from distutils.core import Command
from distutils.util import get_platform
from distutils.extension import Extension
from Cython.Distutils import build_ext
from Cython.Build import cythonize

# inherited from ESMPy
def update_system_path():
    if 'src' not in sys.path:
        sys.path.insert(0, 'src')


class AbstractESMFCommand(Command):
    user_options = []

    def initialize_options(self):
        self.cwd = None

    def finalize_options(self):
        self.cwd = os.getcwd()

    def _validate_(self):
        if os.getcwd() != self.cwd:
            raise RuntimeError('Must be in package root: %s' % self.cwd)


class BuildCommand(AbstractESMFCommand):
    description = "build: will build the ESMF package"
    user_options = [('ESMFMKFILE=', 'e',
                     "Location of esmf.mk for the ESMF installation")]

    def initialize_options(self):
        self.cwd = None
        self.ESMFMKFILE = None
        SITEDIR = os.system('%s -m site --user-site' % sys.executable)
        self.build_base = 'build'
        self.build_lib = None
        self.plat_name = None

    def finalize_options(self):
        self.cwd = os.getcwd()
        if isinstance(self.ESMFMKFILE, type(None)):
            self.ESMFMKFILE = os.getenv('ESMFMKFILE')
        if isinstance(self.build_lib, type(None)):
            self.build_lib = os.path.join(self.build_base, 'lib')
        if isinstance(self.plat_name, type(None)):
            self.plat_name = get_platform()

    def run(self):
        assert os.getcwd() == self.cwd, 'Must be in package root: %s' % self.cwd

        # Create "esmfmkfile.py" file holding the path to the ESMF "esmf.mk" file
        if not isinstance(self.ESMFMKFILE, type(None)):
            f = open(os.path.join('src', 'ESMF', 'interface', 'esmfmkfile.py'), 'w')
            f.write('ESMFMKFILE = "%s"' % self.ESMFMKFILE)
            f.close()




        # Attempt to load ESMF.
        update_system_path()
        #import ESMF.interface.loadESMF

# add wrapper file names
src_path = os.path.join('src', 'Superstructure')
wrapper_build_filenames = []
for dirpath, dirnames, filenames in os.walk(src_path):
    for filename in filenames:
        if '.F90' in filename:
            bldcmd = "cd {}; rm *.o; ifort {} -c -o {} -O3 -fPIC; cd -".format(dirpath, filename, filename.replace('.F90', '.o'))
            print(bldcmd)
            os.system(bldcmd)
            wrapper_build_filenames.append(os.path.join(dirpath,filename.replace('.F90', '.o')))

print(wrapper_build_filenames)

ext_modules = [Extension("esmf_wrapper",
                         ["src/Superstructure/ESMFMod/ESMF_Init.pyx"],
                         #include_dirs=[get_include()],
                         extra_compile_args=['-fPIC', '-O3'],
                         extra_link_args=wrapper_build_filenames,
                         #depends=wrapper_build_filenames,
    )
]

setup(name="esmf-wrapper",
      version="0.1.0",
      description="ESMF Python wrapper",
      ext_modules=ext_modules,
      cmdclass={'build_ext': build_ext}
)
