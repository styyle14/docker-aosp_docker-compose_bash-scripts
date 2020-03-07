# docker-aosp_docker-compose_bash-scripts
Bash Scripts to Control Docker Compose to Build AOSP

# -----------------------------------------------------------------------------------
# Build Steps

# https://source.android.com/setup/start/build-numbers#source-code-tags-and-builds
# QQ1A.191205.011 	android-10.0.0_r16 	Android10 	Pixel 3a XL, Pixel 3a 	2019-12-05
# QQ1A.200105.002 	android-10.0.0_r21 	Android10 	Pixel 3a XL, Pixel 3a 	2020-01-01
# QQ1A.200205.002 	android-10.0.0_r26 	Android10 	Pixel 3a XL, Pixel 3a   2020-02-05
# QQ2A.200305.002 	android-10.0.0_r30 	Android10 	Pixel 3a, Pixel 3a XL   2020-03-05
repo init -u https://android.googlesource.com/platform/manifest -b android-10.X.Y_rZZ

repo sync

# https://developers.google.com/android/drivers#bonito
./extract-qcom-bonito.sh

./extract-google_devices-bonito.sh

source build/envsetup.sh

# First time only?
ccache -M 100G

lunch aosp_bonito-userdebug

m clobber

m update-api

m system-api-stubs-docs-update-current-api

# "-j4" needed due to RAM limitations. 16GB is not enough with 8 threads...
m -j4

# -----------------------------------------------------------------------------------
# Flashing Steps

export PATH="$(readlink -f ../platform-tools_r29.0.5-linux/platform-tools):${PATH}"

export ANDROID_PRODUCT_OUT="$(readlink  -f ./out/target/product/bonito)"

# FIRST TIME!!! ==> The "-w" option wipes ALL user data; proceed with CAUTION!!!
# If fastboot not in root $PATH:
sudo "$(which fastboot)" flashall -w --slot b
# Otherwise
sudo fastboot flashall -w --slot b

# AFTER THE FIRST TIME
# TO PRESERVE USER DATA
sudo fastboot flashall --slot b
# Once boot.img has been patched by Magisk Manager app on phone:
sudo fastboot flash --slot b boot magisk_patched.img
