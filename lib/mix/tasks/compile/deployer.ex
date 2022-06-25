defmodule Mix.Tasks.Compile.ElixirPrecompiledDeployer do
  @moduledoc """
  Deploy recompiled binaries with Elixir script.
  Runs `precompiled_deploy.exs` in the current project.

  ## Configuration

  This compiler can be configured through the return value of the `project/0`
  function in `mix.exs`; for example:
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
          {:elixir_precompiled_deployer, "~> 0.1", runtime: false},
          # ...
        ]
      end

  The following options are available:
    * `:precompiled_deploy_script` - Path to the `precompiled_deploy.exs`
      script.

  ## Compilation artifacts and working with priv directories

  For most if not all cases, this deployer expects to download precompiled
  artifacts and put them into the `priv` directory. This is to:
    * avoid compiling non-elixir/erlang code with an external compiler
    * save the time from compiling large external projects

  Another reason to use this project is that writing deploy code in `mix.exs`
  that copies precompiled binaries to the `priv` directory does not work. Copied
  directories and files will be removed.

  """
  use Mix.Task

  @doc """
  Runs `precompiled_deploy.exs` in the current project.
  """
  def run(_args) do
    config = Mix.Project.config()

    make_priv_dir(config)

    precompiled_deploy_script =
      (config[:precompiled_deploy_script] || Path.join([File.cwd!(), "precompiled_deploy.exs"]))
      |> Path.expand()

    if File.exists?(precompiled_deploy_script) do
      Code.eval_file(precompiled_deploy_script)
    end

    Mix.Project.build_structure()

    :ok
  end

  defp make_priv_dir(config) do
    config
    |> Mix.Project.build_path()
    |> Path.join("priv")
    |> File.mkdir_p!()
  end
end
