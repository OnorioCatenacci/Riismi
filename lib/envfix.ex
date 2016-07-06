defmodule EnvFix do
  defmacro fix_env(env_var) when is_binary(env_var) do
    relx_release = System.get_env("RELX_RELEASE_OS_VARS")
    if (relx_release && String.upcase(relx_release) == "TRUE") do
      quote do ~s/\"${#{env_var}}\"/ end
    else
      quote do ~s/System.get_env(\"#{env_var}\")/ end
    end
  end
end
