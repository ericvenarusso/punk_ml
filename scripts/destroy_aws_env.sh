#!/bin/bash

export AWS_DEFAULT_REGION="us-east-1"

terraform destroy -auto-approve terraform/ 

rm -rf lambda