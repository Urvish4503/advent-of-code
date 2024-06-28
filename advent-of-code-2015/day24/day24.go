package main

import (
	"fmt"
	"os"
)

func main() {
	input, err := os.Open(".//sample.txt")

	if err != nil {
		fmt.Println("Error reading input file:", err)
		return
	}

	defer input.Close()

}
