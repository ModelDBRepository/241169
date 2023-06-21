
The attached files allow simulations described in "M current regulates firing mode and spike reliability in a collision-detecting neuron" by Dewell and Gabbiani (2018).
It includes a detailed model of the lobula giant movement detector neuron (LGMD) which is a well studied neuron within the optic lobe of grasshoppers.  Attached are files which setup the channel and membrane properties of the LGMD model and provide several example simulations.

Auto-launch or Compile special:
The LGMD model uses several custom .mod files for channels and currents. The auto-launch link will use these mod files to compile a special executable version of NEURON with the additional membrane mechanisms. Alternatively, the mknrndll application or nrnivmodl binary can be used to compile the special version containg all custom channels.

nrnivmodl ./mods


* If openMPI is not loaded the model cannot be run across multiple threads, and the "msplit" parameter should be set to 0 ("Initialize Global variables for simulations" section of init.hoc).


For simulations measuring temporal summation shown in figure 6:
4 sEPSP trains with 5, 10, 15 and 20 ms delays applied before and after IM block 
"sEPSP_series()"

For current step simulations depicted in figure 7a:
4 step currents (-2, -1, 1,and 2 nA) applied before and after IM block
"step_series()"

For chirp current simulations depicted in figure 7:
Chirp currents injected with multiple holding currents before and after IM block
"chirp_series()"



** Current Steps **

Simulates series of 4 current step injections into field A (-2, -1, 1, and 2 nA). The 4 current steps are simulated in sequence and the membrane potential of the injected location (base of field A) is plotted with the 4 steps overlayed.


** sEPSP Response **

Simulates series of 5 EPSC waveform injections with fixed delays of 5, 10, 15, and 20 ms. The 4 series are simulated in sequence and the membrane potential of the injected location (base of field A) is plotted.


** Drug application **
To simulate responses after M channel bloackade through application of XE991, use the procedure "addXE991()" before loading the desired simulation file. Conversely, this can be undone by the procedures "washXE991()" to return to the control conductance level.
