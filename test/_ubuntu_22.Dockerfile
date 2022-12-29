FROM docker.io/buildpack-deps:jammy-scm

RUN apt-get update && apt-get -y --no-install-recommends install systemd systemd-sysv

ENV GITDIR /etc/.pihole
ENV SCRIPTDIR /opt/pihole

RUN mkdir -p $GITDIR $SCRIPTDIR /etc/pihole
ADD . $GITDIR
RUN cp $GITDIR/advanced/Scripts/*.sh $GITDIR/gravity.sh $GITDIR/pihole $GITDIR/automated\ install/*.sh $SCRIPTDIR/
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$SCRIPTDIR
ENV DEBIAN_FRONTEND=noninteractive

RUN true && \
    chmod +x $SCRIPTDIR/*

ENV SKIP_INSTALL true
ENV OS_CHECK_DOMAIN_NAME dev-supportedos.pi-hole.net

CMD ["/bin/systemd"]
