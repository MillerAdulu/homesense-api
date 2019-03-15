defmodule HomesenseapiWeb.IntrusionView do
  use HomesenseapiWeb, :view
  alias HomesenseapiWeb.IntrusionView

  def render("index.json", %{intrusions: intrusions}) do
    %{data: render_many(intrusions, IntrusionView, "intrusion.json")}
  end

  def render("show.json", %{intrusion: intrusion}) do
    %{data: render_one(intrusion, IntrusionView, "intrusion.json")}
  end

  def render("intrusion.json", %{intrusion: intrusion}) do
    %{
      id: intrusion.id,
      intrusion: intrusion.intrusion,
      homesense: %{
        area: intrusion.homesense.area,
        latitude: intrusion.homesense.latitude,
        longitude: intrusion.homesense.longitude,
        notes: intrusion.homesense.notes
      }
    }
  end
end
