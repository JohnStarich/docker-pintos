FROM ubuntu:16.04
MAINTAINER John Starich <johnstarich@johnstarich.com>

# Install set up tools
RUN apt-get update && \
    DEBIAN_FRONTEND=noninterative \
        apt-get install -y --no-install-recommends \
            curl \
            tar

# Prepare the Pintos directory
WORKDIR /tmp
RUN curl -o pintos.tar.gz \
    -L http://www.stanford.edu/class/cs140/projects/pintos/pintos.tar.gz
RUN tar -xzf pintos.tar.gz && \
    mv ./pintos/src /pintos && \
    rm -rf ./pintos.tar.gz ./pintos
WORKDIR /pintos

# Install useful user programs
RUN apt-get update && \
    DEBIAN_FRONTEND=noninterative \
        apt-get install -y --no-install-recommends \
            coreutils \
			manpages-dev \
            xorg openbox \
            ncurses-dev \
            wget \
            vim emacs \
            gcc clang make \
            gdb ddd \
            qemu

# Clean up apt-get's files
RUN apt-get clean autoclean && \
    rm -rf /var/lib/apt/* /var/lib/cache/* /var/lib/log/*

# Add Pintos to PATH
ENV PATH=/pintos/utils:$PATH

# Fix ACPI bug
## Fix described here under "Troubleshooting": http://arpith.xyz/2016/01/getting-started-with-pintos/
RUN sed -i '/serial_flush ();/a \
  outw( 0x604, 0x0 | 0x2000 );' /pintos/devices/shutdown.c

# Configure Pintos for QEMU
RUN sed -i 's/bochs/qemu/' /pintos/*/Make.vars
## Compile Pintos kernel
RUN cd /pintos/threads && make
## Reconfigure Pintos to use QEMU
RUN sed -i 's/\/usr\/class\/cs140\/pintos\/pintos\/src/\/pintos/' /pintos/utils/pintos-gdb && \
    sed -i 's/LDFLAGS/LDLIBS/' /pintos/utils/Makefile && \
    sed -i 's/\$sim = "bochs"/$sim = "qemu"/' /pintos/utils/pintos && \
    sed -i 's/kernel.bin/\/pintos\/threads\/build\/kernel.bin/' /pintos/utils/pintos && \
    sed -i "s/my (@cmd) = ('qemu');/my (@cmd) = ('qemu-system-x86_64');/" /pintos/utils/pintos && \
    sed -i 's/loader.bin/\/pintos\/threads\/build\/loader.bin/' /pintos/utils/Pintos.pm

CMD ["sleep", "infinity"]
