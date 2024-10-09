package main

import (
	"fmt"
	"net/http"

	"github.com/prometheus/client_golang/prometheus/promhttp"
)

func hello(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, World!")
}

func metrics(w http.ResponseWriter, r *http.Request) {
	promhttp.Handler().ServeHTTP(w, r)
}

func main() {
	http.HandleFunc("/", hello)
	http.HandleFunc("/metrics", metrics)
	fmt.Println("Server listening on port 8080")
	http.ListenAndServe(":8080", nil)
}
