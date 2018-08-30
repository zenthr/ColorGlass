# ColorGlass

Commands to load needed modules:

module load intel/2018a

module load FFTW/3.3.6-iimpi-2017b

First is the compiler, second is FFTW. As discussed, I don't recally why I use iimpi, but this seems to reload certain modules probably to keep it consistent with the environment it was developped in.

Command to compile

icpc -o Order.exe CGCEventCor-FFTW.cpp -lfftw3 -lm -std=c++11

"Order" is a holdover name from when I implemented the recursion and accessed higher orders.

"-lfftw3 -lm" is needed for FFTW

"-std=c++11" is needed for the randomization to have higher resolution


As is, running the code overwrites previous outputs entirely.


************
NEEDED FILES
************

Order.slurm

Is used for the batch manager. I didn't work on translating to Ada as of yet. If you end up on Terra, the command to run with the batch manager is: "sbatch Order.slurm"



CGCEventCor-FFTW.cpp

Main file.



ran_gen.cpp

Contains nucleon sampler routine. As you saw, I don't need to refer to this explicitly when compiling. It's reffered to by an "Include" command in the main file.



CGCDefsHD-FFTW.h

Header file contains variable definitions. I think all meaningful "knobs" are here now, as well as some set constants (Pi, for instance). Swapping between Pb-Pb and Au-Au (or Pb-Au) is currently pretty hands on, and I think could be better automated. See the bottom of this document for a bit of instruction on the Nucleon Sampler.

IF YOU CHANGE THE GRID SIZE ("ARRAY") BE SURE TO UPDATE THE VARIABLE "HALF" AS WELL SO THAT HALF = (ARRAY - 1)/2 . ADDITIONALLY, ARRAY MAY NEED TO BE ODD FOR SOME OF THE ALGORITHMIC LOGIC TO WORK.



CDF_Au.dat
CDF_Pb.dat

This is the CDF for nucleon placement for each nucleus type.

************
OUTPUT FILES
************


Parameters.txt

This is the generated at the beginning of a run and lists all relevant details. It also calculates m, Q, and Qs (in both fm-1 and GeV)



TimeDiag.txt

Reports runtime for various segments. I keep it around so I can easily monitor the progress and as I showed, when the run is complete "~~fin~~" is printed at the bottom of this file.



Tuv_xx.txt

This is the SUM of all events of the run for the matrix entry Tuv at BigO = xx. So, for the given example this is the output for T01 at 23rd order (T01 is odd, so the translations is 2*BigO-1). To get an average, one must remember to divide by number of events!



Mu0.txt and Mu1.txt

SUM of mu for the two nuclei over all events of the run.



TuvHist.txt

These are event-by-event, and order-by-order results for transverse integrals of the listed quantity. Other variants include "TuvDerHist.txt" (same, but for the derivatives) and "L2Hist.txt" for angular momentum. To read the files, each line is an event, and each order is delimited by spaces.



CSCharge.txt

Is the result from the Chern-Simmons (spelling?) calculation. It has the format as the TuvHist.txt files.



sample_Pb_bubble.dat
sample_Pb.dat
rsample_Pb.dat

These are the last event's sampling results. If running with gold, similar files are created.


***************
NUCLEUS SAMPLER
***************

In CGCDefsHD-FFTW.h, these are the parameters to control nucleus type:

"NucMethod = 1;" sets to use the nucleon sampler.

"N1, N2" are number of nucleons in each nucleus

"impact" is impact parameter in fm.

"r_core" is radius for each nucleon to detect for collisions during placement

"gauss_n" is the profile of the charge emitted by each nucleon

"Atom" is used to 'choose' between different kinds of atoms (Au and Pb). This currently only chooses the radial distribution used when placing nucleons, and currently the code presumes the same distribution for each nucleus (although the number of nucleons may be differ).

"NucScale" is the scale applied to the rho to match expected energy output.
