workspace(name = "ml_metadata")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "google_bazel_common",
    sha256 = "82a49fb27c01ad184db948747733159022f9464fc2e62da996fa700594d9ea42",
    strip_prefix = "bazel-common-2a6b6406e12208e02b2060df0631fb30919080f3",
    urls = ["https://github.com/google/bazel-common/archive/2a6b6406e12208e02b2060df0631fb30919080f3.zip"],
)

################################################################################
# Generic Bazel Support                                                        #
################################################################################

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

# Install version 0.9.0 of rules_foreign_cc, as default version causes an
# invalid escape sequence error to be raised, which can't be avoided with
# the --incompatible_restrict_string_escapes=false flag (flag was removed in
# Bazel 5.0).
RULES_FOREIGN_CC_VERSION = "0.9.0"

http_archive(
    name = "rules_foreign_cc",
    patch_tool = "patch",
    patches = ["//ml_metadata/third_party:rules_foreign_cc.patch"],
    sha256 = "2a4d07cd64b0719b39a7c12218a3e507672b82a97b98c6a89d38565894cf7c51",
    strip_prefix = "rules_foreign_cc-%s" % RULES_FOREIGN_CC_VERSION,
    url = "https://github.com/bazelbuild/rules_foreign_cc/archive/refs/tags/%s.tar.gz" % RULES_FOREIGN_CC_VERSION,
)

load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")

rules_foreign_cc_dependencies()

http_archive(
    name = "bazel_skylib",
    sha256 = "97e70364e9249702246c0e9444bccdc4b847bed1eb03c5a3ece4f83dfe6abc44",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
    ],
)

_PROTOBUF_COMMIT = "4.25.6"  # 4.25.6

http_archive(
    name = "com_google_protobuf",
    sha256 = "ff6e9c3db65f985461d200c96c771328b6186ee0b10bc7cb2bbc87cf02ebd864",
    strip_prefix = "protobuf-%s" % _PROTOBUF_COMMIT,
    urls = [
        "https://github.com/protocolbuffers/protobuf/archive/v4.25.6.zip",
    ],
)

# Needed by abseil-py by zetasql.
http_archive(
    name = "six_archive",
    build_file = "//ml_metadata/third_party:six.BUILD",
    sha256 = "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a",
    strip_prefix = "six-1.10.0",
    urls = [
        "http://mirror.bazel.build/pypi.python.org/packages/source/s/six/six-1.10.0.tar.gz",
        "https://pypi.python.org/packages/source/s/six/six-1.10.0.tar.gz",
    ],
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

COM_GOOGLE_ABSL_COMMIT = "4447c7562e3bc702ade25105912dce503f0c4010"  # lts_2023_08_0

http_archive(
    name = "com_google_absl",
    sha256 = "df8b3e0da03567badd9440377810c39a38ab3346fa89df077bb52e68e4d61e74",
    strip_prefix = "abseil-cpp-%s" % COM_GOOGLE_ABSL_COMMIT,
    url = "https://github.com/abseil/abseil-cpp/archive/%s.tar.gz" % COM_GOOGLE_ABSL_COMMIT,
)

PYBIND11_COMMIT = "8a099e44b3d5f85b20f05828d919d2332a8de841"  # 2.11.1



load("//ml_metadata/third_party:python_configure.bzl", "local_python_configure")

local_python_configure(name = "local_config_python")

load("//ml_metadata/third_party:python_configure.bzl", "local_python_configure")

local_python_configure(name = "local_config_python")

http_archive(
    name = "pybind11",
    build_file = "//ml_metadata/third_party:pybind11.BUILD",
    sha256 = "8f4b7f28d214e36301435c055076c36186388dc9617117802cba8a059347cb00",
    strip_prefix = "pybind11-%s" % PYBIND11_COMMIT,
    urls = ["https://github.com/pybind/pybind11/archive/%s.zip" % PYBIND11_COMMIT],
)

################################################################################
# Google APIs protos                                                           #
################################################################################
http_archive(
    name = "com_google_googleapis",
    patch_args = ["-p1"],
    patches = ["//ml_metadata/third_party:googleapis.patch"],
    sha256 = "28e7fe3a640dd1f47622a4c263c40d5509c008cc20f97bd366076d5546cccb64",
    strip_prefix = "googleapis-4ce00b00904a7ce1df8c157e54fcbf96fda0dc49",
    url = "https://github.com/googleapis/googleapis/archive/4ce00b00904a7ce1df8c157e54fcbf96fda0dc49.tar.gz",
)

load("@com_google_googleapis//:repository_rules.bzl", "switched_rules_by_language")

switched_rules_by_language(
    name = "com_google_googleapis_imports",
    cc = True,
    go = True,
)

###############################################################################
# Gazelle Support                                                             #
###############################################################################

_rules_go_version = "v0.48.1"

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "b2038e2de2cace18f032249cb4bb0048abf583a36369fa98f687af1b3f880b26",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/{0}/rules_go-{0}.zip".format(_rules_go_version),
        "https://github.com/bazelbuild/rules_go/releases/download/{0}/rules_go-{0}.zip.format(_rules_go_version)",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.21.11")

_bazel_gazelle_version = "0.36.0"

http_archive(
    name = "bazel_gazelle",
    sha256 = "75df288c4b31c81eb50f51e2e14f4763cb7548daae126817247064637fd9ea62",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v{0}/bazel-gazelle-v{0}.tar.gz".format(_bazel_gazelle_version),
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v{0}/bazel-gazelle-v{0}.tar.gz".format(_bazel_gazelle_version),
    ],
)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

################################################################################
# ZetaSQL                                                                      #
################################################################################

ZETASQL_COMMIT = "a516c6b26d183efc4f56293256bba92e243b7a61"  # 11/01/2024

http_archive(
    name = "build_bazel_apple_support",
    sha256 = "df317473b5894dd8eb432240d209271ebc83c76bb30c55481374b36ddf1e4fd1",
    url = "https://github.com/bazelbuild/apple_support/releases/download/1.0.0/apple_support.1.0.0.tar.gz",
)

http_archive(
    name = "build_bazel_rules_swift",
    sha256 = "d0833bc6dad817a367936a5f902a0c11318160b5e80a20ece35fb85a5675c886",
    strip_prefix = "rules_swift-3eeeb53cebda55b349d64c9fc144e18c5f7c0eb8",
    urls = ["https://github.com/bazelbuild/rules_swift/archive/3eeeb53cebda55b349d64c9fc144e18c5f7c0eb8.tar.gz"],
)

http_archive(
    name = "libmysqlclient",
    build_file = "//ml_metadata:libmysqlclient.BUILD",
    sha256 = "e9a284831955b548d39324341a7a411921733ce62d9834c0095a67164548a30e",
    strip_prefix = "mysql-5.7.32",
    urls = [
        "https://cdn.mysql.com/archives/mysql-5.7/mysql-5.7.32.tar.gz",
    ],
)

http_archive(
    name = "org_sqlite",
    build_file = "//ml_metadata/third_party:sqlite.BUILD",
    sha256 = "87775784f8b22d0d0f1d7811870d39feaa7896319c7c20b849a4181c5a50609b",
    strip_prefix = "sqlite-amalgamation-3390200",
    urls = [
        "https://www.sqlite.org/2022/sqlite-amalgamation-3390200.zip",
    ],
)

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

http_archive(
    name = "com_google_glog",
    build_file = "//ml_metadata/third_party:glog.BUILD",
    strip_prefix = "glog-96a2f23dca4cc7180821ca5f32e526314395d26a",
    urls = [
      "https://github.com/google/glog/archive/96a2f23dca4cc7180821ca5f32e526314395d26a.zip",
    ],
    sha256 = "6281aa4eeecb9e932d7091f99872e7b26fa6aacece49c15ce5b14af2b7ec050f",
)

http_archive(
    name = "com_github_gflags_gflags",
    strip_prefix = "gflags-a738fdf9338412f83ab3f26f31ac11ed3f3ec4bd",
    sha256 = "017e0a91531bfc45be9eaf07e4d8fed33c488b90b58509dbd2e33a33b2648ae6",
    url = "https://github.com/gflags/gflags/archive/a738fdf9338412f83ab3f26f31ac11ed3f3ec4bd.zip",
)

# For commandline flags used in gRPC server
# gflags needed by glog
http_archive(
    name = "com_google_zetasql",
    patch_args = ["-p1"],
    patches = ["//ml_metadata/third_party:zetasql.patch"],
    sha256 = "1afc2210d4aad371eff0a6bfdd8417ba99e02183a35dff167af2fa6097643f26",
    strip_prefix = "zetasql-%s" % ZETASQL_COMMIT,
    urls = ["https://github.com/google/zetasql/archive/%s.tar.gz" % ZETASQL_COMMIT],
)

load("@com_google_zetasql//bazel:zetasql_deps_step_1.bzl", "zetasql_deps_step_1")

zetasql_deps_step_1()

load("@com_google_zetasql//bazel:zetasql_deps_step_2.bzl", "zetasql_deps_step_2")

zetasql_deps_step_2(
    analyzer_deps = True,
    evaluator_deps = True,
    java_deps = False,
    testing_deps = False,
    tools_deps = False,
)

_PLATFORMS_VERSION = "0.0.6"

http_archive(
    name = "platforms",
    sha256 = "5308fc1d8865406a49427ba24a9ab53087f17f5266a7aabbfc28823f3916e1ca",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/platforms/releases/download/%s/platforms-%s.tar.gz" % (_PLATFORMS_VERSION, _PLATFORMS_VERSION),
        "https://github.com/bazelbuild/platforms/releases/download/%s/platforms-%s.tar.gz" % (_PLATFORMS_VERSION, _PLATFORMS_VERSION),
    ],
)

# Specify the minimum required bazel version.
load("@bazel_skylib//lib:versions.bzl", "versions")

versions.check("6.5.0")