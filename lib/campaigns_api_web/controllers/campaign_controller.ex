defmodule CampaignsApiWeb.CampaignController do
  use CampaignsApiWeb, :controller
  import Plug.Conn.Status, only: [code: 1]
  import PhoenixSwagger

  def swagger_definitions do
    %{
      campaign:
        swagger_schema do
          title("Campaign")
          description("A campaign.")

          properties do
            data(
              Schema.new do
                properties do
                  name(:string, "Campaign name", required: true)

                  start_time(:string, "Start time of the campaign.",
                    required: true
                  )

                  end_time(:string, "End time of the campaign.",
                    required: true
                  )

                  budget(:integer, "Budget of the campaign.",
                    required: true
                  )

                  hashtags(:string, "Hashtags of the campaign.",
                    required: true
                  )

                  team_id(:integer, "Team ID of the campaign.",
                    required: true
                  )

                  description(:string, "Description of the campaign.",
                    required: true
                  )
                end
              end
            )
          end

          example(%{
            budget: 8000,
            description: "We are looking for familys with babies less than 12 months to showcase our great new babyfood!",
            end_date: "2020-03-10 12:00:00",
            hashtags: "#applebabyfood #baby",
            name: "Apple Baby Food",
            start_date: "2020-01-01 12:00:00",
            team_id: 2
          })
        end,
      CampaignRequest:
        swagger_schema do
          title("CampaignRequest")
          description("POST body for creating a campaign")
          property(:campaign, Schema.ref(:campaign), "The campaign details")
        end,
      CampaignResponse:
        swagger_schema do
          title("CampaignResponse")
          description("Response schema for single campaign")
          property(:data, Schema.ref(:campaign), "The campaign details")
        end,
      CampaignResponse:
        swagger_schema do
          title("CampaignResponse")
          description("Response schema for multiple campaigns")
          property(:data, Schema.array(:campaign), "The campaigns details")
        end
    }
  end

  alias CampaignsApi.Store
  alias CampaignsApi.Store.Campaign

  action_fallback CampaignsApiWeb.FallbackController

  swagger_path :index do
    get("/api/campaigns")
    description("List of campaigns")
    produces("application/json")
    response(code(:ok), "Success")
  end

  def index(conn, _params) do
    campaigns = Store.list_campaigns()
    render(conn, "index.json", campaigns: campaigns)
  end

  swagger_path :create do
    post("/api/campaigns")
    description("Create a campaign")
    consumes("application/json")
    produces("application/json")

    parameter(:campaign, :body, PhoenixSwagger.Schema.ref(:CampaignRequest), "Campaign Details",
      example: %{
        campaign: %{
            budget: 8000,
            description: "We are looking for familys with babies less than 12 months to showcase our great new babyfood!",
            end_date: "2020-03-10 12:00:00",
            hashtags: "#applebabyfood #baby",
            name: "Apple Baby Food",
            start_date: "2020-01-01 12:00:00",
            team_id: 2
        }
      }
    )
    response(201, "Campaign created OK", PhoenixSwagger.Schema.ref(:CampaignResponse),
      example: %{
        campaign: %{
          budget: 8000,
            description: "We are looking for familys with babies less than 12 months to showcase our great new babyfood!",
            end_date: "2020-03-10 12:00:00",
            hashtags: "#applebabyfood #baby",
            name: "Apple Baby Food",
            start_date: "2020-01-01 12:00:00",
            team_id: 2
        }
      }
    )
  end

  def create(conn, %{"campaign" => campaign_params}) do
    with {:ok, %Campaign{} = campaign} <- Store.create_campaign(campaign_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.campaign_path(conn, :show, campaign))
      |> render("show.json", campaign: campaign)
    end
  end

  swagger_path :show do
    summary("Show campaign")
    description("Show a campaign by ID")
    produces("application/json")
    parameter(:id, :path, :integer, "Campaign ID", required: true, example: 2)
    response(code(:ok), "Success")
  end

  def show(conn, %{"id" => id}) do
    campaign = Store.get_campaign!(id)
    render(conn, "show.json", campaign: campaign)
  end

  swagger_path :update do
    put("/api/campaigns/{id}")
    summary("Update campaign")
    description("Update all attributes of a campaign")
    consumes("application/json")
    produces("application/json")

    parameters do
      id(:path, :integer, "campaign ID", required: true, example: 3)

      campaign(:body, PhoenixSwagger.Schema.ref(:CampaignRequest), "The campaign details",
        example: %{
          budget: 8000,
            description: "We are looking for familys with babies less than 12 months to showcase our great new babyfood!",
            end_date: "2020-03-10 12:00:00",
            hashtags: "#applebabyfood #baby",
            name: "Apple Baby Food",
            start_date: "2020-01-01 12:00:00",
            team_id: 2
        }
      )
    end

    response(200, "Updated Successfully", PhoenixSwagger.Schema.ref(:CampaignResponse),
      example: %{
        campaign: %{
          budget: 8000,
            description: "We are looking for familys with babies less than 12 months to showcase our great new babyfood!",
            end_date: "2020-03-10 12:00:00",
            hashtags: "#applebabyfood #baby",
            name: "Apple Baby Food",
            start_date: "2020-01-01 12:00:00",
            team_id: 2
        }
      }
    )
  end

  def update(conn, %{"id" => id, "campaign" => campaign_params}) do
    campaign = Store.get_campaign!(id)

    with {:ok, %Campaign{} = campaign} <- Store.update_campaign(campaign, campaign_params) do
      render(conn, "show.json", campaign: campaign)
    end
  end

  swagger_path :delete do
    PhoenixSwagger.Path.delete("/api/campaigns/{id}")
    summary("Delete a campaign")
    description("Delete a campaign by ID")

    parameter(:id, :path, :integer, "Campaign ID", required: true, example: 3)

    response(203, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    campaign = Store.get_campaign!(id)

    with {:ok, %Campaign{}} <- Store.delete_campaign(campaign) do
      send_resp(conn, :no_content, "")
    end
  end
end
