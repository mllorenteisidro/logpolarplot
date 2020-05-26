# logpolarplot
Plot in a wind-rose like diagram any number of orientation-frequency data

The aim of this project is to build a function into OCTAVE GNU 5.2.0 capable of plotting data in a circular manner (polar-plot like or wind-rose-like plot), so I have frequency concentric circles log-scaled (or log-distributed) vs direction (as a meassure of angle in degrees from the true north eastwards (+) or westwards (-).

Hence the function requires two vectors of the same dimensions. One would have values from 0 to 360 degrees (where 0=North and 90º=East), and the other vector would be a number of freequency (usually anything from 1E1 to 1E5).

I am still working on error handling. It should include: wrong number of arguments (too few or too many) and wrong length for inputs. Not there yet.

The rest seems to be working fine.
