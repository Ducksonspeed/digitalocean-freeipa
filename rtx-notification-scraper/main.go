package main

import (
	"fmt"
	// "io"
	"time"
	// "os"
	"log"
	"net/http"

	"github.com/PuerkitoBio/goquery"
	// "github.com/aws/aws-sdk-go/aws"
    // "github.com/aws/aws-sdk-go/aws/session"
    // "github.com/aws/aws-sdk-go/service/sns"

)


func main() {

    // Create HTTP client with timeout
    client := &http.Client{
        Timeout: 30 * time.Second,
    }

    // Create and modify HTTP request before sending
    request, err := http.NewRequest("GET", "https://www.nvidia.com/en-gb/shop/geforce/gpu/?page=1&limit=9&locale=en-gb&category=GPU", nil)
    if err != nil {
        log.Fatal(err)
    }
    request.Header.Set("User-Agent", "something else")

    // Make request
    response, err := client.Do(request)
    if err != nil {
        log.Fatal(err)
    }
    defer response.Body.Close()

    // Create a goquery document from the HTTP response
    document, err := goquery.NewDocumentFromReader(response.Body)
    if err != nil {
        log.Fatal("Error loading HTTP response body. ", err)
    }


	// Find and print image URLs
    document.Find("class").Each(func(index int, element *goquery.Selection) {
		divid, exists := element.Attr($(".featured-buy-link").parent)
        if exists {
            fmt.Println(divid)
        }
    })
}