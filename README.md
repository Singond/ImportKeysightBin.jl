ImportKeysightBin for Julia
===========================
Utility to import binary waveform data from Keysight (formerly Agilent)
oscilloscopes into Julia. This is equivalent to the `importAgilentBin`
function in Matlab and Python.

Usage
=====
```julia
using ImportKeysightBin

(x1, y1), (x2, y2), (x3, y3), (x4, y4), metadata = importkeysightbin("file.bin")
```
