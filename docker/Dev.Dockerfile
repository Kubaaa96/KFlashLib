FROM cpp_template:0.0.1

RUN apt-get update && \
    apt-get install -y ssh rsync gdb nano python3-pip clang-format clang-tidy ccache cppcheck

RUN add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
    apt-get install -y --only-upgrade libstdc++6

RUN pip install conan

RUN rm -rf /var/lib/apt/lists/*

RUN ( \
    echo 'LogLevel DEBUG2'; \
    echo 'PermitRootLogin yes'; \
    echo 'PasswordAuthentication yes'; \
    echo 'Subsystem sftp /usr/lib/openssh/sftp-server'; \
  ) > /etc/ssh/sshd_config_test_clion \
  && mkdir /run/sshd

RUN echo "root:password" | chpasswd
ENV PS1="\$ "
CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_test_clion"]

