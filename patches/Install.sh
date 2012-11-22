# This script installs automatically all needed patches for the devices supported by lgics. #
# Concept and enhancements by Rashed97, reviewed by Bytecode #

echo "Obtaining build directory..."
rootdirectory="$PWD"
repo start non-patched build
repo start patched build
cd build
echo "Applying build patches..."
git pull http://github.com/androidarmv6/android_build jellybean
cd $rootdirectory
repo start non-patched frameworks/base
repo start patched frameworks/base
cd frameworks/base
echo "Applying frameworks/base patches..."
git am $rootdirectory/device/lge/msm7x27-common/patches/frameworks/base/*.patch
cd $rootdirectory
repo start non-patched frameworks/av
repo start patched frameworks/av
cd frameworks/av
echo "Applying frameworks/av patches..."
git pull http://github.com/androidarmv6/android_frameworks_av jellybean
cd $rootdirectory
repo start non-patched frameworks/native
repo start patched frameworks/native
cd frameworks/native
echo "Applying frameworks/native patches..."
git pull http://github.com/androidarmv6/android_frameworks_native jellybean
cd $rootdirectory
repo start non-patched hardware/qcom/media
repo start patched hardware/qcom/media
cd hardware/qcom/media
echo "Applying hardware/qcom/media patches..."
git pull http://github.com/androidarmv6/android_hardware_qcom_media jellybean
cd $rootdirectory
repo start non-patched packages/apps/Settings
repo start patched packages/apps/Settings
cd packages/apps/Settings
echo "Applying Settings patches..."
git am $rootdirectory/device/lge/msm7x27-common/patches/packages/apps/Settings/0001-Add-forum-link.patch
cd $rootdirectory
repo start non-patched external/libncurses
repo start patched external/libncurses
cd external/libncurses
echo "Applying libncurses patches..."
git am $rootdirectory/device/lge/msm7x27-common/patches/external/libncurses/0001-Revert-Adding-code-to-copy-terminfo-data-to-system-e.patch
echo "Changing to build directory..."
cd $rootdirectory