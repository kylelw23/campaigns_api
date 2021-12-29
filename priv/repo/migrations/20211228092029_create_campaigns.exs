defmodule CampaignsApi.Repo.Migrations.CreateCampaigns do
  use Ecto.Migration

  def change do
    create table(:campaigns) do
      add :name, :string
      add :start_date, :string
      add :end_date, :string
      add :budget, :integer
      add :hashtags, :string
      add :team_id, :integer
      add :description, :string

      timestamps()
    end
  end
end
