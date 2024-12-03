defmodule Daytwo do
  def get_data do
    case File.read("lib/input/day2.txt") do
      {:ok, data} -> data
      {:error, reason} -> reason
    end
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(&Enum.map(&1, fn x -> String.to_integer(x) end))
  end

  def follows_increasing_logic?(sequence) do
    sequence
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [a, b] ->
      a < b and 1 <= abs(a - b) and abs(a - b) <= 3
    end)
  end

  def follows_decreasing_logic?(sequence) do
    sequence
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [a, b] ->
      a > b and 1 <= abs(a - b) and abs(a - b) <= 3
    end)
  end

  def type_of_sequence([a, b | _]) do
    cond do
      a == b -> :same
      a < b -> :increasing
      a > b -> :decreasing
    end
  end

  def is_possible_with_modification?(sequence) do
    Enum.find_value(0..(length(sequence) - 1), fn i ->
      modified_sequence = List.delete_at(sequence, i)
      follows_increasing_logic?(modified_sequence) || follows_decreasing_logic?(modified_sequence)
    end)
  end

  def part1(data) do
    Enum.zip(data, Enum.map(data, &type_of_sequence/1))
    |> Enum.map(fn {sequence, type} ->
      case type do
        :increasing -> follows_increasing_logic?(sequence)
        :decreasing -> follows_decreasing_logic?(sequence)
        :same -> false
      end
    end)
    |> Enum.reduce(0, fn x, acc -> if x, do: acc + 1, else: acc end)
    |> IO.inspect(label: "Part 1 Result")
  end

  def part2(data) do
    data
    |> Enum.reduce(0, fn level, acc ->
      if follows_decreasing_logic?(level) || follows_increasing_logic?(level) do
        acc + 1
      else
        is_possible_with_modification?(level)
        |> case do
          true -> acc + 1
          _ -> acc
        end
      end
    end)
    |> IO.inspect(label: "Part 2 Result")
  end

  def do_it do
    data = get_data()

    part1(data)
    part2(data)
    :ok
  end
end
