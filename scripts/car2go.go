package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"os"

	_ "github.com/lib/pq"
)

const (
	configFile = "./config.json"
	openString = "user=%s password=%s host=%s port=%d dbname=%s sslmode=require"
)

var config = &Config{}

// Config holds configuration values read in from the config file
type Config struct {
	User   string
	Pass   string
	Host   string
	Port   int
	DBName string
}

// loadConfig reads configuration values from the config file
func loadConfig() {
	file, err := os.Open(configFile)
	if err != nil {
		log.Fatal(err)
	}
	decoder := json.NewDecoder(file)
	err = decoder.Decode(&config)
	if err != nil {
		log.Fatal(err)
	}
}

func main() {
	loadConfig()
	db, err := sql.Open("postgres", fmt.Sprintf(openString, config.User, config.Pass, config.Host, config.Port, config.DBName))
	if err != nil {
		log.Fatal("Err on open: ", err)
	}

	if err = db.Ping(); err != nil {
		log.Fatal("Err on ping: ", err)
	}
}
