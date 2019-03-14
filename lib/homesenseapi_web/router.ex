defmodule HomesenseapiWeb.Router do
  use HomesenseapiWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/api", HomesenseapiWeb do
    pipe_through :api

    resources "/homeowners", HomeOwnerController, except: [:new, :edit]
    options "/homeowners", HomeOwnerController, :options

    resources "/homesenses", HomesenseController, except: [:new, :edit]
    options "/homesenses", HomesenseController, :options

    resources "/intrusions", IntrusionController, except: [:new, :edit]
    options "/intrusions", IntrusionController, :options
  end
end
