# An acme.sh deployment script for iDrac

A small deployment script for acme.sh to automate LE certs to iDracs on at least 13g+, but probably others.

## Prequisites

* Just racadm

## Install

I'm distributing this as I run it for MacOS, which means I run `racadm` via Docker.  It's painfully easy to swap over to native mode.

Just drop the script in the `deploy/` directory of your acme.sh installation.  

Run deployment hook:

```

acme.sh --deploy -d "idrac.domain.com"  --deploy-hook idrac

```

Example run with CloudFlare DNS validation:


```

export DEPLOY_IDRAC_HOST="idrac.domain.com"
export DEPLOY_IDRAC_PASS="idrac_pass"
export DEPLOY_IDRAC_USER="idrac_user"

acme.sh --issue --dns dns_cf -d "idrac.domain.com"
acme.sh --deploy -d "idrac.domain.com"  --deploy-hook idrac
