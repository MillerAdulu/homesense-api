defmodule HomesenseapiWeb.HomeOwnerView do
  use HomesenseapiWeb, :view
  alias HomesenseapiWeb.HomeOwnerView

  def render("index.json", %{homeowners: homeowners}) do
    %{data: render_many(homeowners, HomeOwnerView, "home_owner.json")}
  end

  def render("show.json", %{home_owner: home_owner}) do
    %{data: render_one(home_owner, HomeOwnerView, "home_owner.json")}
  end

  def render("home_owner.json", %{home_owner: home_owner}) do
    %{
      id: home_owner.id,
      idNumber: home_owner.id_number,
      name: home_owner.name,
      phoneNumber: home_owner.phone_number,
      email: home_owner.email
    }
  end
end
