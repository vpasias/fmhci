#!/usr/bin/env bash

sudo ip link add br12 type bridge
sudo ip link add br13 type bridge
sudo ip link add br23 type bridge

sudo ip link set br12 up
sudo ip link set br13 up
sudo ip link set br23 up
