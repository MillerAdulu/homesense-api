defmodule HomesenseapiWeb.IntrusionController do
  use HomesenseapiWeb, :controller

  alias Homesenseapi.Devices
  alias Homesenseapi.Devices.Intrusion

  action_fallback HomesenseapiWeb.FallbackController

  def index(conn, _params) do
    intrusions = Devices.list_intrusions()
    render(conn, "index.json", intrusions: intrusions)
  end

  def create(conn, %{"intrusion" => intrusion_params}) do
    with {:ok, %Intrusion{} = intrusion} <- Devices.create_intrusion(intrusion_params) do
      intrusion_homesense = Devices.get_intrusion!(intrusion.id)
      send_user_alert(intrusion_homesense.id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.intrusion_path(conn, :show, intrusion_homesense))
      |> render("show.json", intrusion: intrusion_homesense)
    end
  end

  def show(conn, %{"id" => id}) do
    intrusion = Devices.get_intrusion!(id)
    render(conn, "show.json", intrusion: intrusion)
  end

  def update(conn, %{"id" => id, "intrusion" => intrusion_params}) do
    intrusion = Devices.get_intrusion!(id)

    with {:ok, %Intrusion{} = intrusion} <- Devices.update_intrusion(intrusion, intrusion_params) do
      intrusion_homesense = Devices.get_intrusion!(intrusion.id)
      render(conn, "show.json", intrusion: intrusion_homesense)
    end
  end

  def delete(conn, %{"id" => id}) do
    intrusion = Devices.get_intrusion!(id)

    with {:ok, %Intrusion{}} <- Devices.delete_intrusion(intrusion) do
      send_resp(conn, :no_content, "")
    end
  end

  defp send_user_alert(homesense_id) do
    HTTPoison.post(
      "https://fcm.googleapis.com/fcm/send",
      "{\"notification\": {\"body\":\"We suspect your home has been intruded.\",\"title\" : \"INTRUSION ALERT\"},\"to\": \"d328fsOpAIQ:APA91bGRAN_YoOpLiwTGwBJ53dwjLzm45Do_5Tl0oilWmoaj5OsVWp7DiuAx8C9nt0w1hf2mcHhqbXGpR56yNtIrEJTFNj8PRAEPuXHhhz1gBXX9aD8N_yR_NOkLSXu7WeLkfZE-80Rj\", \"data\": {\"homesense\": #{
        homesense_id
      }}}",
      Authorization:
        "key=AAAA1Ac_qfg:APA91bFAA5tHF3ZYfAV1Py0oK8W6hbPx0lBvBpy4riWT1_wz8LAy0xJEZaj0KEpl92ij3wwwMrdWJ-KhCmIR4__2VXvAs-bZdgUVG-l5hDo6Csri-HR12-a0duqgq-yDYUUgi47NlBBa",
      "Content-Type": "application/json"
    )
  end
end
