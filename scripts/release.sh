#!bin/bash  
cd ..
dart pub global activate pub_release
export PATH="$PATH":"$HOME/.pub-cache/bin"
pub_release
cd ./script