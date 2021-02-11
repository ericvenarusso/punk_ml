#!/bin/bash

export AWS_DEFAULT_REGION="us-east-1"

mkdir lambda

cp src/data_prep/raw/lambda_function.py .
zip -r lambda/punk_raw_terraform.zip lambda_function.py
rm -rf lambda_function.py

cp src/data_prep/cleaned/lambda_function.py .
zip -r lambda/punk_cleaned_terraform.zip lambda_function.py
rm -rf lambda_function.py


terraform apply -auto-approve terraform/ 
