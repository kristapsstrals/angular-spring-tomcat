#!/bin/bash
#      ^^^^ - NOT /bin/sh, as this code uses arrays

pids=( )

# define cleanup function
cleanup() {
  for pid in "${pids[@]}"; do
    kill -0 "$pid" && kill "$pid" # kill process only if it's still running
  done
}

# and set that function to run before we exit, or specifically when we get a SIGTERM
trap cleanup EXIT TERM

(cd frontend && npm run dev) & pids+=( "$!" )
(cd backend && ./gradlew bootRun) & pids+=( "$!" )

wait # sleep until all background processes have exited, or a trap fires
