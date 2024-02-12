# PDLIBS
Lua libraries created for game development on the Playdate.</br>

The library is focused on object oriented design and is heavily dependant on the [PlaydateSDK](https://sdk.play.date/) Objects library.
See the `README` files in the respective directories and the comments in the source files concerning the usage of the library.

## Modules
The library contains the following sub-modules.
* Behavior: Modular Behavior-Tree implementation.
* N-Gram: General N-Gram implementation.
* Struct: Various general purpose data structures.
* State: Simple Finite-State-Machine implementation
* Util: Various utilities for debugging, string maniputation, variables, etc.

## Usage
Check out the repository in your `source/` folder and `import` the required file from the respective directory.

To avoid importing all files in a directory seperately, you can import the `all.lua` file from a directory to include all corresponding files in the submodule.

> _**Convention**_: Properties starting with an underscore e.g. `mytable._someFunction` are considered to be private and should not be called from outside the file. These are usually helper functions or variables that hide the underlying functionality of the API. 

## License
This project is released under the [GNU Lesser General Public License v3.0](https://www.gnu.org/licenses/lgpl-3.0.en.html).