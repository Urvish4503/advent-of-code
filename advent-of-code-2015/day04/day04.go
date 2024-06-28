package main

import (
	"bufio"
	"crypto/md5"
	"encoding/hex"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func mining(secret string, prefixAmount int) {
	for i := 1; ; i++ {
		str := secret + strconv.Itoa(i)
		buf := md5.Sum([]byte(str))
		res := hex.EncodeToString(buf[:])
		if strings.HasPrefix(res, strings.Repeat("0", prefixAmount)) {
			fmt.Println(i)
			return
		}
	}
}

func main() {
	input, err := os.Open("./day04/input.txt")

	if err != nil {
		fmt.Println("Error reading input file:", err)
		return
	}

	defer input.Close()

	scanner := bufio.NewScanner(input)
	scanner.Split(bufio.ScanRunes)

	var secret string
	for scanner.Scan() {
		secret += scanner.Text()
	}

	mining(secret, 5)
	mining(secret, 6)

}
