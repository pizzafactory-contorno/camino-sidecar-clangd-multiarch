ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG CLANGD=clangd
ARG DIST_RELEASE 

USER root
RUN if [ "${DIST_RELEASE}" != "" ]; then \
      apt-get update && apt-get install -y ca-certificates wget gnupg && \
      wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
      echo deb http://apt.llvm.org/${DIST_RELEASE}/ llvm-toolchain-${DIST_RELEASE} main > /etc/apt/sources.list.d/llvm.list; \
    fi && \
    apt-get update && \
    apt-get install -y ${CLANGD} gdb-multiarch && \
    apt-get autoremove -y ca-certificates wget gnupg && \
    apt-get clean && \
    rm -fr /var/lib/apt/lists/*
USER user
