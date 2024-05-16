#!/bin/bash

echo "Nhập vào tên ứng dụng muốn build ipa (dev, uat, prod ...):"
#read app_name 
app_name=${app_name:-dev}
echo "Build ipa ứng dụng $app_name" && flutter build ipa --flavor $app_name
echo "Start build fastlane"
cd ../ && cd ios && fastlane release_$app_name
