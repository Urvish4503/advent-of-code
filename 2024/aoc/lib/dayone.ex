defmodule Dayone do
  def get_input() do
    case File.read("lib/input/day1.txt") do
      {:ok, data} -> data
      {:error, reason} -> reason
    end
    |> String.trim()
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.zip_with(& &1)
  end

  def part1(data) do
    [left_list, right_list] = data

    left_sorted = Enum.sort(left_list)
    right_sorted = Enum.sort(right_list)

    Enum.zip(left_sorted, right_sorted)
    |> Enum.reduce(0, fn {left_num, right_num}, acc ->
      acc + abs(left_num - right_num)
    end)
  end

  def part2(data) do
    [left_list, right_list] = data

    left_sorted = Enum.sort(left_list)
    right_sorted = Enum.sort(right_list)

    right_freq = Enum.frequencies(right_sorted)

    Enum.reduce(left_sorted, 0, fn num, acc ->
      acc + num * Map.get(right_freq, num, 0)
    end)
  end

  def do_it do
    data = get_input()

    data
    |> part1()
    |> IO.inspect()

    data
    |> part2()
  end
end
