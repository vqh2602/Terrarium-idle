#!bin/bash  
echo "Nhập vào tên ứng dụng muốn run (dev, uat, prod ...):"  
read app_name 
echo "Run ứng dụng $app_name" 
cd .. &&  flutter run  --flavor $app_name -t lib/main_$app_name.dart