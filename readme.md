# Expo NextJS Template
[![web-stage](https://img.shields.io/badge/Web-Stage-blue?style=flat-square&logo=amazon-aws)](http://expo-nextjs-template-stage.s3-website-eu-west-1.amazonaws.com/)
[![deploy-web-stage](https://github.com/rdok/expo-nextjs-template/workflows/Deploy%20Web%20Stage/badge.svg)](https://github.com/rdok/expo-nextjs-template/actions?query=workflow%3A%22Deploy+Web+Stage%22)

[![expo-stage-blue](https://img.shields.io/badge/Mobile-Stage-blue?style=flat-square&logo=expo)](https://expo.io/@rdok/expo-nextjs-template?release-channel=stage)
[![Publish mobile stage](https://github.com/rdok/expo-nextjs-template/workflows/Publish%20mobile%20stage/badge.svg)](https://github.com/rdok/expo-nextjs-template/actions?query=workflow%3A%22Publish+mobile+stage%22)
[![Trigger mobile build stage](https://github.com/rdok/expo-nextjs-template/workflows/Trigger%20mobile%20build%20stage/badge.svg)](https://github.com/rdok/expo-nextjs-template/actions?query=workflow%3A%22Trigger+mobile+build+stage%22)

This projects is a template for setting expo, NextJS, with CI/CD automations for stage environment.

## Web Stage Setup
#### Infrastructure
- Modify `infrastructure` folder: Change the org organization, workspace, and bucket name.
- Setup a terraform cloud workspace named `{your-project-name}-stage`
    - Set terraform working directory `infrastructure`. 
    - Enable always trigger run
    - Add terraform variable `environment` with value `stage`
    - Add environment variables `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`; said AWS IAM user should have admin policy rights for the bucket `{your-bucket-name}-stage` you specified on previous steps.
- Trigger Terraform Cloud run.
#### Deploy 
- Add environment variables `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` to the GitHub repo secrets; said AWS IAM user should have policy rights to list, put, and delete objects for the bucket `{your-bucket-name}-stage`.
- Modify `deploy-web-stage.yml.${WEBSITE_BUCKET}` github action with your bucket name, without the `-stage`
- Commit & push. Github action should deploy the web-app to http://expo-nextjs-template-stage.s3-website-eu-west-1.amazonaws.com/ 
- TODO: Setup CDN
 
## Mobile Stage Setup
#### Infrastructure
- Create an account at https://expo.io/
- Add `Environment` with value `stage` to the GitHub repo secret.
- Add credentials `EXPO_USERNAME`, `EXPO_PASSWORD` to the GitHub repo secrets
    
From now onward you can rely on GitHub actions to automate publishing changes to [expo stage](https://github.com/rdok/expo-nextjs-template/actions?query=workflow%3A%22Publish+mobile+stage%22). 
To triggering new builds you'll need to manually trigger the corresponding GitHub action.
