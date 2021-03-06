#!/usr/bin/bash
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

restore_conda_env

gpuci_logger "Fetching Build artifacts from ${DISPLAY_ARTIFACT_URL}/"
fetch_s3 "${ARTIFACT_ENDPOINT}/cpp_tests.tar.bz" "${WORKSPACE_TMP}/cpp_tests.tar.bz"
fetch_s3 "${ARTIFACT_ENDPOINT}/dsos.tar.bz" "${WORKSPACE_TMP}/dsos.tar.bz"

tar xf "${WORKSPACE_TMP}/cpp_tests.tar.bz"
tar xf "${WORKSPACE_TMP}/dsos.tar.bz"

mkdir -p ${WORKSPACE_TMP}/reports
