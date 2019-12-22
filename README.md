# docker-aosp_docker-compose_bash-scripts
Bash Scripts to Control Docker Compose to Build AOSP

repo init -u https://android.googlesource.com/platform/manifest

repo sync

./extract-qcom-bonito.sh

./extract-google_devices-bonito.sh

source build/envsetup.sh

lunch aosp_bonito-userdebug

m
