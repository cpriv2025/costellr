
# Base path where folders will be created
BASE_PATH="./files"

# Function to generate files
generate_files() {
    local size=$1
    local count=$2
    local prefix=$3
    local folder=$4

    # Create the folder if it doesn't exist
    mkdir -p "${BASE_PATH}/${folder}"

    for i in $(seq 0 $((count - 1))); do
        local filename="${BASE_PATH}/${folder}/${prefix}_${i}"
        # Use mkfile to create files with specified size
        mkfile -n $size "$filename"
        echo "Created $filename with size $size"
    done
}

# Generate 1 object of 100MB
generate_files "100m" 1 "obj_100MB" "100MB_files"

# Generate 10 objects of 10MB
generate_files "10m" 10 "obj_10MB" "10MB_files"

# Generate 100 objects of 1MB
generate_files "1m" 100 "obj_1MB" "1MB_files"

# Generate 1000 objects of 0.1MB (100KB)
generate_files "100k" 1000 "obj_0_1MB" "0_1MB_files"

echo "All files have been generated in their respective folders under $BASE_PATH."
