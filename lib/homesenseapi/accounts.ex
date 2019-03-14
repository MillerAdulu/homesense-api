defmodule Homesenseapi.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Homesenseapi.Repo

  alias Homesenseapi.Accounts.HomeOwner

  @doc """
  Returns the list of homeowners.

  ## Examples

      iex> list_homeowners()
      [%HomeOwner{}, ...]

  """
  def list_homeowners do
    Repo.all(HomeOwner)
  end

  @doc """
  Gets a single home_owner.

  Raises `Ecto.NoResultsError` if the Home owner does not exist.

  ## Examples

      iex> get_home_owner!(123)
      %HomeOwner{}

      iex> get_home_owner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_home_owner!(id), do: Repo.get!(HomeOwner, id)

  @doc """
  Creates a home_owner.

  ## Examples

      iex> create_home_owner(%{field: value})
      {:ok, %HomeOwner{}}

      iex> create_home_owner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_home_owner(attrs \\ %{}) do
    %HomeOwner{}
    |> HomeOwner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a home_owner.

  ## Examples

      iex> update_home_owner(home_owner, %{field: new_value})
      {:ok, %HomeOwner{}}

      iex> update_home_owner(home_owner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_home_owner(%HomeOwner{} = home_owner, attrs) do
    home_owner
    |> HomeOwner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a HomeOwner.

  ## Examples

      iex> delete_home_owner(home_owner)
      {:ok, %HomeOwner{}}

      iex> delete_home_owner(home_owner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_home_owner(%HomeOwner{} = home_owner) do
    Repo.delete(home_owner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking home_owner changes.

  ## Examples

      iex> change_home_owner(home_owner)
      %Ecto.Changeset{source: %HomeOwner{}}

  """
  def change_home_owner(%HomeOwner{} = home_owner) do
    HomeOwner.changeset(home_owner, %{})
  end
end
