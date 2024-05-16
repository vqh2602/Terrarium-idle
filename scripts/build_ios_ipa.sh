#!bin/bash  
echo "Nhập vào tên ứng dụng muốn build ipa (dev, uat, prod ...):"  
read app_name 
echo "Build ipa ứng dụng $app_name" 
cd .. &&  flutter build ipa  --flavor $app_name -t lib/main_$app_name.dart