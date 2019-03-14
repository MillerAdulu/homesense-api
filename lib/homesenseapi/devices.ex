defmodule Homesenseapi.Devices do
  @moduledoc """
  The Devices context.
  """

  import Ecto.Query, warn: false
  alias Homesenseapi.Repo

  alias Homesenseapi.Devices.Homesense

  def preload_homeowner(homesense_or_homesenses) do
    homesense_or_homesenses
    |> Repo.preload(:homeowner)
  end

  alias Homesenseapi.Devices.Homesense

  @doc """
  Returns the list of homesenses.

  ## Examples

      iex> list_homesenses()
      [%Homesense{}, ...]

  """
  def list_homesenses do
    Homesense
    |> Repo.all()
    |> preload_homeowner
  end

  @doc """
  Gets a single homesense.

  Raises `Ecto.NoResultsError` if the Homesense does not exist.

  ## Examples

      iex> get_homesense!(123)
      %Homesense{}

      iex> get_homesense!(456)
      ** (Ecto.NoResultsError)

  """
  def get_homesense!(id) do
    Homesense
    |> Repo.get!(id)
    |> preload_homeowner
  end

  @doc """
  Creates a homesense.

  ## Examples

      iex> create_homesense(%{field: value})
      {:ok, %Homesense{}}

      iex> create_homesense(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_homesense(attrs \\ %{}) do
    %Homesense{}
    |> Homesense.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a homesense.

  ## Examples

      iex> update_homesense(homesense, %{field: new_value})
      {:ok, %Homesense{}}

      iex> update_homesense(homesense, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_homesense(%Homesense{} = homesense, attrs) do
    homesense
    |> Homesense.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Homesense.

  ## Examples

      iex> delete_homesense(homesense)
      {:ok, %Homesense{}}

      iex> delete_homesense(homesense)
      {:error, %Ecto.Changeset{}}

  """
  def delete_homesense(%Homesense{} = homesense) do
    Repo.delete(homesense)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking homesense changes.

  ## Examples

      iex> change_homesense(homesense)
      %Ecto.Changeset{source: %Homesense{}}

  """
  def change_homesense(%Homesense{} = homesense) do
    Homesense.changeset(homesense, %{})
  end

  alias Homesenseapi.Devices.Intrusion

  def preload_homesense(intrusion_or_intrusions) do
    intrusion_or_intrusions
    |> Repo.preload(:homesense)
  end

  @doc """
  Returns the list of intrusions.

  ## Examples

      iex> list_intrusions()
      [%Intrusion{}, ...]

  """
  def list_intrusions do
    Intrusion
    |> Repo.all()
    |> preload_homesense
  end

  @doc """
  Gets a single intrusion.

  Raises `Ecto.NoResultsError` if the Intrusion does not exist.

  ## Examples

      iex> get_intrusion!(123)
      %Intrusion{}

      iex> get_intrusion!(456)
      ** (Ecto.NoResultsError)

  """
  def get_intrusion!(id) do
    Intrusion
    |> Repo.get!(id)
    |> preload_homesense
  end

  @doc """
  Creates a intrusion.

  ## Examples

      iex> create_intrusion(%{field: value})
      {:ok, %Intrusion{}}

      iex> create_intrusion(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_intrusion(attrs \\ %{}) do
    %Intrusion{}
    |> Intrusion.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a intrusion.

  ## Examples

      iex> update_intrusion(intrusion, %{field: new_value})
      {:ok, %Intrusion{}}

      iex> update_intrusion(intrusion, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_intrusion(%Intrusion{} = intrusion, attrs) do
    intrusion
    |> Intrusion.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Intrusion.

  ## Examples

      iex> delete_intrusion(intrusion)
      {:ok, %Intrusion{}}

      iex> delete_intrusion(intrusion)
      {:error, %Ecto.Changeset{}}

  """
  def delete_intrusion(%Intrusion{} = intrusion) do
    Repo.delete(intrusion)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking intrusion changes.

  ## Examples

      iex> change_intrusion(intrusion)
      %Ecto.Changeset{source: %Intrusion{}}

  """
  def change_intrusion(%Intrusion{} = intrusion) do
    Intrusion.changeset(intrusion, %{})
  end
end
