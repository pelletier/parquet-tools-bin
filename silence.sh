#!/bin/bash

exec $@ 2> >(grep -v WARNING)

