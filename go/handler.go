package main

import sdk "github.com/openfx/openfx/fxwatcher/go/pb"

func Handler(req sdk.Request) string {
	return "echo:" + string(req.Input)
}
