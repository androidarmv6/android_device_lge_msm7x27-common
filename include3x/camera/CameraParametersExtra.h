/*
 * Copyright (C) 2014 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define CAMERA_PARAMETERS_EXTRA_C \
const char CameraParameters::AUTO_EXPOSURE_CENTER_WEIGHTED[] = "center-weighted"; \
const char CameraParameters::AUTO_EXPOSURE_SPOT_METERING[] = "spot-metering"; \
const char CameraParameters::AUTO_EXPOSURE_FRAME_AVG[] = "frame-average"; \
const char CameraParameters::FOCUS_MODE_NORMAL[] = "normal"; \
const char CameraParameters::ISO_AUTO[] = "auto"; \
const char CameraParameters::ISO_100[] = "ISO100"; \
const char CameraParameters::ISO_200[] = "ISO200"; \
const char CameraParameters::ISO_400[] = "ISO400"; \
const char CameraParameters::ISO_800[] = "ISO800"; \
const char CameraParameters::ISO_HJR[] = "ISO_HJR"; \
const char CameraParameters::KEY_AUTO_EXPOSURE[] = "auto-exposure"; \
const char CameraParameters::KEY_EXIF_DATETIME[] = "exif-datetime"; \
const char CameraParameters::KEY_GPS_ALTITUDE_REF[] = "gps-altitude-ref"; \
const char CameraParameters::KEY_GPS_LATITUDE_REF[] = "gps-latitude-ref"; \
const char CameraParameters::KEY_GPS_LONGITUDE_REF[] = "gps-longitude-ref"; \
const char CameraParameters::KEY_GPS_STATUS[] = "gps-status"; \
const char CameraParameters::KEY_ISO_MODE[] = "iso"; \
const char CameraParameters::KEY_CONTRAST[] = "contrast"; \
const char CameraParameters::KEY_LENSSHADE[] = "lensshade"; \
const char CameraParameters::KEY_SATURATION[] = "saturation"; \
const char CameraParameters::KEY_SHARPNESS[] = "sharpness"; \
const char CameraParameters::KEY_SUPPORTED_AUTO_EXPOSURE[] = "auto-exposure-values"; \
const char CameraParameters::KEY_SUPPORTED_ISO_MODES[] = "iso-values"; \
const char CameraParameters::KEY_SUPPORTED_LENSSHADE_MODES[] = "lensshade-values"; \
const char CameraParameters::LENSSHADE_ENABLE[] = "enable"; \
const char CameraParameters::LENSSHADE_DISABLE[] = "disable"; \
const char CameraParameters::PIXEL_FORMAT_RAW[] = "raw"; \
const char CameraParameters::KEY_MAX_CONTRAST[] = "max-contrast"; \
const char CameraParameters::KEY_MAX_SATURATION[] = "max-saturation"; \
const char CameraParameters::KEY_MAX_SHARPNESS[] = "max-sharpness";


#define CAMERA_PARAMETERS_EXTRA_H \
static const char AUTO_EXPOSURE_CENTER_WEIGHTED[]; \
static const char AUTO_EXPOSURE_SPOT_METERING[]; \
static const char AUTO_EXPOSURE_FRAME_AVG[]; \
static const char FOCUS_MODE_NORMAL[]; \
static const char ISO_AUTO[]; \
static const char ISO_100[]; \
static const char ISO_200[]; \
static const char ISO_400[]; \
static const char ISO_800[]; \
static const char ISO_HJR[]; \
static const char KEY_AUTO_EXPOSURE[]; \
static const char KEY_EXIF_DATETIME[]; \
static const char KEY_GPS_ALTITUDE_REF[]; \
static const char KEY_GPS_LATITUDE_REF[]; \
static const char KEY_GPS_LONGITUDE_REF[]; \
static const char KEY_GPS_STATUS[]; \
static const char KEY_ISO_MODE[]; \
static const char KEY_CONTRAST[]; \
static const char KEY_LENSSHADE[]; \
static const char KEY_SATURATION[]; \
static const char KEY_SHARPNESS[] ; \
static const char KEY_SUPPORTED_AUTO_EXPOSURE[]; \
static const char KEY_SUPPORTED_ISO_MODES[]; \
static const char KEY_SUPPORTED_LENSSHADE_MODES[]; \
static const char LENSSHADE_ENABLE[]; \
static const char LENSSHADE_DISABLE[]; \
static const char PIXEL_FORMAT_RAW[]; \
static const char KEY_MAX_CONTRAST[]; \
static const char KEY_MAX_SATURATION[]; \
static const char KEY_MAX_SHARPNESS[];

