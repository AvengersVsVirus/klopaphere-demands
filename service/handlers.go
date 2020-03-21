package main

import (
	"encoding/json"
	"github.com/klopaphere-demands/models"
	"net/http"
)

func GetStatusEndpoint(w http.ResponseWriter, r *http.Request) {
	var status models.Status
	status.Msg = "OK"
	status.Version = "1.0.0"

	json.NewEncoder(w).Encode(status)
}
