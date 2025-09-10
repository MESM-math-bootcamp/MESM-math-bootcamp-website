#!/bin/bash

# Define the source folder where the images are located
SOURCE_FOLDER="/Users/c_galazgarcia/Documents/MESM-math-bootcamp/bren-math-workshop/lectures/img"

# Define the destination folder in your project
DEST_FOLDER="/Users/c_galazgarcia/Documents/MESM-math-bootcamp/MESM-math-bootcamp-website/notes/day2_limits/images"

# Create the destination folder if it doesn't exist
mkdir -p "$DEST_FOLDER"

# List of image files to copy
IMAGES=(
  "cake.png"
  "dsqrt.PNG"
  "para.PNG"
  "circle.png"
  "cont.png"
  "discont.png"
  "tan.png"
  "lim4.PNG"
  "lim_graph_1.PNG"
  "limx2.PNG"
  "limit.gif"
  "lim_graph_2.PNG"
  "lim3.PNG"
  "lim_graph_3.png"
  "lim_g_a.PNG"
  "lim_g_b.PNG"
  "lim_g_c.PNG"
  "tangent_line.png"
  "loa.PNG"
  "glacier.jpg"
  "energy.png"
  "bait.jpeg"
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