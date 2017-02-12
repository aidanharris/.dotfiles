package main

import (
    "fmt"
    "io/ioutil"
    "log"
    "net/http"
    "strconv"
    "strings"
    "os"
)

func main() {

    const BRIGHTNESS_AMOUNT = 50

    maxBrightness := func() int {
        buff, err := ioutil.ReadFile("/sys/class/backlight/gmux_backlight/max_brightness")
        if err != nil {
            log.Fatal(err)
        }
        buffInt, err := strconv.Atoi(strings.Replace(string(buff), "\n", "", -1))
        if err != nil {
            log.Fatal(err)
        }
        return buffInt
    }()

    maxKeyboardBrightness := func() int {
        buff, err := ioutil.ReadFile("/sys/class/leds/smc::kbd_backlight/max_brightness")
        if err != nil {
            log.Fatal(err)
        }
        buffInt, err := strconv.Atoi(strings.Replace(string(buff), "\n", "", -1))
        if err != nil {
            log.Fatal(err)
        }
        return buffInt
    }()

    currentBrightness := func() int {
        buff, err := ioutil.ReadFile("/sys/class/backlight/gmux_backlight/brightness")
        if err != nil {
            log.Fatal(err)
        }
        buffInt, err := strconv.Atoi(strings.Replace(string(buff), "\n", "", -1))
        if err != nil {
            log.Fatal(err)
        }
        return buffInt
    }

    currentKeyboardBrightness := func() int {
        buff, err := ioutil.ReadFile("/sys/class/leds/smc::kbd_backlight/brightness")
        if err != nil {
            log.Fatal(err)
        }
        buffInt, err := strconv.Atoi(strings.Replace(string(buff), "\n", "", -1))
        if err != nil {
            log.Fatal(err)
        }
        return buffInt
    }

    http.HandleFunc("/increase", func(w http.ResponseWriter, r *http.Request) {
        brightness := maxBrightness
        if (currentBrightness() + BRIGHTNESS_AMOUNT) < maxBrightness {
                brightness = currentBrightness() + BRIGHTNESS_AMOUNT
        }
        buff := []byte(strconv.Itoa(brightness))
        err := ioutil.WriteFile("/sys/class/backlight/gmux_backlight/brightness", buff, os.ModeDevice)
        if(err != nil) { log.Fatal(err) }
        fmt.Fprintf(w, strconv.Itoa(brightness))
    })

    http.HandleFunc("/decrease", func(w http.ResponseWriter, r *http.Request) {
        brightness := 0
        if (currentBrightness() - BRIGHTNESS_AMOUNT) > 0 {
                brightness = currentBrightness() - BRIGHTNESS_AMOUNT
        }
        buff := []byte(strconv.Itoa(brightness))
        err := ioutil.WriteFile("/sys/class/backlight/gmux_backlight/brightness", buff, os.ModeDevice)
        if(err != nil) { log.Fatal(err) }
        fmt.Fprintf(w, strconv.Itoa(brightness))
    })

    http.HandleFunc("/increasekbd", func(w http.ResponseWriter, r *http.Request) {
        brightness := maxKeyboardBrightness
        if (currentKeyboardBrightness() + BRIGHTNESS_AMOUNT) < maxKeyboardBrightness {
                brightness = currentKeyboardBrightness() + BRIGHTNESS_AMOUNT
        }
        buff := []byte(strconv.Itoa(brightness))
        err := ioutil.WriteFile("/sys/class/leds/smc::kbd_backlight/brightness", buff, os.ModeDevice)
        if(err != nil) { log.Fatal(err) }
        fmt.Fprintf(w, strconv.Itoa(brightness))
    })

    http.HandleFunc("/decreasekbd", func(w http.ResponseWriter, r *http.Request) {
        brightness := 0
        if (currentKeyboardBrightness() - BRIGHTNESS_AMOUNT) > 0 {
                brightness = currentKeyboardBrightness() - BRIGHTNESS_AMOUNT
        }
        buff := []byte(strconv.Itoa(brightness))
        err := ioutil.WriteFile("/sys/class/leds/smc::kbd_backlight/brightness", buff, os.ModeDevice)
        if(err != nil) { log.Fatal(err) }
        fmt.Fprintf(w, strconv.Itoa(brightness))
    })

    log.Fatal(http.ListenAndServe(":5600", nil))

}
