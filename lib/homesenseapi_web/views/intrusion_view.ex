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
    %{id: intrusion.id, intrusion: intrusion.intrusion, homesense: intrusion.homesense.area}
  end
end
