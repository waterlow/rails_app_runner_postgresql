#!/bin/bash

aws apprunner describe-service --service-arn arn:aws:apprunner:ap-northeast-1:765062437422:service/rails_app_runner_postgresql_v3/bb68fea9f7c94301a935ee8975aab308 | jq .Service.Status
