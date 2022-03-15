ImportKeysightBin for Julia
===========================
Utility to import binary waveform data from Keysight (formerly Agilent)
oscilloscopes into Julia. This is equivalent to the `importAgilentBin`
function in Matlab and Python.

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
