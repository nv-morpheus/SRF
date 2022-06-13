#!/bin/bash
# SPDX-FileCopyrightText: Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
# SPDX-License-Identifier: Apache-2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

source ${WORKSPACE}/ci/scripts/jenkins/common.sh

conda activate rapids

gpuci_logger "Installing CI dependencies"
mamba install -q -y -c conda-forge "yapf=0.32"

show_conda_info

gpuci_logger "Configuring CMake"
cmake -B build -G Ninja ${CMAKE_BUILD_ALL_FEATURES} .

gpuci_logger "Building targets that generate source code"
cmake --build build --target style_checks

gpuci_logger "Running C++ style checks"
${SRF_ROOT}/ci/scripts/cpp_checks.sh

gpuci_logger "Runing Python style checks"
${SRF_ROOT}/ci/scripts/python_checks.sh

gpuci_logger "Checking copyright headers"
python ${SRF_ROOT}/ci/scripts/copyright.py --verify-apache-v2 --git-diff-commits ${CHANGE_TARGET} ${GIT_COMMIT}
