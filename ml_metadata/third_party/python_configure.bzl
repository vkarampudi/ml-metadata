"""Python configuration."""

def local_python_configure(name):
    """Configures a local python toolchain."""
    native.bind(
        name = name,
        actual = "@local_config_python//:py_interpreter",
    )