package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func multioply2smallest(l, w, h int) int {
	if l > w {
		l, w = w, l
	}
	if w > h {
		w, h = h, w
	}
	return l * w
}

func area(l, w, h int) int {
	return 2*l*w + 2*w*h + 2*h*l
}

func add2smallest(l, w, h int) int {
	if l > w {
		l, w = w, l
	}
	if w > h {
		w, h = h, w
	}
	return l + l + w + w

}

func main() {
	input, err := os.Open("./day02/input.txt")

	if err != nil {
		fmt.Println("Error reading input file:", err)
		return
	}

	defer input.Close()

	scanner := bufio.NewScanner(input)

	ans1 := 0
	ans2 := 0

	for scanner.Scan() {
		line := scanner.Text()

		dimentions := strings.Split(line, "x")
		l, _ := strconv.Atoi(dimentions[0])
		w, _ := strconv.Atoi(dimentions[1])
		h, _ := strconv.Atoi(dimentions[2])

		ans1 += multioply2smallest(l, w, h) + area(l, w, h)
		ans2 += add2smallest(l, w, h) + (l * w * h)

	}

	fmt.Printf("Answer 1: %d, Answer 2: %d\n", ans1, ans2)
}
