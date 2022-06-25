# Elixir Precompiled Deployer

Deploy precompiled binaries using Elixir scripts.

[![Coverage Status](https://coveralls.io/repos/github/cocoa-xu/precompiled_deployer/badge.svg?branch=main)](https://coveralls.io/github/cocoa-xu/precompiled_deployer?branch=main)

Runs `precompiled_deploy.exs` in corresponding project. For most if not 
all cases, `precompiled_deploy.exs` is expected to download precompiled 
artifacts and put them into the `priv` directory. This is to:
* avoid compiling non-elixir/erlang code with an external compiler
* save the time from compiling large external projects

Another reason to use this project is that writing deploy code in `mix.exs`
that copies precompiled binaries to the `priv` directory does not work. Copied
directories and files will be removed.

## Configuration

This compiler can be configured through the return value of the `project/0` function in `mix.exs`; for example:
```elixir
def project() do
    [
        # ...
        compilers: [:elixir_precompiled_deployer] ++ Mix.compilers,
        # ...
    ]
end

defp deps do
  [
    # ...
    {:elixir_precompiled_deployer, "~> 0.1.0", runtime: false},
    # ...
  ]
end
```

The following options are available:
* `:precompiled_deploy_script` - Path to the `precompiled_deploy.exs` script.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `elixir_precompiled_deployer` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixir_precompiled_deployer, "~> 0.1.0", runtime: false}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/elixir_precompiled_deployer>.
