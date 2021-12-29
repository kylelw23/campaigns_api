defmodule CampaignsApiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use CampaignsApiWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, %Ecto.Changeset{}}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(CampaignsApiWeb.ErrorView)
    |> render(:"422")
  end
end
