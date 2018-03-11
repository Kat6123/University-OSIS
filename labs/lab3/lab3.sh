#!/usr/bin/env bash

awk -f insert.awk bank.csv 1> insert.sql
