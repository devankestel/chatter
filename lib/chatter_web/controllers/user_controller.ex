defmodule ChatterWeb.UserController do
    use ChatterWeb, :controller

    alias Doorman.Auth.Secret
    alias Doorman.Login.Session
    alias Chatter.User
    alias Chatter.Repo 

    def new(conn, _params) do
        changeset = User.changeset(%User{}, %{})
        render(conn, "new.html", changeset: changeset) 
    end

    def create(conn, %{"user" => params}) do
        case create_user(params) do
            {:ok, user} ->
                conn 
                |> Session.login(user)
                |> redirect(to: "/")
            {:error, changeset} ->
                conn
                |> render("new.html", changeset: changeset) 
        end       
    end

    def create_user(params) do
        %User{}
        |> User.changeset(params)
        |> Secret.put_session_secret()
        |> Repo.insert()
    end
end