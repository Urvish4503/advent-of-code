package main

import (
	"bufio"
	"fmt"
	"os"
)

func deliverPresents(moves string) int {
	visitedHouses := make(map[int]map[int]bool)
	x, y := 0, 0

	visitedHouses[0] = make(map[int]bool)
	visitedHouses[0][0] = true
	housesVisited := 1

	for _, move := range moves {
		switch move {
		case '<':
			y--
		case '>':
			y++
		case 'v':
			x--
		case '^':
			x++
		}

		if visitedHouses[x] == nil {
			visitedHouses[x] = make(map[int]bool)
		}
		if !visitedHouses[x][y] {
			visitedHouses[x][y] = true
			housesVisited++
		}
	}

	return housesVisited
}

func deliverPresentsWithRoboSanta(moves string) int {
	visitedHouses := make(map[int]map[int]bool)
	santaX, santaY := 0, 0
	roboX, roboY := 0, 0

	visitedHouses[0] = make(map[int]bool)
	visitedHouses[0][0] = true
	housesVisited := 1

	for i, move := range moves {
		var x, y *int
		if i%2 == 0 {
			x, y = &santaX, &santaY
		} else {
			x, y = &roboX, &roboY
		}

		switch move {
		case '<':
			*y--
		case '>':
			*y++
		case 'v':
			*x--
		case '^':
			*x++
		}

		if visitedHouses[*x] == nil {
			visitedHouses[*x] = make(map[int]bool)
		}
		if !visitedHouses[*x][*y] {
			visitedHouses[*x][*y] = true
			housesVisited++
		}
	}

	return housesVisited
}

func main() {
	input, err := os.Open("./day03/input.txt")
	if err != nil {
		fmt.Println("Error reading input file:", err)
		return
	}
	defer input.Close()

	scanner := bufio.NewScanner(input)
	scanner.Split(bufio.ScanRunes)

	var moves string
	for scanner.Scan() {
		moves += scanner.Text()
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error reading input:", err)
		return
	}

	part1Result := deliverPresents(moves)
	part2Result := deliverPresentsWithRoboSanta(moves)

	fmt.Printf("Part 1 - Houses visited by Santa: %d\n", part1Result)
	fmt.Printf("Part 2 - Houses visited by Santa and Robo-Santa: %d\n", part2Result)
}
