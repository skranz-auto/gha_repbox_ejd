FROM skranz/repbox_groundwork

ARG STATA_LIC

#COPY repboxMain /root/repboxMain
#COPY repboxStata /root/repboxStata
#COPY ExtractSciTab /root/ExtractSciTab

RUN echo $STATA_LIC > /usr/local/stata/stata.lic

COPY repbox_config.yml /root/repbox_config.yml

MAINTAINER Sebastian Kranz "sebastian.kranz@uni-ulm.de"
