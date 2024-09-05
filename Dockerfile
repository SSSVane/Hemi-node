FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y git make curl wget jq && rm -rf /var/lib/apt/lists/*
RUN wget https://go.dev/dl/go1.22.2.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz && rm go1.22.2.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -y nodejs && npm install -g pm2
RUN mkdir -p /heminetwork/data
RUN wget https://github.com/hemilabs/heminetwork/releases/download/v0.3.2/heminetwork_v0.3.2_linux_amd64.tar.gz && tar -xzf heminetwork_v0.3.2_linux_amd64.tar.gz -C /heminetwork && rm heminetwork_v0.3.2_linux_amd64.tar.gz
ENV POPM_BFG_URL=wss://testnet.rpc.hemi.network/v1/ws/public
CMD ["sh", "-c", "export POPM_BTC_PRIVKEY=${POPM_BTC_PRIVKEY} && export POPM_STATIC_FEE=${POPM_STATIC_FEE} && export POPM_BFG_URL=${POPM_BFG_URL} && /heminetwork/popmd"]
