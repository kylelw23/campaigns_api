defmodule CampaignsApiWeb.CampaignControllerTest do
  use CampaignsApiWeb.ConnCase

  import CampaignsApi.StoreFixtures

  alias CampaignsApi.Store.Campaign

  @create_attrs %{
    budget: 42,
    description: "some description",
    end_date: "some end_date",
    hashtags: "some hashtags",
    name: "some name",
    start_date: "some start_date",
    team_id: 42
  }
  @update_attrs %{
    budget: 43,
    description: "some updated description",
    end_date: "some updated end_date",
    hashtags: "some updated hashtags",
    name: "some updated name",
    start_date: "some updated start_date",
    team_id: 43
  }
  @invalid_attrs %{budget: nil, description: nil, end_date: nil, hashtags: nil, name: nil, start_date: nil, team_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all campaigns", %{conn: conn} do
      conn = get(conn, Routes.campaign_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create campaign" do
    test "renders campaign when data is valid", %{conn: conn} do
      conn = post(conn, Routes.campaign_path(conn, :create), campaign: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.campaign_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "budget" => 42,
               "description" => "some description",
               "end_date" => "some end_date",
               "hashtags" => "some hashtags",
               "name" => "some name",
               "start_date" => "some start_date",
               "team_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.campaign_path(conn, :create), campaign: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update campaign" do
    setup [:create_campaign]

    test "renders campaign when data is valid", %{conn: conn, campaign: %Campaign{id: id} = campaign} do
      conn = put(conn, Routes.campaign_path(conn, :update, campaign), campaign: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.campaign_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "budget" => 43,
               "description" => "some updated description",
               "end_date" => "some updated end_date",
               "hashtags" => "some updated hashtags",
               "name" => "some updated name",
               "start_date" => "some updated start_date",
               "team_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, campaign: campaign} do
      conn = put(conn, Routes.campaign_path(conn, :update, campaign), campaign: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete campaign" do
    setup [:create_campaign]

    test "deletes chosen campaign", %{conn: conn, campaign: campaign} do
      conn = delete(conn, Routes.campaign_path(conn, :delete, campaign))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.campaign_path(conn, :show, campaign))
      end
    end
  end

  defp create_campaign(_) do
    campaign = campaign_fixture()
    %{campaign: campaign}
  end
end
