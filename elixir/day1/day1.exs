defmodule Day1 do
    def execute() do
            with {:ok, file} <- File.read("input.txt"),
            elves <- String.split(file,"\n\n") do
                IO.puts(Enum.at(elves, 0))
                elves |>
                Enum.map(&convert_to_sum/1) |>
                Enum.max |>
                IO.puts
        else
        {:error, _} ->
            IO.puts("everything went wrong")
        end
    end

    def convert_to_sum(string) do
        string |>
        String.split("\n") |>
        Enum.map(&String.to_integer/1) |>
        Enum.sum
    end
end

Day1.execute()
