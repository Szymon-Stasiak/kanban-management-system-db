#!/bin/sh

cd "$(dirname "$0")" || {
  echo "Directory ./kanban-management-system-DB not found. Exiting."
  exit 1
}

echo "Stopping and removing all Docker containers and associated volumes..."
docker compose down -v

echo "Starting up the Docker containers..."
docker compose up
