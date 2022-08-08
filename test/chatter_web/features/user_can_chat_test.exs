defmodule ChatterWeb.UserCanChatTest do
    use ChatterWeb.FeatureCase, async: true 
    
    test "user can chat with others successfully", %{metadata: metadata} do
        room = insert(:chat_room)
        user1 = build(:user) |> set_password("password") |> insert()
        user2 = build(:user) |> set_password("password") |> insert()
        
        # Both user and other_user are actually sessions for said users
        user = 
            metadata
            |> new_user()
            |> visit(rooms_index())
            |> sign_in(as: user1)
            |> join_room(room.name)

        other_user = 
            metadata
            |> new_user()
            |> visit(rooms_index())
            |> sign_in(as: user2)
            |> join_room(room.name)

        user
        |>  add_message("Hi everyone")

        other_user
        |> assert_has(message("Hi everyone"))
        |> add_message("Hi, welcome to #{room.name}")

        user
        |> assert_has(message("Hi, welcome to #{room.name}"))

    end

    defp new_user(metadata) do
        {:ok, user} = Wallaby.start_session(metadata: metadata)
        user # this is really the session
    end

    defp rooms_index, do: Routes.chat_room_path(@endpoint, :index)

    defp join_room(session, name) do
        session
        |> click(Query.link(name))
    end

    defp add_message(session, message) do
        session
        |> fill_in(Query.text_field("New Message"), with: message)
        |> click(Query.button("Send"))
    end

    defp message(text) do
        Query.data("role", "message", text: text)
    end
end