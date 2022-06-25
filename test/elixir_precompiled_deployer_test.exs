defmodule Mix.Tasks.Compile.ElixirPrecompiledDeployerTest do
  use ExUnit.Case
  doctest Mix.Tasks.Compile.ElixirPrecompiledDeployer

  import Mix.Tasks.Compile.ElixirPrecompiledDeployer, only: [run: 1]
  import ExUnit.CaptureIO

  @fixture_project Path.expand("fixture/sample_app", __DIR__)

  test "precompiled_deploy.exs" do
    in_fixture(fn ->
      assert "from precompiled_deploy.exs\n" ==
               capture_io(fn ->
                 run([])
               end)
    end)
  end

  defp in_fixture(fun) do
    File.cd!(@fixture_project, fun)
  end
end
