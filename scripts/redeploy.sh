#!/bin/sh

#
# This script forces AWS CodeDeploy redeployment of devevents-backend.
#

aws deploy create-deployment \
           --application-name dev_events_backend \
           --deployment-group-name dev_events_deployment_group \
           --description "Manual script deployment" \
           --revision revisionType=S3,s3Location={bucket=dev-events-code,key=backend-builds/devevents-backend.zip,bundleType=zip}
            