defmodule CampaignsApi.StoreTest do
  use CampaignsApi.DataCase

  alias CampaignsApi.Store

  describe "campaigns" do
    alias CampaignsApi.Store.Campaign

    import CampaignsApi.StoreFixtures

    @invalid_attrs %{budget: nil, description: nil, end_date: nil, hashtags: nil, name: nil, start_date: nil, team_id: nil}

    test "list_campaigns/0 returns all campaigns" do
      campaign = campaign_fixture()
      assert Store.list_campaigns() == [campaign]
    end

    test "get_campaign!/1 returns the campaign with given id" do
      campaign = campaign_fixture()
      assert Store.get_campaign!(campaign.id) == campaign
    end

    test "create_campaign/1 with valid data creates a campaign" do
      valid_attrs = %{budget: 42, description: "some description", end_date: "some end_date", hashtags: "some hashtags", name: "some name", start_date: "some start_date", team_id: 42}

      assert {:ok, %Campaign{} = campaign} = Store.create_campaign(valid_attrs)
      assert campaign.budget == 42
      assert campaign.description == "some description"
      assert campaign.end_date == "some end_date"
      assert campaign.hashtags == "some hashtags"
      assert campaign.name == "some name"
      assert campaign.start_date == "some start_date"
      assert campaign.team_id == 42
    end

    test "create_campaign/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_campaign(@invalid_attrs)
    end

    test "update_campaign/2 with valid data updates the campaign" do
      campaign = campaign_fixture()
      update_attrs = %{budget: 43, description: "some updated description", end_date: "some updated end_date", hashtags: "some updated hashtags", name: "some updated name", start_date: "some updated start_date", team_id: 43}

      assert {:ok, %Campaign{} = campaign} = Store.update_campaign(campaign, update_attrs)
      assert campaign.budget == 43
      assert campaign.description == "some updated description"
      assert campaign.end_date == "some updated end_date"
      assert campaign.hashtags == "some updated hashtags"
      assert campaign.name == "some updated name"
      assert campaign.start_date == "some updated start_date"
      assert campaign.team_id == 43
    end

    test "update_campaign/2 with invalid data returns error changeset" do
      campaign = campaign_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_campaign(campaign, @invalid_attrs)
      assert campaign == Store.get_campaign!(campaign.id)
    end

    test "delete_campaign/1 deletes the campaign" do
      campaign = campaign_fixture()
      assert {:ok, %Campaign{}} = Store.delete_campaign(campaign)
      assert_raise Ecto.NoResultsError, fn -> Store.get_campaign!(campaign.id) end
    end

    test "change_campaign/1 returns a campaign changeset" do
      campaign = campaign_fixture()
      assert %Ecto.Changeset{} = Store.change_campaign(campaign)
    end
  end
end
