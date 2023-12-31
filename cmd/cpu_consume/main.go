package main

import (
	// "fmt"
	"math"
	"sync"
	"time"
)

func main() {
	// // 通过设置不同的coreNum测试多核心CPU利用率
	// coreNum := 1
	// for i := 0; i < coreNum; i++ {
	// 	go task(i)
	// }
	// // 通过等待输入实现main-goroutine不会终止
	// a := ""
	// fmt.Scan(&a)
	taskSchedule_1()
	// select {}
	c := make(chan struct{})
	// <-c
	c <- struct{}{}
}
func taskSchedule_1() {
	var wgTask sync.WaitGroup
	for {
		wgTask.Add(1) //为计数器设置值

		go func() {
			timeNow := time.Now().Hour()
			if timeNow < 6 && timeNow > 0 {
				task(timeNow)
				time.Sleep(53 * time.Minute)
			} else {
				task(timeNow)
				time.Sleep(71 * time.Minute)
			}

			wgTask.Done()
		}()

		wgTask.Wait() //阻塞到计数器的值为0
		time.Sleep(time.Minute)
	}
}

func task(id int) {
	var j float64 = 0.0
	// 通过设置step来决定一个60秒的统计窗口展示几个正弦函数周期
	var step float64 = 0.1
	for j = 0.0; j < 8*2*math.Pi; j += step {
		compute(1000.0, math.Sin(j)/2.0+0.38, id)
	}
}

/**
* t 一个总的CPU利用率的统计周期，1000毫秒，感兴趣的可以测试一下时间段小于1000毫秒与大于1000毫秒的情况下曲线如何
* percent [0, 1], CPU利用率百分比
 */
func compute(t, percent float64, id int) {
	// t 总时间，转换为纳秒
	var r int64 = 1000 * 1000
	totalNanoTime := t * (float64)(r)               // 纳秒
	runtime := totalNanoTime * percent              // 纳秒
	sleeptime := totalNanoTime - runtime            // 纳秒
	starttime := time.Now().UnixNano()              // 当前的纳秒数
	d := time.Duration(sleeptime) * time.Nanosecond // 休眠时间
	// fmt.Println("id:", id, ", totaltime = ", t, ", runtime = ", runtime, ", sleeptime = ", sleeptime, " sleep-duration=", d, ", nano = ", time.Now().UnixNano())
	for float64(time.Now().UnixNano())-float64(starttime) < runtime {
		// 此处易出错：只能用UnixNano而不能使用Now().Unix()
		// 因为Unix()的单位是秒，而整个运行周期
	}
	time.Sleep(d)
}
