/*  Нахождение расстояния Левенштейна
	Версия для Windows.Native, Elements.Island
*/
package main

import (
"bytes"
"fmt"
"os"
"time"
)

func levDist(s1, s2 []byte) int {

	m := len(s1)
	n := len(s2)

	// Edge cases.
	if m == 0 {
		return n
	} else if n == 0 {
		return m
	}

	root := make([]int, (n+1)*2)

	v0 := root[:n+1]
	v1 := root[n+1:]
	for i, _ := range v0 {
		v0[i] = i
		}
	copy(v1, v0)

for i, c1 := range s1 {
	v1[0] = i + 1

		for j, c2 := range s2 {
			substCost := v0[j]
				if c1 != c2 {
					substCost++
					}
					delCost := v0[j+1] + 1
						insCost := v1[j] + 1

							if substCost < delCost {
								v1[j+1] = substCost
								} else {
									v1[j+1] = delCost
									}
									if insCost < v1[j+1] {
										v1[j+1] = insCost
										}
									}

									v0, v1 = v1, v0
									}

return v0[n]
}

func main() {

s1 := bytes.Repeat([]byte("a"), 20000)
s2 := s1
s3 := bytes.Repeat([]byte("b"), 20000)

startTime := time.Now()

fmt.Println(levDist(s1, s2))
fmt.Println(levDist(s1, s3))
//    time.Sleep(1000 * time.Millisecond) // 99900
	execTime := time.Now().Sub(startTime).Seconds() * 10000 // fix
//    execTime := time.Now().Sub(startTime).String() // 99.8µs

//    fmt.Fprintf(os.Stderr, "Finished in %.3fs\n", execTime)  // hang
	fmt.Println(execTime)
}