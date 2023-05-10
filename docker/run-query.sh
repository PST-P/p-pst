#!/bin/bash

# 1. Quantitative query
java -jar multivesta.jar client -sd p.PState -m properties/Bikes.dll -f properties/1_quantitative.quatex -l servers -o 'dotnet /app/p/p.dll multivesta,t10U100B' -a 0.05 -d1 0.2 -bs 20 -ms 1000

# 2. Qualitative query
# java -jar multivesta.jar client -sd p.PState -m properties/Bikes.dll -f properties/2_qualitative.quatex -l servers -o 'dotnet /app/p/p.dll multivesta,t10U100B' -a 0.05 -d1 0.1 -bs 20

# 3. Quantitative query
# java -jar multivesta.jar client -sd p.PState -m properties/Bikes.dll -f properties/3_quantitative.quatex -l servers -o 'dotnet /app/p/p.dll multivesta,t10U100B' -a 0.05 -d1 0.1 -bs 20 -a 0.05 -d1 0.05 -bs 20
