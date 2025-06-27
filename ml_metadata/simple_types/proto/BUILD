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

load("@rules_proto//proto:defs.bzl", "proto_library")
load("@rules_cc//cc:defs.bzl", "cc_proto_library")
load("@rules_python//python:proto.bzl", "py_proto_library")

package(default_visibility = ["//ml_metadata:__subpackages__"])

licenses(["notice"])

proto_library(
    name = "simple_types_proto_proto",
    srcs = ["simple_types.proto"],
    deps = [
        "//ml_metadata/proto:metadata_store_proto_proto",
    ],
)

cc_proto_library(
    name = "simple_types_proto",
    deps = [
        ":simple_types_proto_proto",
    ],
)

py_proto_library(
    name = "simple_types_py_pb2",
    deps = [
        ":simple_types_proto_proto",
    ],
)