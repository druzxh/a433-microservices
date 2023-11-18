#!/bin/bash

# Build Docker image from Dockerfile
echo "Building Docker image..."
docker build -t karsajobs:latest .

# List local images
echo "Listing local images..."
docker images

# Created tag
echo "Creating image tag..."
docker tag karsajobs:latest ghcr.io/druzxh/karsajobs:latest

# Login to GitHub Container Repository
echo "Logging in to GitHub Container Repository..."
echo $CR_PAT | docker login ghcr.io -u druzxh --password-stdin

# Push to GitHub Container Repository
echo "Pushing to GitHub Container Repository..."
docker push ghcr.io/druzxh/karsajobs:latest
