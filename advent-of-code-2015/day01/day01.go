package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
)

func main() {
	part01ans, err := part01()

	if err != nil {
		fmt.Println("Error reading input file:", err)
	}

	fmt.Println("Part 01 answer:", part01ans)

	part02ans, err := part02()

	if err != nil {
		fmt.Println("Error reading input file:", err)
	}

	fmt.Println("Part 02 answer:", part02ans)

}

func part01() (int, error) {
	floor := 0

	input, err := os.Open("./day01/input.txt")
	if err != nil {
		fmt.Println("Error reading input file:", err)
		return 0, err
	}
	defer input.Close()

	reader := bufio.NewReader(input)

	for {
		char, _, err := reader.ReadRune()
		if err == io.EOF {
			break
		}
		if err != nil {
			fmt.Println("Error reading character:", err)
			return 0, err
		}
		switch char {
		case '(':
			floor++
		case ')':
			floor--
		}
	}
	return floor, nil
}

func part02() (int, error) {
	floor := 0
	i := 0

	input, err := os.Open("./day01/input.txt")
	if err != nil {
		fmt.Println("Error reading input file:", err)
		return 0, err
	}
	defer input.Close()

	reader := bufio.NewReader(input)

	for {
		char, _, err := reader.ReadRune()
		if err == io.EOF {
			break
		}
		if err != nil {
			fmt.Println("Error reading character:", err)
			return -1, err
		}

		switch char {
		case '(':
			floor++
		case ')':
			floor--
		}
		i++

		if floor == -1 {
			return i, nil
		}
	}
	return -1, nil
}
