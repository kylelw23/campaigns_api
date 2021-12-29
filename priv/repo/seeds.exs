# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CampaignsApi.Repo.insert!(%CampaignsApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
CampaignsApi.Store.CSVUtil.csv_row_to_table_record("priv/repo/data/campaigns.csv")
