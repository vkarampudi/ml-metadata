# Copyright 2020 Google LLC
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

load("@rules_cc//cc:defs.bzl", "cc_proto_library")
load("@rules_proto//proto:defs.bzl", "proto_library")
load("@rules_python//python:proto.bzl", "py_proto_library")
load("//ml_metadata:ml_metadata.bzl", "ml_metadata_proto_library_go")

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

proto_library(
    name = "metadata_store_proto_proto",
    srcs = ["metadata_store.proto"],
    deps = [
        "@com_google_protobuf//:any_proto",
        "@com_google_protobuf//:duration_proto",
        "@com_google_protobuf//:empty_proto",
        "@com_google_protobuf//:struct_proto",
        "@com_google_protobuf//:timestamp_proto",
        "@com_google_protobuf//:wrappers_proto",
    ],
)

cc_proto_library(
    name = "metadata_store_proto",
    deps = [":metadata_store_proto_proto"],
)

py_proto_library(
    name = "metadata_store_py_pb2",
    deps = [":metadata_store_proto_proto"],
)

proto_library(
    name = "metadata_store_service_proto_proto",
    srcs = ["metadata_store_service.proto"],
    deps = [":metadata_store_proto_proto"],
)

cc_proto_library(
    name = "metadata_store_service_proto",
    deps = [":metadata_store_service_proto_proto"],
)

py_proto_library(
    name = "metadata_store_service_py_pb2",
    deps = [":metadata_store_service_proto_proto"],
)

ml_metadata_proto_library_go(
    name = "metadata_store_go_proto",
    srcs = ["metadata_store.proto"],
    importpath = "ml_metadata/proto/metadata_store_go_proto",
    deps = [":metadata_store_proto"],
)

ml_metadata_proto_library_go(
    name = "metadata_store_service_go_proto",
    srcs = ["metadata_store_service.proto"],
    cc_proto_deps = [":metadata_store_proto"],
    gen_oss_grpc = True,
    go_proto_deps = [":metadata_store_go_proto"],
    importpath = "ml_metadata/proto/metadata_store_service_go_proto",
    deps = [":metadata_store_service_proto"],
)

proto_library(
    name = "metadata_source_proto_proto",
    srcs = ["metadata_source.proto"],
    deps = [
        "@com_google_protobuf//:any_proto",
        "@com_google_protobuf//:duration_proto",
        "@com_google_protobuf//:empty_proto",
        "@com_google_protobuf//:struct_proto",
        "@com_google_protobuf//:timestamp_proto",
        "@com_google_protobuf//:wrappers_proto",
    ],
)

cc_proto_library(
    name = "metadata_source_proto",
    deps = [":metadata_source_proto_proto"],
)
