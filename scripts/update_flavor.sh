#!bin/bash  
echo "Cập nhật enviroment"
cd .. 
flutter pub get
flutter pub run flutter_flavorizr
echo "Update main file 1"
current_str="import 'package:flutter\/material.dart';"
new_str="import 'main.dart' as base;"
perl -pi -w -e "s/$current_str/$new_str/g;" lib/main_*.dart
echo "Update main file 2"
current_str="runApp\(App\(\)\);"
new_str="base.main();"
perl -pi -w -e "s/$current_str/$new_str/g;" lib/main_*.dart
echo "Update main file 3"
current_str="import 'app.dart';"
new_str=""
perl -pi -w -e "s/$current_str/$new_str/g;" lib/main_*.dart
cd script
