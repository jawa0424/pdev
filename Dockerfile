FROM alpine:latest

RUN apk update
# 主要パッケージ
RUN apk add --no-cache coreutils openssl openssh curl git vim sudo

# シェル関連
RUN apk add --no-cache bash
COPY tmpl/.bash_profile /root/.bash_profile

# ユーザ関連
RUN echo 'root:root' | chpasswd

# SSH関連
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
