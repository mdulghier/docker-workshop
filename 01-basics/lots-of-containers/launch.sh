#!/bin/bash

for i in {0..5}; do
	docker run -d debian:jessie top -b
done
