#!/bin/bash

# Define the source folder where the images are located
SOURCE_FOLDER="/Users/c_galazgarcia/Documents/MESM-math-bootcamp/bren-math-workshop/lectures/img"

# Define the destination folder in your project
DEST_FOLDER="/Users/c_galazgarcia/Documents/MESM-math-bootcamp/MESM-math-bootcamp-website/notes/day3_derivatives/images"

# Create the destination folder if it doesn't exist
mkdir -p "$DEST_FOLDER"

# List of image files to copy
IMAGES=(
  "exp_comic.png"
  "nth.png"
  "carry.webp"
  "dochy.PNG"
  "population-regions-with-projections.png"
  "increase.PNG"
)

# Copy each image from the source folder to the destination folder
for IMAGE in "${IMAGES[@]}"; do
  if [ -f "$SOURCE_FOLDER/$IMAGE" ]; then
    cp "$SOURCE_FOLDER/$IMAGE" "$DEST_FOLDER"
    echo "Copied $IMAGE to $DEST_FOLDER"
  else
    echo "Warning: $IMAGE not found in $SOURCE_FOLDER"
  fi
done

echo "All specified images have been processed."