#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

exec java -jar ${DIR}/parquet-tools-1.11.1.jar "$@" 2> >(grep -v WARNING)
