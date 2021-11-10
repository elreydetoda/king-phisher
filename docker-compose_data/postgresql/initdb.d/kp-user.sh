#!/usr/bin/env bash

# https://elrey.casa/bash/scripting/harden
set -${-//[sc]/}eu${DEBUG+xv}o pipefail

function initial_user(){

  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER ${PG_KP_DB_USER} WITH PASSWORD '${PG_KP_DB_PASSWORD}';
    CREATE DATABASE ${PG_KP_DB};
    GRANT ALL PRIVILEGES ON DATABASE ${PG_KP_DB} TO ${PG_KP_DB_USER};
EOSQL

}

function main(){
  initial_user
}

# https://elrey.casa/bash/scripting/main
if [[ "${0}" = "${BASH_SOURCE[0]:-bash}" ]] ; then
  main "${@}"
fi
