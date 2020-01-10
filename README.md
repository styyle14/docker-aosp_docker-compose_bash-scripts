# docker-aosp_docker-compose_bash-scripts
Bash Scripts to Control Docker Compose to Build AOSP

# https://source.android.com/setup/start/build-numbers#source-code-tags-and-builds
# QQ1A.191205.011 	android-10.0.0_r16 	Android10 	Pixel 3a XL, Pixel 3a 	2019-12-05
# QQ1A.200105.002 	android-10.0.0_r21 	Android10 	Pixel 3a XL, Pixel 3a 	2020-01-01
repo init -u https://android.googlesource.com/platform/manifest -b android-10.0.0_r16

repo sync

./extract-qcom-bonito.sh

./extract-google_devices-bonito.sh

source build/envsetup.sh

ccache -M 100G

lunch aosp_bonito-userdebug

m clobber

m update-api

m system-api-stubs-docs-update-current-api

m

# Flashing steps

export PATH="$(readlink -f ./platform-tools_r29.0.5-linux/platform-tools):${PATH}"

export ANDROID_PRODUCT_OUT="$(readlink  -f ./out/target/product/bonito)"

# FIRST TIME!!!
# If sudo needed
sudo -E "$(which fastboot)" flashall -w --slot b
# Otherwise
fastboot flashall -w --slot b

# TO PRESERVE USER DATA
sudo -E "$(which fastboot)" flashall --slot b
sudo -E "$(which fastboot)" flash --slot b boot ./out/target/product/bonito/magisk_patched.img
