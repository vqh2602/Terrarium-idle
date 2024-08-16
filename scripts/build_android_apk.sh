#!bin/bash  
echo "Nhập vào tên ứng dụng muốn build apk (dev, uat, prod ...):"  
read app_name 
echo "Build apk ứng dụng $app_name" 
sh ./adidaphat.sh

cp -r ./.android/* ../android
cd .. &&  flutter build apk  --flavor $app_name -t lib/main_$app_name.dart