#FROM trufflesuite/ganache-cli:latest
FROM node:alpine
RUN npm install -g ganache-cli
RUN apk update && apk add bash
RUN apk add jq
RUN apk add --no-cache git make musl-dev go

# Configure Go
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin
#RUN npm i solc@0.5.4 -g
#RUN which solcjs
#RUN ln -s /usr/local/bin/solcjs /go/bin/solc
#RUN which solc

#RUN apk add solidity
#RUN git clone --recursive https://github.com/ethereum/solidity.git
#WORKDIR solidity
#RUN ls -la
#RUN make
RUN wget -O /usr/local/bin/solc https://github.com/ethereum/solidity/releases/download/v0.5.4/solc-static-linux
RUN chmod +x /usr/local/bin/solc

RUN ls && pwd && go get -u github.com/ypapax/ethereum-playbook
RUN npm i truffle -g
RUN mkdir -p /root/playbook/contracts
WORKDIR /root/playbook
COPY entrypoint.sh /entrypoint.sh
COPY playbook.yml /root/playbook/playbook.yml
COPY set-public-private-key-strings-in-config.js /root/set-public-private-key-strings-in-config.js
COPY contracts/Lottery.sol /root/playbook/contracts/Lottery.sol
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]