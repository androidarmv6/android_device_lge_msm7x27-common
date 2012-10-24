# This script installs automatically all needed patches for the devices supported by lgics. #
# Concept and enhancements by Rashed97, reviewed by Bytecode #

echo "Obtaining build directory..."
rootdirectory="$PWD"
repo start non-patched frameworks/base
repo start patched frameworks/base
cd frameworks/base
echo "Applying frameworks/base patches..."
git am $rootdirectory/device/lge/msm7x27-common/patches/frameworks_base/*.patch
cd $rootdirectory
repo start non-patched frameworks/av
repo start patched frameworks/av
cd frameworks/av
echo "Applying frameworks/av patches..."
git pull http://review.cyanogenmod.com/CyanogenMod/android_frameworks_av refs/changes/03/23603/1
cd $rootdirectory
repo start non-patched frameworks/native
repo start patched frameworks/native
cd frameworks/native
echo "Applying frameworks/native patches..."
git pull http://review.cyanogenmod.com/CyanogenMod/android_frameworks_native refs/changes/02/23602/1
cd $rootdirectory
repo start non-patched packages/apps/LegacyCamera
repo start patched packages/apps/LegacyCamera
cd packages/apps/LegacyCamera
echo "Applying LegacyCamera patches..."
git pull http://review.cyanogenmod.com/CyanogenMod/android_packages_apps_LegacyCamera refs/changes/79/24979/2
git pull http://review.cyanogenmod.com/CyanogenMod/android_packages_apps_LegacyCamera refs/changes/80/24980/1
git pull http://review.cyanogenmod.com/CyanogenMod/android_packages_apps_LegacyCamera refs/changes/81/24981/1
git pull http://review.cyanogenmod.com/CyanogenMod/android_packages_apps_LegacyCamera refs/changes/13/25113/2
cd $rootdirectory
repo start non-patched packages/apps/Gallery2
repo start patched packages/apps/Gallery2
cd packages/apps/Gallery2
echo "Applying Gallery2 patches..."
git pull http://review.cyanogenmod.com/CyanogenMod/android_packages_apps_Gallery2 refs/changes/15/25115/3
cd $rootdirectory
repo start non-patched packages/apps/Settings
repo start patched packages/apps/Settings
cd packages/apps/Settings
echo "Applying Settings patches..."
git am $rootdirectory/device/lge/msm7x27-common/patches/packages_apps_Settings/0001-Add-forum-link-to-device-info.patch
cd $rootdirectory
repo start non-patched external/libncurses
repo start patched external/libncurses
cd external/libncurses
echo "Applying libncurses patches..."
git am $rootdirectory/device/lge/msm7x27-common/patches/external_libncurses/0001-Revert-Adding-code-to-copy-terminfo-data-to-system-e.patch
cd $rootdirectory
repo start non-patched external/webkit
repo start patched external/webkit
cd external/webkit
echo "Applying webkit patches..."
git am $rootdirectory/device/lge/msm7x27-common/patches/external_webkit/0001-Hack-shaders-to-work-on-devices-without-OES_external.patch
echo "Changing to build directory..."
cd $rootdirectory