FROM node:4.4

LABEL maintainer Tano Iannetta <tano.iannetta@heig-vd.ch>
LABEL maintainer Loan Lassalle <loan.lassalle@heig-vd.ch>

LABEL "traefik.backend"="express_dynamic"
LABEL "traefik.port"="3000"
LABEL "traefik.frontend.rule"="Host: demo.res.ch;PathStrip: /api/addresses/"
LABEL "traefik.backend.loadbalancer.sticky"="true"

COPY ./src/ /opt/app/

CMD ["node", "/opt/app/index.js"]
