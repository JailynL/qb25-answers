Answer for Question 1.1:
3x coverage (# of reads) * 100bp (length of read) / 1,000,000Mbp (genome size) = 30,000 reads

Answer for Question 1.4:
In my 3x coverage simulation about 4.8% (0.048652) of the genome 
has 0x coverage. In the poisson model lambda is = 3, so e^-3 = 4.98% roughly, so the expected poisson exepectations matches the stimulated model results. 
The observed coverage distribution matches the Poisson expectation, particularly on the 
left side of the distribution where low coverage values occur. The Poisson
curve aligns with the highest peaks in the histogram. While the nromal distribution reaches
its highest peaks at. aisngle central value and fits ok neat the mean, but it
fails to capture the shape of the distrbution as well at low coverage depths (comapred to Poisson).

Answer for Question 1.5: 
In my 10x coverage simulation about 0.0046% (4.6e-05) of the genome 
has 0x coverage. Under a Poisson model with lambda = 10, e^-10 = 4.5x 10^-5 which closely matches the simulation results. 
At this coverage depth (!0x) both Poisson and normal distributions fit the
observed coverage distribution well, as they both follow the natural bell curve shown
by the histograms. 

Answer for Question 1.6:
In my 30x coverage simulations 0% (0) of the genome has 0x coverage. Under
a Poisson model with lamdba = 30, e^-30 = 9.3x10^-14 which is so close to 0
that is basically is 0. Therefore, the expected Poisson results match the stimulated results.
In the graph, the normal distrubution fits the observed coverage very well. 
