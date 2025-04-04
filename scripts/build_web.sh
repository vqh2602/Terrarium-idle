#!bin/bash  
echo "Nhập vào tên ứng dụng muốn build apk (dev, uat, prod ...):"  
read app_name 
echo "Build apk ứng dụng $app_name" 
sh ./adidaphat.sh

cd .. &&  flutter build web --release --base-href /terrarium_data.github.io/terrarium/ -t lib/main_$app_name.dart