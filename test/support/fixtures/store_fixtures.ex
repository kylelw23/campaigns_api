defmodule CampaignsApi.StoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CampaignsApi.Store` context.
  """

  @doc """
  Generate a campaign.
  """
  def campaign_fixture(attrs \\ %{}) do
    {:ok, campaign} =
      attrs
      |> Enum.into(%{
        budget: 42,
        description: "some description",
        end_date: "some end_date",
        hashtags: "some hashtags",
        name: "some name",
        start_date: "some start_date",
        team_id: 42
      })
      |> CampaignsApi.Store.create_campaign()

    campaign
  end
end
