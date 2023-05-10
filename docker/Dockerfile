FROM amazoncorretto:20-al2-jdk

# Define working directory
WORKDIR /app

# Specify user
USER root

# Install dependencies
RUN yum install -y wget tar gzip

# Download dotnet installer
RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh

# Give permissions
RUN chmod +x ./dotnet-install.sh

# Install dotnet (last version)
RUN ./dotnet-install.sh --version latest

# Copy compiled version of P to execute it
COPY p ./p
# Copy all test
COPY properties ./properties
# Copy modified MultiVeStA jar
COPY multivesta.jar .

# Prepare system variables
ENV DOTNET_ROOT="/root/.dotnet"
ENV PATH="$PATH:$DOTNET_ROOT"
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

# Expose port
EXPOSE 55555

# Run multivesta server
CMD ["java", "-jar", "multivesta.jar", "-s", "55555"]