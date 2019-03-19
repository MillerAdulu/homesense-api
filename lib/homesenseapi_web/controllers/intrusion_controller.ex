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
      send_admin_alert(intrusion_homesense)
      send_community_alert(intrusion_homesense)
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
      "{\"notification\": {\"body\":\"We suspect your home has been intruded.\",\"title\" : \"INTRUSION ALERT\"},\"to\": \"e37yDzNizBo:APA91bF-DCEuk8J7jtomMsgSLBoT2XxX_yeLEGJQbX8sHOo_YovTEfXoi-rFN72iw9vn0ykEa1vTsecR-SYgUvePGiGSV3F5_sxOk0fkISxchMomcx0IXjtK5KngIpvZ5aNVNkZdntgh\", \"data\": {\"homesense\": #{
        homesense_id
      }}}",
      Authorization:
        "key=AAAA1Ac_qfg:APA91bFAA5tHF3ZYfAV1Py0oK8W6hbPx0lBvBpy4riWT1_wz8LAy0xJEZaj0KEpl92ij3wwwMrdWJ-KhCmIR4__2VXvAs-bZdgUVG-l5hDo6Csri-HR12-a0duqgq-yDYUUgi47NlBBa",
      "Content-Type": "application/json"
    )
  end

  def send_admin_alert(int_hom) do
    HTTPoison.post(
      "https://fcm.googleapis.com/fcm/send",
      "{\"notification\": {\"title\": \"Homesense\",\"body\": \"Intrusion Alert\",\"click_action\": \"https://homesense-app.firebaseapp.com/admin/realtime/\"},\"data\": {\"homesense\": {\"area\": \"#{
        int_hom.homesense.area
      }\",\"latitude\": \"#{int_hom.homesense.latitude}\",\"longitude\": \"#{
        int_hom.homesense.longitude
      }\",\"notes\": \"#{int_hom.homesense.notes}\"},\"id\": #{int_hom.id},\"intrusion\": #{
        int_hom.intrusion
      }},\"to\": \"fMo8CWnWnQw:APA91bFxJZi4DFUnkHCBuwkamE7e_HHG0AHSYL-CNse-2sq8S7If_q81oHkavjVUISXWT8mj09rOpWQDx4r7PfBRcz_UW9-5i5c6mJZ4XJM8zA5YcmXx3BLD1547p5mGFFvB8H0y0H7i\"}",
      Authorization:
        "key=AAAA1Ac_qfg:APA91bFAA5tHF3ZYfAV1Py0oK8W6hbPx0lBvBpy4riWT1_wz8LAy0xJEZaj0KEpl92ij3wwwMrdWJ-KhCmIR4__2VXvAs-bZdgUVG-l5hDo6Csri-HR12-a0duqgq-yDYUUgi47NlBBa",
      "Content-Type": "application/json"
    )
  end

  # Change the URL, token and server key
  def send_community_alert(int_hom) do
    HTTPoison.post(
      "https://fcm.googleapis.com/fcm/send",
      "{\"notification\": {\"title\": \"Homesense\",\"body\": \"Intrusion Alert\",\"click_action\": \"https://homesense-app.firebaseapp.com/\"},\"data\": {\"homesense\": {\"area\": \"#{
        int_hom.homesense.area
      }\",\"latitude\": \"#{int_hom.homesense.latitude}\",\"longitude\": \"#{
        int_hom.homesense.longitude
      }\",\"notes\": \"#{int_hom.homesense.notes}\"},\"id\": #{int_hom.id},\"intrusion\": #{
        int_hom.intrusion
      }},\"to\": \"fMo8CWnWnQw:APA91bFxJZi4DFUnkHCBuwkamE7e_HHG0AHSYL-CNse-2sq8S7If_q81oHkavjVUISXWT8mj09rOpWQDx4r7PfBRcz_UW9-5i5c6mJZ4XJM8zA5YcmXx3BLD1547p5mGFFvB8H0y0H7i\"}",
      Authorization:
        "key=AAAA1Ac_qfg:APA91bFAA5tHF3ZYfAV1Py0oK8W6hbPx0lBvBpy4riWT1_wz8LAy0xJEZaj0KEpl92ij3wwwMrdWJ-KhCmIR4__2VXvAs-bZdgUVG-l5hDo6Csri-HR12-a0duqgq-yDYUUgi47NlBBa",
      "Content-Type": "application/json"
    )
  end
end
