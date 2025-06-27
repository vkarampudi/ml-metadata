# Copyright 2019 Google LLC
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
#
# This file is internal only. See opensource_only/ml_metadata.bzl.
""" A bridge between internal rules and OSS bazel rules.

It includes mappings between proto API and Google internal proto library:
- proto_library
- py_proto_library
- go_proto_library

It also includes bazel rules-go and Google internal Go rules:
- go_library
- go_test
- go_wrap_cc

For example use, see ml_metadata/metadata_store/BUILD
"""

load("//third_party/bazel_rules/rules_python/python:proto.bzl", "py_proto_library")
load("//third_party/bazel_rules/rules_python/python:py_extension.bzl", "py_extension")
load("//third_party/protobuf/bazel:proto_library.bzl", "proto_library")
load("//tools/build_defs/go:go_library.bzl", "go_library")
load("//tools/build_defs/go:go_proto_library.bzl", "go_proto_library")
load("//tools/build_defs/go:go_test.bzl", "go_test")
load("//tools/build_defs/go:go_wrap_cc.bzl", "go_wrap_cc")
load("//tools/build_defs/proto/cpp:cc_grpc_library.bzl", "cc_grpc_library")
load("//tools/build_defs/proto/cpp:cc_proto_library.bzl", "cc_proto_library")
load("//tools/build_defs/proto/cpp:proto_names_to_cc_proto_names.bzl", "cc_proto_library_name_from_proto_name")

def ml_metadata_cc_test(
        name,
        srcs = [],
        deps = [],
        env = {},
        tags = [],
        args = [],
        size = None,
        data = []):
    native.cc_test(
        name = name,
        srcs = srcs,
        env = env,
        deps = deps,
        tags = tags,
        args = args,
        size = size,
        data = data,
    )

def ml_metadata_proto_library(name, **kwargs):
    """Google proto_library and cc_proto_library.

    Args:
        name = name,
        **kwargs: Keyword arguments to pass to the proto libraries."""
    well_known_protos = [
        "@com_google_protobuf//:any_proto",
        "@com_google_protobuf//:duration_proto",
        "@com_google_protobuf//:timestamp_proto",
        "@com_google_protobuf//:struct_proto",
        "@com_google_protobuf//:empty_proto",
        "@com_google_protobuf//:wrappers_proto",
    ]
    kwargs["deps"] = kwargs.get("deps", []) + well_known_protos
    proto_library(name = name, **kwargs)  # buildifier: disable=native-proto
    cc_proto_kwargs = {
        "deps": [":" + name],
    }
    if "visibility" in kwargs:
        cc_proto_kwargs["visibility"] = kwargs["visibility"]
    if "testonly" in kwargs:
        cc_proto_kwargs["testonly"] = kwargs["testonly"]
    if "compatible_with" in kwargs:
        cc_proto_kwargs["compatible_with"] = kwargs["compatible_with"]
    cc_proto_library(name = name + "_cc_pb2", **cc_proto_kwargs)


def ml_metadata_proto_library_with_grpc(
        name,
        srcs = [],
        has_services = False,
        deps = [],
        visibility = None,
        testonly = 0):
    ml_metadata_proto_library(
        name = name,
        srcs = srcs,
        has_services = has_services,
        deps = deps,
        testonly = testonly,
        visibility = visibility,
    )

    cc_proto_name = name + "_cc_pb2"
    if has_services:
        cc_grpc_library(
            name = name[:-len("_proto")] + "_cc_grpc_proto",
            srcs = [name],
            deps = [cc_proto_library_name_from_proto_name(name)],
        )

def ml_metadata_proto_library_py(
        name,
        proto_library,
        api_version = None,
        srcs = [],
        deps = [],
        visibility = None,
        testonly = 0,
        oss_deps = [],
        use_grpc_plugin = False):
    _ignore = [deps, srcs, oss_deps]
    py_proto_library(
        name = name,
        deps = [proto_library],
        visibility = visibility,
        testonly = testonly,
        has_services = use_grpc_plugin,
    )
    
# Go toolchain rules in OSS is different from internal blaze rules. The
# following rules simply wraps the native blaze rule, define and ignore
# parameters used in OSS bazel rules-go.
def ml_metadata_proto_library_go(
        name,
        deps = [],
        srcs = [],
        importpath = None,
        cc_proto_deps = [],
        go_proto_deps = [],
        gen_oss_grpc = False):
    _ignore = [srcs, importpath, cc_proto_deps, go_proto_deps, gen_oss_grpc]
    go_proto_library(
        name = name,
        deps = deps,
    )

def ml_metadata_go_library(
        name,
        srcs = [],
        deps = [],
        importpath = None,
        cgo = None,
        cdeps = None):
    _ignore = [importpath, cgo, cdeps]
    go_library(
        name = name,
        srcs = srcs,
        deps = deps,
    )

def ml_metadata_go_test(
        name,
        srcs = [],
        size = None,
        library = None,
        deps = []):
    go_test(
        name = name,
        size = size,
        srcs = srcs,
        library = library,
        deps = deps,
    )

# Swig go_wrap_cc is an internal only rule. OSS bazel rules-go does not support
# swig to c++. Only -cgo mode is available.
# Internally, `swigfile`.i is renamed to `swigfile`.swig, and used to build the
# wrap cc and library.
def ml_metadata_go_wrap_cc(
        name,
        swigfile = None,
        deps = [],
        libname = None,
        importpath = None):
    _ignore = [libname, importpath]

    native.genrule(
        name = name + "_renamerule",
        srcs = [swigfile + ".i"],
        outs = [swigfile + ".swig"],
        cmd = """
      for FILE in $(SRCS); do
        cp "$$FILE" "$(GENDIR)/$$(dirname $$FILE)/`basename $$FILE .i`.swig";
      done;
      """,
    )
    go_wrap_cc(
        name = name,
        srcs = [swigfile + ".swig"],
        deps = deps,
    )

# Pybind11 py_extension is an internal only rule.
def ml_metadata_pybind_extension(
        name,
        srcs,
        module_name,
        deps = [],
        visibility = None):
    py_extension(
        name = name,
        module_name = module_name,
        srcs = srcs,
        srcs_version = "PY3ONLY",
        copts = [
            "-fno-strict-aliasing",
            "-fexceptions",
        ],
        features = ["-use_header_modules"],
        deps = deps,
        visibility = visibility,
    )
