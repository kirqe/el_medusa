defmodule ElMeduza.Application do
  @moduledoc """
  ElMeduza Supervisor
  """
  use Application

  def start(_type, _args) do
    children = []
    opts = [strategy: :one_for_one, name: ElMeduza.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
