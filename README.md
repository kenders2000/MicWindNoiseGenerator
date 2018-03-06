# Microphone wind noise simulator

This is a matlab program that generates microphone wind noise examples. These can be useful in training noise removal algorithms, improving robustness of speech / audio recognition algorithms and generating sound effects.
The audio is generated from wind velocity sonic anemonter time histories sampled every 25ms. In cases where the sampling frequency differs, then interpolation can be used.
There are three models of microphone wind noise, one uses real recordings of audio made using a unshielded B&K measurement microphone placed in a wind tunnel. Windows of audio and then grabbed from these recordings then these windows are overlapped and added together to generate time varying wind noise. In addition there are two models of synthetic microphone wind noise. One with a wind shield (of diameter D) and the other without. For more details of the implementation please refer to the following publication. 

Perception and automatic detection of wind-induced microphone noise, Jackson, Iain R.; Kendrick, Paul; Cox, Trevor J.; Fazenda, Bruno M.; Li, Francis F.
The Journal of the Acoustical Society of America, vol. 136, issue 3, pp. 1176-1186 - http://asa.scitation.org/doi/full/10.1121/1.4892772

If you use this program in any acedmic research please provide a citation to the above paper.

## Getting Started

A matlab file example is provided which shows you how to generate 10s of windows from each of the three models.
The wind velocity time histories were collected from 

### Prerequisites

What things you need to install the software and how to install them

```
Give examples
```

### Installing

A step by step series of examples that tell you have to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc
