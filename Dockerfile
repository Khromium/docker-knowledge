# Dockerfile for Knowledge

FROM arm64v8/tomcat:jre8

# ==== dumb-init ====
RUN apt-get update && \
    apt-get install -y --force-yes python-pip && \
    apt-get clean && \
    pip install --no-cache-dir dumb-init

# ==== environment ====
RUN rm -rf /usr/local/tomcat/webapps/ROOT \
  && update-ca-certificates -f 

# ==== add Knowledge ====
ADD https://github.com/support-project/knowledge/releases/download/v1.12.0/knowledge.war \
      /usr/local/tomcat/webapps/ROOT.war

VOLUME [ "/root/.knowledge" ]
EXPOSE 8080

CMD [ "/usr/local/bin/dumb-init", "/usr/local/tomcat/bin/catalina.sh", "run" ]
