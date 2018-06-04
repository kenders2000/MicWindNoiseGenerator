# Microphone wind noise simulator

This is a matlab program that generates microphone wind noise examples. These can be useful in training noise removal algorithms, improving robustness of speech / audio recognition algorithms and generating sound effects.
The audio is generated from wind velocity sonic anemonter time histories sampled every 25ms. In cases where the sampling frequency differs, then interpolation can be used.
There are three models of microphone wind noise, one uses real recordings of audio made using a unshielded B&K measurement microphone placed in a wind tunnel. Windows of audio and then grabbed from these recordings then these windows are overlapped and added together to generate time varying wind noise. In addition there are two models of synthetic microphone wind noise. One with a wind shield (of diameter D) and the other without. For more details of the implementation please refer to the following publication. 

Perception and automatic detection of wind-induced microphone noise, Jackson, Iain R.; Kendrick, Paul; Cox, Trevor J.; Fazenda, Bruno M.; Li, Francis F.
The Journal of the Acoustical Society of America, vol. 136, issue 3, pp. 1176-1186 - http://asa.scitation.org/doi/full/10.1121/1.4892772

If you use this program in any acedmic research please provide a citation to the above paper.

## Getting Started

A matlab file example is provided which shows you how to generate 10s of windows from each of the three models.
The wind velocity time histories were collected from https://www.eol.ucar.edu/projects/cases99/. 

There are three inputs to the model:

T - Length of wind noise to generate (s)

targetV - Target mean wind velocity to generate (m/s) - The program use a dumb brute force approach to find the appropriate mean velocity - Randomly grabbing chunks from the database and computing the mean until it is within 0.5m/s of your target. So this may take longer at more extreme wind speeds as they are more rare in the database.

D - the shielded wind noise model uses a 10cm Diameter shield (m)


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details



