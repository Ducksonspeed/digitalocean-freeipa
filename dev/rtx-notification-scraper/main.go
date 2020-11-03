package main

import (
    "fmt"
    "os"

	"github.com/anaskhan96/soup"
	// "github.com/aws/aws-sdk-go/aws"
    // "github.com/aws/aws-sdk-go/aws/session"
    // "github.com/aws/aws-sdk-go/service/sns"

)


func main() {

    resp, err := soup.Get("https://www.nvidia.com/en-gb/shop/geforce/?page=1&limit=9&locale=en-gb")
    if err != nil {
        os.Exit(1)
    }

    doc := soup.HTMLParse(resp)
    grid := doc.FindStrict("div", "class", "featured-container-x1 buy")
    conditions := grid.Find("div", "class", "buy")
    primaryCondition := conditions.Find("div")
    secondaryCondition := primaryCondition.FindNextElementSibling()
    links := secondaryCondition.Find("div", "class", "buy").Find("div").Text()
    fmt.Println("Text : " + links)    
	}
