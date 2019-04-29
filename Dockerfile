FROM alpine:latest

RUN apk update
# 主要パッケージ
RUN apk add --no-cache coreutils openssl openssh curl git vim sudo

# シェル関連
RUN apk add --no-cache bash

# 開発用ユーザ(を作るかどうかも検討中)
RUN echo 'root:root' | chpasswd
#RUN addgroup -g 1000 developer && \
#    adduser  -G developer -s /bin/bash -S me && \
#    echo 'me:me' | chpasswd && \
#    echo 'Defaults visiblepw'        >> /etc/sudoers && \
#    echo 'me ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# SSH関連
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
		ssh-keygen -A

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
