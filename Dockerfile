FROM toolmanp/ubuntu:22.04-zpoline AS builder

RUN apt update && apt upgrade -y
RUN apt install -y build-essential libreadline-dev libnuma-dev
RUN apt clean
WORKDIR /work
ADD . .
RUN make -j$(nproc)

FROM toolmanp/ubuntu:22.04-zpoline
RUN apt update && apt upgrade -y
RUN apt install -y libreadline8 libnuma1 libgomp1
RUN apt clean
COPY --from=builder /work/bin/* /usr/local/bin/
