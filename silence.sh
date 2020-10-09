#!/bin/bash

set -ex

exec $@ 2> >(grep -v WARNING)

