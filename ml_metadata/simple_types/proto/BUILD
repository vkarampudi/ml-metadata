# Copyright 2021 Google LLC
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
load("//ml_metadata:ml_metadata.bzl", "ml_metadata_proto_library", "ml_metadata_proto_library_py")

package(default_visibility = ["//ml_metadata:__subpackages__"])

licenses(["notice"])

ml_metadata_proto_library(
    name = "simple_types_proto",
    srcs = ["simple_types.proto"],
    deps = [
        "//ml_metadata/proto:metadata_store_proto",
    ],
)

ml_metadata_proto_library_py(
    name = "simple_types_py_pb2",
    deps = [":simple_types_proto"],
)
