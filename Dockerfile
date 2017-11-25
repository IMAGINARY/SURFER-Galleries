FROM ubuntu:16.04
MAINTAINER Christian Stussak <christian.stussak@imaginary.org>

# Install Java 8 and a couple of tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        openjdk-8-jre-headless \
        curl \
        unzip \
    && rm -rf /var/lib/apt/lists/*

# Install XeLaTeX and fonts
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    texlive-xetex \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-lang-arabic \
    fonts-wqy-zenhei \
    lmodern \
    && rm -rf /var/lib/apt/lists/*

# Download and install Gradle
RUN cd /usr/local \
    && curl -L https://services.gradle.org/distributions/gradle-2.12-bin.zip -o gradle-2.12-bin.zip \
    && unzip gradle-2.12-bin.zip \
    && rm gradle-2.12-bin.zip

# Export some environment variables
ENV GRADLE_HOME=/usr/local/gradle-2.12
ENV PATH=$PATH:$GRADLE_HOME/bin JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Define volume: your SURFER-Galleries code directory can be mounted here
# Mount with: -v /your/local/directory:/tmp/SURFER-Galleries
VOLUME ["/tmp/SURFER-Galleries"]

# Define volume: an optional local Maven repository
VOLUME ["/tmp/maven-repository"]

# Allow the host to use gradle cache, otherwise gradle will always
# download plugins & artifacts on every build
VOLUME ["/root/.gradle/caches/"]

# Set default action
WORKDIR /tmp/SURFER-Galleries
ENTRYPOINT ["gradle"]
CMD ["jar"]
