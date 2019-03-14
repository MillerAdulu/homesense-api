defmodule HomesenseapiWeb.HomeOwnerController do
  use HomesenseapiWeb, :controller

  alias Homesenseapi.Accounts
  alias Homesenseapi.Accounts.HomeOwner

  action_fallback HomesenseapiWeb.FallbackController

  def index(conn, _params) do
    homeowners = Accounts.list_homeowners()
    render(conn, "index.json", homeowners: homeowners)
  end

  def create(conn, %{"home_owner" => home_owner_params}) do
    with {:ok, %HomeOwner{} = home_owner} <- Accounts.create_home_owner(home_owner_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.home_owner_path(conn, :show, home_owner))
      |> render("show.json", home_owner: home_owner)
    end
  end

  def show(conn, %{"id" => id}) do
    home_owner = Accounts.get_home_owner!(id)
    render(conn, "show.json", home_owner: home_owner)
  end

  def update(conn, %{"id" => id, "home_owner" => home_owner_params}) do
    home_owner = Accounts.get_home_owner!(id)

    with {:ok, %HomeOwner{} = home_owner} <-
           Accounts.update_home_owner(home_owner, home_owner_params) do
      render(conn, "show.json", home_owner: home_owner)
    end
  end

  def delete(conn, %{"id" => id}) do
    home_owner = Accounts.get_home_owner!(id)

    with {:ok, %HomeOwner{}} <- Accounts.delete_home_owner(home_owner) do
      send_resp(conn, :no_content, "")
    end
  end
end
