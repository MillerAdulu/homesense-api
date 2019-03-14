defmodule HomesenseapiWeb.HomesenseController do
  use HomesenseapiWeb, :controller

  alias Homesenseapi.Devices
  alias Homesenseapi.Devices.Homesense

  action_fallback HomesenseapiWeb.FallbackController

  def index(conn, _params) do
    homesenses = Devices.list_homesenses()
    render(conn, "index.json", homesenses: homesenses)
  end

  def create(conn, %{"homesense" => homesense_params}) do
    with {:ok, %Homesense{} = homesense} <- Devices.create_homesense(homesense_params) do
      homesense_owner = Devices.get_homesense!(homesense.id)

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.homesense_path(conn, :show, homesense_owner))
      |> render("show.json", homesense: homesense_owner)
    end
  end

  def show(conn, %{"id" => id}) do
    homesense = Devices.get_homesense!(id)
    render(conn, "show.json", homesense: homesense)
  end

  def update(conn, %{"id" => id, "homesense" => homesense_params}) do
    homesense = Devices.get_homesense!(id)

    with {:ok, %Homesense{} = homesense} <- Devices.update_homesense(homesense, homesense_params) do
      homesense_owner = Devices.get_homesense!(homesense.id)
      render(conn, "show.json", homesense: homesense_owner)
    end
  end

  def delete(conn, %{"id" => id}) do
    homesense = Devices.get_homesense!(id)

    with {:ok, %Homesense{}} <- Devices.delete_homesense(homesense) do
      send_resp(conn, :no_content, "")
    end
  end
end
