ImportKeysightBin for Julia
===========================
Utility to import binary waveform data from Keysight (formerly Agilent)
oscilloscopes into Julia. This is equivalent to the `importAgilentBin`
function in Matlab and Python.

Structure of the binary file format can be inferred from the example
reader function provided by Keysight at
<https://www.mathworks.com/matlabcentral/fileexchange/11854-agilent-scope-waveform-bin-file-binary-reader>.
Textual description is available at
<https://github.com/FaustinCarter/agilent_read_binary>,
but note that it is missing the frameString parameter.

Installation
============
Install the package with `Pkg.add("ImportKeysightBin")`.

Usage
=====
Call the `importkeysightbin` function to import data from a file or IO:
```julia
using ImportKeysightBin

(x1, y1), (x2, y2), (x3, y3), (x4, y4), metadata = importkeysightbin("file.bin")
```
