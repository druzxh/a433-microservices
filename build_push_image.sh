#!/bin/bash

# Build Docker image from Dockerfile
echo "Building Docker image..."
docker build -t item-app:v1 .

# List local images
echo "Listing local images..."
docker images

# Created tag
echo "Creating image tag..."
docker tag item-app:v1 ghcr.io/druzxh/item-app:v1

# Login to GitHub Container Repository
echo "Logging in to GitHub Container Repository..."
echo $CR_PAT | docker login ghcr.io -u druzxh --password-stdin

# Push to GitHub Container Repository
echo "Pushing to GitHub Container Repository..."
docker push ghcr.io/druzxh/item-app:v1
