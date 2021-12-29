defmodule CampaignsApi.Store.Campaign do
  use Ecto.Schema
  import Ecto.Changeset

  schema "campaigns" do
    field :budget, :integer
    field :description, :string
    field :end_date, :string
    field :hashtags, :string
    field :name, :string
    field :start_date, :string
    field :team_id, :integer

    timestamps()
  end

  @doc false
  def changeset(campaign, attrs) do
    campaign
    |> cast(attrs, [:name, :start_date, :end_date, :budget, :hashtags, :team_id, :description])
    |> validate_required([:name, :start_date, :end_date, :budget, :hashtags, :team_id, :description])
  end
end
