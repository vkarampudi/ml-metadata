load("@bazel_skylib//lib:selects.bzl", "selects")

licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])

config_setting(
    name = "macos_x86_64",
    values = {
        "apple_platform_type": "macos",
        "cpu": "darwin",
    },
)

config_setting(
    name = "macos_arm64",
    values = {
        "apple_platform_type": "macos",
        "cpu": "darwin_arm64",
    },
)

selects.config_setting_group(
    name = "macos",
    match_any = [
        ":macos_x86_64",
        ":macos_arm64",
    ],
)

_public_protos = [
    "//ml_metadata/simple_types/proto:simple_types_py_pb2",
    "//ml_metadata/proto:metadata_store_py_pb2",
    "//ml_metadata/proto:metadata_store_service_py_pb2",
]

_py_extension = select({
    "//conditions:default": [
        "//ml_metadata/metadata_store/pywrap:metadata_store_extension.so",
    ],
})

sh_binary(
    name = "move_generated_files",
    srcs = ["move_generated_files.sh"],
    data = _py_extension + _public_protos,
)
