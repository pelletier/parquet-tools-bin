#!/bin/bash
exec java -jar /parquet-tools.jar $@ 2> >(grep -v WARNING)
