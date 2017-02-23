#!/bin/sh

# Copyright 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
export ANDROID_PRODUCT_OUT=$HOME/AOSP/4.4.3_r1/out/target/product/mako

fastboot flash bootloader bootloader-mako-makoz30d.img
fastboot reboot-bootloader
sleep 5
fastboot flash radio radio-mako-m9615a-cefwmazm-2.0.1701.02.img
fastboot reboot-bootloader
sleep 5
#fastboot -w update image-occam-ktu84l.zip
fastboot -w flashall
