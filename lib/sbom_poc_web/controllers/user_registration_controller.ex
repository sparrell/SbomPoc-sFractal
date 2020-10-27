defmodule SbomPocWeb.UserRegistrationController do
  use SbomPocWeb, :controller

  alias SbomPoc.Accounts
  alias SbomPoc.Accounts.User
  alias SbomPocWeb.UserAuth

  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end
end
