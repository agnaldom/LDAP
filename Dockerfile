FROM debian:latest

LABEL maintainer="Agnaldo Marinho  <agnaldomarinho7@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV TZ America/Belem
ENV LANG pt_BR.UTF-8  
ENV LANGUAGE pt_BR:pt
ENV LC_ALL pt_BR.UTF-8

RUN apt-get update \
    && apt-get -y install \
    slapd \
    ldap-utils \
    ldapscripts

COPY slapd-conf.ldif /tmp/
COPY slapd-users.ldif /tmp/
COPY sasl2/* /etc/ldap/sasl2/
RUN rm -rf /etc/ldap/slapd.d/*
RUN slapadd -n 0 -F /etc/ldap/slapd.d -l /tmp/slapd-conf.ldif 
RUN slapadd -n 1 -l /tmp/slapd-users.ldif 
RUN chown -R openldap: /etc/ldap/slapd.d/ \
    && chown -R openldap: /etc/ldap/sasl2/

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/etc/ldap", "/var/lib/ldap"]

EXPOSE 389 636

ENTRYPOINT ["slapd", "-h", "ldap:/// ldapi:/// ldaps:///", "-g", "openldap", "-u", "openldap", "-F", "/etc/ldap/slapd.d", "-d", "256"]
