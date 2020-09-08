# Expo NextJS Template
[![web-stage](https://img.shields.io/badge/Web-Stage-blue?style=flat-square&logo=amazon-aws)](http://expo-nextjs-template-stage.s3-website-eu-west-1.amazonaws.com/)
[![deploy-web-stage](https://github.com/rdok/expo-nextjs-template/workflows/Deploy%20Web%20Stage/badge.svg)](https://github.com/rdok/expo-nextjs-template/actions?query=workflow%3A%22Deploy+Web+Stage%22)

[![expo-stage-blue](https://img.shields.io/badge/Mobile-Stage-blue?style=flat-square&logo=expo)](https://expo.io/@rdok/expo-nextjs-template?release-channel=stage)
[![build-mobile-stage](https://github.com/rdok/expo-nextjs-template/workflows/trigger-mobile-build-stage/badge.svg)](https://github.com/rdok/expo-nextjs-template/actions?query=workflow%3Abuild-mobile-stage)
[![publish-mobile-stage](https://github.com/rdok/expo-nextjs-template/workflows/publish-mobile-stage/badge.svg)](https://github.com/rdok/expo-nextjs-template/actions?query=workflow%3Apublish-mobile-stage)

This projects aims showcase, and act as template for setting expo with NextJS.

## Web Stage Setup
#### Infrastructure
- Modify `infrastructure` folder accordingly: Change the org organization, workspace, and bucket name.
- Setup a terraform cloud workspace named `{your-project-name}-stage`
    - Set terraform working directory `infrastructure`. 
    - Enable always trigger run
    - Add terraform variable `environment` with value `stage`
    - Add environment variables `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`; said AWS IAM user should have admin policy rights for the bucket `{your-bucket-name}-stage` you specified on previous steps.
- Trigger Terraform Cloud run.
#### Deploy 
- Add environment variables `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` to the GitHub repo secrets; said AWS IAM user should have policy rights to list, put, and delete objects for the bucket `{your-bucket-name}-stage`.
- Modify `deploy-web-stage.yml` github action with your bucket name, without the `-stage`
- Commit & push. Github action deployes web-app to http://expo-nextjs-template-stage.s3-website-eu-west-1.amazonaws.com/ 
- TODO: Setup CDN
 
## Mobile Stage Setup
#### Infrastructure
- Create an account at https://expo.io/
- Add `Environment` with value `stage` to the GitHub repo secret.
- Add credentials `EXPO_USERNAME`, `EXPO_PASSWORD` to the GitHub repo secrets
- `npx expo login`
- `npx expo publish --release-channel stage`
- `npx expo build:android --release-channel stage --type apk`
  - Select option: generate new keystore
  - `expo fetch:android:keystore`
  - Backup these keys, you're going to use them for the CI/GitHub action secrets to trigger builds:
    - Encode the keystore binary to base64, and add it as a secret `EXPO_ANDROID_KEYSTORE_JKS_BASE64`: 
      - `cat expo-nextjs-template.jks | base64 --wrap=0`
    - Add additional secrets: `EXPO_ANDROID_KEYSTORE_ALIAS`, `EXPO_ANDROID_KEY_PASSWORD`, `EXPO_ANDROID_KEYSTORE_PASSWORD`
    
The GitHub actions will now publish any new work done on master branch. For builds, you'll need to trigger the action manually.


## Stage
[Expo](https://expo.io/) sets up the stage environment to test the mobile apps before publishing them to App Store or Play Store:
- Install iOS or Android version from [Expo Client](https://expo.io/tools#client).
- Open the Expo Client you just installed and find the option to scan QR code.   
- Android
  - Scan the QR code https://expo.io/@rdok/expo-nextjs-template?release-channel=stage
  - This should download, install, and launch the latest version.
- iOS at this time does not allow QR code scanning.
