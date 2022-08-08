# How It Was Solved

This file keeps a running log of times a developer is stuck, and what was done to solve the issue. 
It also links to any resources used to solve the problem. Thus we tie the solution back to the commit itself for future reference. 

# Making a test watcher for JS tests only

The tutorial offered only two options - watch assets every time `mix test` is run or watch assets in a separate tab manually when you want to run JS containing tests. Neither of these options seemed good enough. 

From this article [Phoenix Elixir Testing Beyond Mix Text](https://brooklinmyers.medium.com/phoenix-elixir-testing-beyond-mix-test-5b07de241001)

We can create a custom task: 

```elixir
    defp aliases do
        "test.current": ["test --only current"] 
    end
```

and run it using `mix test.current` 

So the solution ended up being to create a `mix test.js` task 
And also to set the `preffered_cli_env` property to `:test` for `test.js` in the project def
in [mix.exs](mix.exs)
as described in this forum post answer [preferred_cli_env](https://elixirforum.com/t/how-do-i-set-the-env-at-alias/16304/4)