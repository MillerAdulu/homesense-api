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
end
