#!/bin/sh -l

echo "Game name is $1"

if [ ! -d "$2" ]; then
  echo "$2 does not exist. Ensure directory containing publishable assets is configured and exists."
  exit 1
fi

ls $2

PAYLOAD_FILE="payload.json"

# Start the JSON payload
echo '{ "game": { "name": "' > $PAYLOAD_FILE
echo $1 > $PAYLOAD_FILE
echo '", "assets": [' > $PAYLOAD_FILE

# Iterate over all files in the directory
FIRST=true
for FILE in "$2"/*; do
  BASE64_DATA="data:application/octet-stream;base64,$(base64 "$FILE")"
  FILENAME=$(basename "$FILE")
  
  # Add a comma before each entry except the first
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    echo ',' >> $PAYLOAD_FILE
  fi

  # Append the asset object to the JSON payload
  cat <<EOF >> $PAYLOAD_FILE
    {
      "filename": "$FILENAME",
      "data": "$BASE64_DATA"
    }
EOF
done

# Close the JSON payload
echo '  ] } }' >> $PAYLOAD_FILE

# POST to Final Parsec
curl -X POST https://www.finalparsec.com/api/games \
-H "Content-Type: application/json" \
-d @payload.json


time=$(date)
echo "time=$time" >> $GITHUB_OUTPUT

