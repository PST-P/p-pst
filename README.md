# This repository

The objective of this repository is to allow checking the results obtained and to be able to reproduce the experiments carried out. To achieve this, we have created this tutorial divided into 4 sections:

1. How to read the results
2. Show the `P` code on which the experiments were carried out
3. The meaning of the parameters used
4. How to create a Docker container to run the experiments

# Results

The results of all the experiments can be found in the `results` folder. In this folder, there are 3 subfolders corresponding to the different properties, _1_, _2_, and _3_. Inside each of these folders, there is a folder called `final`, where the results obtained directly by MultiVeStA can be viewed, along with their standard format and the associated graph. And a folder with the scalability experiments.

This folder is called `t10U100B`, as it is with the test in which the experiments have been executed to extract scalability. Within this folder, there is a folder for each environment in which the experiments were run, and in each environment, there are two more subfolders `c` and `java`. The name in each of the files is arranged so that the first number is the number of instances, the second number corresponds to the machine within that number of instances, and the last digit corresponds to the test number.

Each test has been run a total of 5 times, and therefore, the numbers range from 1 to 5.

To clarify this, we take the file `4_1_3.csv` as an example. This file corresponds to test 3 on machine 1 for 4 instances. Each of the lines in the files corresponds to an iteration. In the same file `4_1_3.csv`, both in the `c` folder and in the `java` folder, there are a total of 25 rows. This means that this particular experiment for that particular machine for the case of 4 instances required 25 interactions until MultiVeStA considered that the property had converged.

The files inside the `c` folder have only one column corresponding to the total execution time used by C# in that interaction. And the files inside the `java` folder have 4 columns:

- The first column corresponds to the sum of all the times elapsed between when `Java` sends a request and knows that `C#` has responded to that request.
- The second column corresponds to the sum of all the times elapsed between when we know that the message has arrived in `Java` and when it is actually reflected in the console.
- The third column corresponds to the sum of all the times elapsed in the processing and cleaning of the message to obtain the value that really interests us.
- The fourth column corresponds to the total number of messages exchanged between `Java` and `C#` to perform the interaction.

# The example Bikes code
In the `bikes` folder of this repository, you can access the `P` code of this example, as well as the code that is generated when compiled with `P`.

As we have `P` in this repository compiled and ready to use, if desired, you can compile the `P` code to see how the `PForeign` folder is generated. To do this, delete the `PForeign` folder inside the `bikes` folder and run the following command:
```bash
dotnet ../docker/p/p.dll compile
```

Being inside the `bikes` folder, this will automatically generate the code necessary for interaction with MultiVeStA and the `Bikes.dll` file for use.

# MultiVeStA parameters

This Docker image can be executed both locally and on AWS. Once this image is started and the server is listening, the following command will be executed:

```bash
$ java -jar multivesta.jar client -sd CLASS -m DLL -f QUATEX -l SERVERS -o COMMAND
```

The previous command defines the mandatory minimum parameters that must be indicated to MultiVeStA to execute the experiment. These parameters represent the following:

* __CLASS__. This is the new class implemented in Java that provides the ability to interact with the C# code generated by P.
* __DLL__. The DLL file contains the C# code generated from the P model.
* __QUATEX__. The QUATEX file contains the QuaTex properties to be verified.
* __SERVERS__. This parameter indicates either the number of threads with which to launch the experiments on the local machine or the location of a text file where an address followed by the listening port of the MultiVeStA server is indicated on each line.
* __COMMAND__. This optional parameter that MultiVeStA allows has been used to indicate the command to execute to launch the compiled P program.

As an example to better illustrate the use of this command, consider the following example:

```bash
$ java -jar multivesta.jar client -sd p.PState -m ./properties/properties/Model.dll -f ./properties/dice/1_quantitative.quatex -l 1 -o 'dotnet ./p.dll multivesta,t10U100B' -a 0.05 -d1 0.01 -bs 20 -ms 1000
```

In this example, the class _PState_ located within the _p_ package with the compiled model of the bicycle example will be used

# Create Docker container
To test how the interaction between P and multivesta works, we have created a docker machine that is located in the `docker` folder of the project, which contains everything necessary to execute the experiment.

1. First, we need to build the Docker image that contains all the information. To do this, we use the command:
    ```bash
    docker build -t p-multivesta .
    ```
2. Next, we create a container from the built image with the command:
    ```bash
    docker run -p 55555:55555 --name p-multivesta -it p-multivesta /bin/bash
    ```
   to run it in interactive mode, or
    ```bash
    docker run -p 55555:55555 --name p-multivesta -d p-multivesta
    ```
   if we want to run it in detached mode. With this, we will have a Docker container running MultiVeStA and listening on port `55555`.
3. Finally, we launch the command to execute the desired property in the container. For this purpose, we have created a file called `run-query.sh` with the 3 properties, to execute the command directly.
4. After following these steps, communication messages between MultiVeStA and P should start to be sent immediately in the Docker container (if you used interactive mode, otherwise you will need to access the container).