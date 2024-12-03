defmodule Daythree do
  def get_data do
    case File.read("lib/input/day3.txt") do
      {:ok, data} ->
        data
        |> String.trim()
        |> String.split("\n")

      {:error, reason} ->
        IO.puts("Error reading file: #{inspect(reason)}")
        []
    end
  end

  def extract_multiplications(input_string) do
    Regex.scan(~r/mul\((\d+),(\d+)\)/, input_string)
    |> Enum.map(fn [function, num1, num2] ->
      {num1, _} = Integer.parse(num1)
      {num2, _} = Integer.parse(num2)
      {function, num1, num2}
    end)
  end

  def extract_patterns(input_string) do
    pattern = ~r/(?:do\(\)|don't\(\)|mul\((\d{1,3}),(\d{1,3})\))/

    Regex.scan(pattern, input_string)
    |> Enum.map(fn
      ["do()"] ->
        {:action, "do()"}

      ["don't()"] ->
        {:action, "don't()"}

      [full_match, num1, num2] ->
        {:multiplication, {full_match, {String.to_integer(num1), String.to_integer(num2)}}}
    end)
  end

  def process_multiplicative_sequence(patterns) do
    patterns
    |> Enum.reduce({:continue, 0}, fn
      {:action, "don't()"}, {_, accumulator} ->
        {:stop, accumulator}

      {:action, "do()"}, {:stop, accumulator} ->
        {:continue, accumulator}

      {:multiplication, {_, {num1, num2}}}, {:continue, accumulator} ->
        mul_result = num1 * num2
        {:continue, accumulator + mul_result}
    end)
  end

  defp process_single_list(patterns) do
    patterns
    |> Enum.reduce({:continue, 0}, fn
      {:action, "don't()"}, {_, accumulator} ->
        {:pause, accumulator}

      {:action, "do()"}, {_, accumulator} ->
        {:continue, accumulator}

      {:multiplication, {_string, {num1, num2}}}, {:continue, accumulator} ->
        mul_result = num1 * num2
        {:continue, accumulator + mul_result}

      {:multiplication, {_string, _}}, {:pause, accumulator} ->
        {:pause, accumulator}

      _, result ->
        result
    end)
    |> case do
      {_, acc} -> acc
    end
  end

  def part1(data) do
    data
    |> Enum.map(&extract_multiplications/1)
    |> Enum.map(fn sublist ->
      sublist
      |> Enum.reduce(0, fn {_, num1, num2}, acc ->
        acc + num1 * num2
      end)
    end)
    |> Enum.sum()
    |> IO.inspect(label: "Part 1 result")
  end

  def part2(data) do
    data
    |> Enum.map(&extract_patterns/1)
    |> Enum.map(&process_single_list/1)
    |> Enum.sum()
    |> IO.inspect(label: "Part 2 result")
  end

  def do_it do
    data = get_data()

    part1(data)
    part2(data)
  end
end
