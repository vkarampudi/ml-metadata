workspace(name = "ml_metadata")

load("//ml_metadata:repo.bzl", "clean_dep")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "postgresql",
    build_file = "//ml_metadata:postgresql.BUILD",
    workspace_file_content = "//ml_metadata:postgresql.WORKSPACE",
    sha256 = "9868c1149a04bae1131533c5cbd1c46f9c077f834f6147abaef8791a7c91b1a1",
    strip_prefix = "postgresql-12.1",
    urls = [
        "https://ftp.postgresql.org/pub/source/v12.1/postgresql-12.1.tar.gz",
    ],
)

#Install bazel platform version 0.0.6
http_archive(
    name = "platforms",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/platforms/releases/download/0.0.6/platforms-0.0.6.tar.gz",
        "https://github.com/bazelbuild/platforms/releases/download/0.0.6/platforms-0.0.6.tar.gz",
    ],
    sha256 = "5308fc1d8865406a49427ba24a9ab53087f17f5266a7aabbfc28823f3916e1ca",
)

# Install version 0.9.0 of rules_foreign_cc, as default version causes an
# invalid escape sequence error to be raised, which can't be avoided with
# the --incompatible_restrict_string_escapes=false flag (flag was removed in
# Bazel 5.0).
RULES_FOREIGN_CC_VERSION = "0.9.0"
http_archive(
    name = "rules_foreign_cc",
    sha256 = "2a4d07cd64b0719b39a7c12218a3e507672b82a97b98c6a89d38565894cf7c51",
    strip_prefix = "rules_foreign_cc-%s" % RULES_FOREIGN_CC_VERSION,
    url = "https://github.com/bazelbuild/rules_foreign_cc/archive/refs/tags/%s.tar.gz" % RULES_FOREIGN_CC_VERSION,
    patch_tool = "patch",
    patches = ["//ml_metadata/third_party:rules_foreign_cc.patch",],
)

load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")
rules_foreign_cc_dependencies()

http_archive(
    name = "com_google_absl",
    sha256 = "df8b3e0da03567badd9440377810c39a38ab3346fa89df077bb52e68e4d61e74",
    strip_prefix = "abseil-cpp-4447c7562e3bc702ade25105912dce503f0c4010",
    url = "https://github.com/abseil/abseil-cpp/archive/4447c7562e3bc702ade25105912dce503f0c4010.tar.gz",
)

http_archive(
    name = "rules_proto",
    sha256 = "6fb6767d1bef535310547e03247f7518b03487740c11b6c6adb7952033fe1295",
    strip_prefix = "rules_proto-6.0.2",
    url = "https://github.com/bazelbuild/rules_proto/releases/download/6.0.2/rules_proto-6.0.2.tar.gz",
)

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies")

rules_proto_dependencies()

load("@rules_proto//proto:setup.bzl", "rules_proto_setup")

rules_proto_setup()

load("@rules_proto//proto:toolchains.bzl", "rules_proto_toolchains")

rules_proto_toolchains()

http_archive(
    name = "boringssl",
    sha256 = "1188e29000013ed6517168600fc35a010d58c5d321846d6a6dfee74e4c788b45",
    strip_prefix = "boringssl-7f634429a04abc48e2eb041c81c5235816c96514",
    urls = [
        "https://github.com/google/boringssl/archive/7f634429a04abc48e2eb041c81c5235816c96514.tar.gz",
    ],
)

http_archive(
    name = "org_sqlite",
    build_file = clean_dep("//ml_metadata/third_party:sqlite.BUILD"),
    sha256 = "87775784f8b22d0d0f1d7811870d39feaa7896319c7c20b849a4181c5a50609b",
    strip_prefix = "sqlite-amalgamation-3390200",
    urls = [
        "https://www.sqlite.org/2022/sqlite-amalgamation-3390200.zip",
    ],
)

http_archive(
    name = "com_google_googletest",
    sha256 = "81964fe578e9bd7c94dfdb09c8e4d6e6759e19967e397dbea48d1c10e45d0df2",
    strip_prefix = "googletest-release-1.12.1",
    urls = ["https://github.com/google/googletest/archive/refs/tags/release-1.12.1.tar.gz"],
)

http_archive(
    name = "com_google_glog",
    build_file = clean_dep("//ml_metadata/third_party:glog.BUILD"),
    strip_prefix = "glog-96a2f23dca4cc7180821ca5f32e526314395d26a",
    urls = [
      "https://github.com/google/glog/archive/96a2f23dca4cc7180821ca5f32e526314395d26a.zip",
    ],
    sha256 = "6281aa4eeecb9e932d7091f99872e7b26fa6aacece49c15ce5b14af2b7ec050f",
)

# 1.5.0
http_archive(
    name = "bazel_skylib",
    sha256 = "cd55a062e763b9349921f0f5db8c3933288dc8ba4f76dd9416aac68acee3cb94",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.5.0/bazel-skylib-1.5.0.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.5.0/bazel-skylib-1.5.0.tar.gz",
    ],
)

# Needed by abseil-py by zetasql.
http_archive(
    name = "six_archive",
    urls = [
        "http://mirror.bazel.build/pypi.python.org/packages/source/s/six/six-1.10.0.tar.gz",
        "https://pypi.python.org/packages/source/s/six/six-1.10.0.tar.gz",
    ],
    sha256 = "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a",
    strip_prefix = "six-1.10.0",
    build_file = "//ml_metadata/third_party:six.BUILD"
)

http_archive(
    name = "com_google_protobuf",
    sha256 = "4e6727bc5d23177edefa3ad86fd2f5a92cd324151636212fd1f7f13aef3fd2b7",
    strip_prefix = "protobuf-4.25.6",
    urls = ["https://github.com/protocolbuffers/protobuf/archive/v4.25.6.tar.gz"],
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

# Needed by Protobuf.
http_archive(
    name = "zlib",
    build_file = "@com_google_protobuf//:third_party/zlib.BUILD",
    sha256 = "d8688496ea40fb61787500e863cc63c9afcbc524468cedeb478068924eb54932",
    strip_prefix = "zlib-1.2.12",
    urls = ["https://github.com/madler/zlib/archive/v1.2.12.tar.gz"],
)

http_archive(
    name = "pybind11_bazel",
    strip_prefix = "pybind11_bazel-faf56fb3df11287f26dbc66fdedf60a2fc2c6631",
    urls = ["https://github.com/pybind/pybind11_bazel/archive/faf56fb3df11287f26dbc66fdedf60a2fc2c6631.tar.gz"],
    sha256 = "a2b107b06ffe1049696e132d39987d80e24d73b131d87f1af581c2cb271232f8",
)

http_archive(
    name = "pybind11",
    build_file = "//ml_metadata/third_party:pybind11.BUILD",
    sha256 = "8f4b7f28d214e36301435c055076c36186388dc9617117802cba8a059347cb00",
    strip_prefix = "pybind11-8a099e44b3d5f85b20f05828d919d2332a8de841",
    urls = ["https://github.com/pybind/pybind11/archive/8a099e44b3d5f85b20f05828d919d2332a8de841.zip"],
)

load("//ml_metadata/third_party:python_configure.bzl", "local_python_configure")

local_python_configure(name = "local_config_python")

http_archive(
    name = "com_github_grpc_grpc",
    urls = ["https://github.com/grpc/grpc/archive/v1.50.0.tar.gz"],
    sha256 = "76900ab068da86378395a8e125b5cc43dfae671e09ff6462ddfef18676e2165a",
    strip_prefix = "grpc-1.50.0",
)

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")
grpc_deps()

load("@com_github_grpc_grpc//bazel:grpc_extra_deps.bzl", "grpc_extra_deps")
grpc_extra_deps()

# Needed by Protobuf.
bind(
    name = "grpc_python_plugin",
    actual = "@com_github_grpc_grpc//src/compiler:grpc_python_plugin",
)

# Needed by Protobuf.
bind(
    name = "grpc_lib",
    actual = "@com_github_grpc_grpc//:grpc++",
)

# Needed by gRPC.
http_archive(
    name = "build_bazel_rules_swift",
    sha256 = "d0833bc6dad817a367936a5f902a0c11318160b5e80a20ece35fb85a5675c886",
    strip_prefix = "rules_swift-3eeeb53cebda55b349d64c9fc144e18c5f7c0eb8",
    urls = ["https://github.com/bazelbuild/rules_swift/archive/3eeeb53cebda55b349d64c9fc144e18c5f7c0eb8.tar.gz"],
)



http_archive(
    name = "io_bazel_rules_go",
    urls = [
        "https://storage.googleapis.com/bazel-mirror/github.com/bazelbuild/rules_go/releases/download/v0.20.3/rules_go-v0.20.3.tar.gz",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.20.3/rules_go-v0.20.3.tar.gz",
    ],
    sha256 = "e88471aea3a3a4f19ec1310a55ba94772d087e9ce46e41ae38ecebe17935de7b",
)

load("@io_bazel_rules_go//go:deps.bzl", "go_rules_dependencies", "go_register_toolchains")

http_archive(
    name = "bazel_gazelle",
    urls = [
        "https://storage.googleapis.com/bazel-mirror/github.com/bazelbuild/bazel-gazelle/releases/download/v0.19.1/bazel-gazelle-v0.19.1.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.19.1/bazel-gazelle-v0.19.1.tar.gz",
    ],
    sha256 = "86c6d481b3f7aedc1d60c1c211c6f76da282ae197c3b3160f54bd3a8f847896f",
)

load("@bazel_gazelle//:deps.bzl", "go_repository", "gazelle_dependencies")

go_repository(
    name = "org_golang_x_sys",
    commit = "57f5ac02873b2752783ca8c3c763a20f911e4d89",
    importpath = "golang.org/x/sys",
)

go_repository(
    name = "com_github_google_go_cmp",
    importpath = "github.com/google/go-cmp",
    tag = "v0.2.0",
)

go_repository(
    name = "com_github_golang_protobuf",
    importpath = "github.com/golang/protobuf",
    tag = "v1.3.2",
)

go_repository(
    name = "org_golang_google_protobuf",
    importpath = "google.golang.org/protobuf",
    tag = "v1.25.0",
)

go_repository(
    name = "org_golang_x_net",
    importpath = "golang.org/x/net",
    commit = "b3afb19ee333d5231c1034d3ac2a5313cde533a3",
)

go_rules_dependencies()

go_register_toolchains()

gazelle_dependencies()

# For commandline flags used in gRPC server
# gflags needed by glog
http_archive(
    name = "com_github_gflags_gflags",
    strip_prefix = "gflags-a738fdf9338412f83ab3f26f31ac11ed3f3ec4bd",
    sha256 = "017e0a91531bfc45be9eaf07e4d8fed33c488b90b58509dbd2e33a33b2648ae6",
    url = "https://github.com/gflags/gflags/archive/a738fdf9338412f83ab3f26f31ac11ed3f3ec4bd.zip",
)

ZETASQL_COMMIT = "a516c6b26d183efc4f56293256bba92e243b7a61" # 11/01/2024
http_archive(
    name = "com_google_zetasql",
    patch_args = ["-p1"],
    patches = ["//ml_metadata/third_party:zetasql.patch"],
    urls = ["https://github.com/google/zetasql/archive/%s.zip" % ZETASQL_COMMIT],
    strip_prefix = "zetasql-%s" % ZETASQL_COMMIT,
    sha256 = '8db98b93bd6bb7348ed6d374f8eb6b602f7012bd5d368b3ffdee0a56c6c8d85f'
)

load("@com_google_zetasql//bazel:zetasql_deps_step_1.bzl", "zetasql_deps_step_1")
zetasql_deps_step_1()
load("@com_google_zetasql//bazel:zetasql_deps_step_2.bzl", "zetasql_deps_step_2")
zetasql_deps_step_2(
    analyzer_deps = True,
    evaluator_deps = True,
    tools_deps = False,
    java_deps = False,
    testing_deps = False)

# This is part of what zetasql_deps_step_3() does.
load("@com_google_googleapis//:repository_rules.bzl", "switched_rules_by_language")
switched_rules_by_language(
    name = "com_google_googleapis_imports",
    cc = True,
)



# Please add all new ML Metadata dependencies in workspace.bzl.
load("//ml_metadata:workspace.bzl", "ml_metadata_workspace")

ml_metadata_workspace()

# Specify the minimum required bazel version.
load("@bazel_skylib//lib:versions.bzl", "versions")
versions.check("6.5.0")