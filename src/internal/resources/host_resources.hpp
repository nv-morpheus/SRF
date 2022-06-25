/**
 * SPDX-FileCopyrightText: Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 * SPDX-License-Identifier: Apache-2.0
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

#pragma once

#include "internal/runnable/resources.hpp"
#include "internal/system/host_partition_provider.hpp"
#include "internal/ucx/registation_callback_builder.hpp"

#include <srf/memory/resources/memory_resource.hpp>

#include <memory>

namespace srf::internal::resources {

class HostResources final : public system::HostPartitionProvider
{
  public:
    HostResources(runnable::Resources& runnable, ucx::RegistrationCallbackBuilder&& callbacks);

  private:
    std::shared_ptr<srf::memory::memory_resource> m_raw;
    std::shared_ptr<srf::memory::memory_resource> m_registered;
    std::shared_ptr<srf::memory::memory_resource> m_arena;
};

}  // namespace srf::internal::resources
