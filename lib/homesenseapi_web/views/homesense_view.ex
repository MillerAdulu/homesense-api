defmodule HomesenseapiWeb.HomesenseView do
  use HomesenseapiWeb, :view
  alias HomesenseapiWeb.HomesenseView

  def render("index.json", %{homesenses: homesenses}) do
    %{data: render_many(homesenses, HomesenseView, "homesense.json")}
  end

  def render("show.json", %{homesense: homesense}) do
    %{data: render_one(homesense, HomesenseView, "homesense.json")}
  end

  def render("homesense.json", %{homesense: homesense}) do
    %{
      id: homesense.id,
      longitude: homesense.longitude,
      latitude: homesense.latitude,
      area: homesense.area,
      notes: homesense.notes,
      owner: homesense.homeowner.email
    }
  end
end
