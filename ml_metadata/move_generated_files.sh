#!/bin/bash
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

# Convenience binary to build MLMD from source.
# Put wrapped c++ files in place
# Should be run in the directory containing WORKSPACE file. (workspace root)

function _is_macos() {
  [[ "$(uname -s | tr 'A-Z' 'a-z')" =~ darwin ]]
}

function mlmd::move_generated_files() {
  #!/bin/bash
set -euxo pipefail

# Get the bazel-bin directory
bazel_bin=$(bazel info bazel-bin)

# Define the list of proto files to copy
declare -a proto_files=(
    "ml_metadata/proto/metadata_store_pb2.py"
    "ml_metadata/proto/metadata_store_service_pb2.py"
    "ml_metadata/proto/metadata_store_service_pb2_grpc.py"
    "ml_metadata/simple_types/proto/simple_types_pb2.py"
)

# Loop through each proto file and copy it
for proto_file in "${proto_files[@]}"; do
    source_file="${bazel_bin}/${proto_file}"
    dest_dir="${BUILD_WORKSPACE_DIRECTORY}/$(dirname "${proto_file}")"

    if [[ ! -f "${source_file}" ]]; then
        echo "Error: Source file not found: ${source_file}"
        echo "Check that the py_proto_library rules are correctly defined."
        exit 1
    fi

    mkdir -p "${dest_dir}"
    cp -f "${source_file}" "${dest_dir}"
done

# Copy the metadata store extension
MLMD_EXTENSION="ml_metadata/metadata_store/pywrap/metadata_store_extension.so"
source_extension="${bazel_bin}/${MLMD_EXTENSION}"
dest_extension="${BUILD_WORKSPACE_DIRECTORY}/${MLMD_EXTENSION}"

if [[ ! -f "${source_extension}" ]]; then
    echo "Error: Source extension not found: ${source_extension}"
    exit 1
fi

cp -f "${source_extension}" "${dest_extension}"
chmod +w "${dest_extension}"

echo "Generated files moved successfully."
