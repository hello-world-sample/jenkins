FROM jenkins/jenkins:lts-jdk21

USER root

RUN apt-get update \
    && apt-get install -y \
        ca-certificates \
        curl \
        docker.io \
        docker-compose \
        python3 \
        python3-pip \
        maven \
    && pip3 install --break-system-packages pytest \
    && curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash \
    && rm -rf /var/lib/apt/lists/*

RUN usermod -aG root jenkins
RUN jenkins-plugin-cli --plugins \
    configuration-as-code \
    job-dsl \
    git \
    workflow-aggregator \
    workflow-multibranch \
    pipeline-stage-view \
    pipeline-groovy-lib \
    docker-workflow \
    credentials-binding \
    grypescanner \
    warnings-ng

USER jenkins
