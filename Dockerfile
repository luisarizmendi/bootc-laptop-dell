FROM quay.io/fedora/fedora-kinoite:41

RUN dnf config-manager setopt rpmfusion-nonfree-nvidia-driver.enabled=1 && \
    dnf config-manager setopt google-chrome.enabled=1 && \
    dnf config-manager setopt rpmfusion-nonfree-steam.enabled=1 && \
    dnf5 install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm && \
    dnf5 install -y \
    gcc-c++ kernel-devel make gcc git-lfs akmods akmod-nvidia cockpit cockpit-bridge cockpit-machines \
    cockpit-networkmanager cockpit-ostree cockpit-podman kmod-nvidia \
    kwallet libguestfs-tools-c libvirt nvidia-container-toolkit oathtool \
    podman-compose podman-docker python-devel python3-pip qemu-system-arm \
    qemu-user-static rpmfusion-free-release rpmfusion-nonfree-release \
    v4l2loopback virt-manager xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda java-11-openjdk glibc.i686 libstdc++.i686 && \
    dnf5 clean all


RUN echo "nvidia" > /etc/modules-load.d/nvidia.conf && \
    echo "nvidia-uvm" >> /etc/modules-load.d/nvidia.conf && \
    echo "nvidia-modeset" >> /etc/modules-load.d/nvidia.conf && \
    echo "nvidia-drm" >> /etc/modules-load.d/nvidia.conf && \
    echo "v4l2loopback" > /etc/modules-load.d/v4l2loopback.conf

#RUN echo "options v4l2loopback devices=1 video_nr=1 card_label='v4l2loopback' exclusive_caps=1" > /etc/modprobe.d/v4l2loopback.conf


COPY rpm-files/autofirma-1.8.3-1.noarch_FEDORA.rpm /tmp/autofirma-1.8.3-1.noarch_FEDORA.rpm
COPY rpm-files/brscan4-0.4.11-1.x86_64.rpm /tmp/brscan4-0.4.11-1.x86_64.rpm
COPY rpm-files/dcpl2530dwpdrv-4.0.0-1.i386.rpm /tmp/dcpl2530dwpdrv-4.0.0-1.i386.rpm

RUN mkdir -p /var/opt/brother

RUN dnf install -y /tmp/autofirma-1.8.3-1.noarch_FEDORA.rpm /tmp/brscan4-0.4.11-1.x86_64.rpm /tmp/dcpl2530dwpdrv-4.0.0-1.i386.rpm && \
    rm -f /tmp/autofirma-1.8.3-1.noarch_FEDORA.rpm /tmp/brscan4-0.4.11-1.x86_64.rpm /tmp/dcpl2530dwpdrv-4.0.0-1.i386.rpm
