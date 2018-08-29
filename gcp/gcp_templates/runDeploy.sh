#!/bin/bash


gcloud deployment-manager deployments create defaultvm-deployment --config ./autonetdeploy_config.yaml
