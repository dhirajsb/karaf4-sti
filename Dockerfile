FROM fabric8/base-sti

MAINTAINER dhirajsb@gmail.com
LABEL io.openshift.s2i.scripts-url https://raw.githubusercontent.com/dhirajsb/karaf4-sti/master/.sti/bin/

USER root

# download jolokia in the sti builder
RUN mkdir /opt/jolokia && curl -L http://central.maven.org/maven2/org/jolokia/jolokia-jvm/1.2.3/jolokia-jvm-1.2.3-agent.jar > /opt/jolokia/jolokia.jar

USER jboss

CMD ["/usr/bin/usage"]
