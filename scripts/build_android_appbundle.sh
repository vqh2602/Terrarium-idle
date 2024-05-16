#!bin/bash  
echo "Nhập vào tên ứng dụng muốn build appbundle (dev, uat, prod ...):"  
read app_name 
echo "Build appbundle ứng dụng $app_name" 
cp -r ./.android/* ../android
cd .. &&  flutter build appbundle  --flavor $app_name -t lib/main_$app_name.dart