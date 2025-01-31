#!/Users/user/brew/Cellar/bash/5.2.37/bin/bash

# Array of folders to test
folders=(
    "0_1MB_files"
    "100MB_files"
    "10MB_files"
    "1MB_files"
)

# Number of executions for each folder and concurrency level
n=2  # Change this to your desired number of executions
#n=10  # Change this to your desired number of executions

# Array of concurrency levels to test
#concurrency_levels=(1 2 10 100 1000)
concurrency_levels=(1)

# Define CSV filename
results_file="execution_times_gcp.csv"

# Check if file exists, if not, create header
if [ ! -f "$results_file" ]; then
    echo "Folder,Concurrency,Mean_Time,Std_Dev,Times" > "$results_file"
fi

for concurrency in "${concurrency_levels[@]}"; do
    for folder in "${folders[@]}"; do
        echo
        echo "Processing folder: $folder with concurrency level: $concurrency"
        times=()

        # Set concurrency level for this run using 'awslocal'
        #awslocal configure set default.s3.max_concurrent_requests $concurrency
        
        # Main loop for each folder and concurrency level
        for ((i=1; i<=$n; i++)); do
            # Measure execution time of the command
            #execution_time=$(gtime -f "%e" awslocal s3 cp --quiet --recursive "./files/$folder" "s3://data/$folder" 2>&1 >/dev/null)
            execution_time=$(gtime -f "%e" gcloud storage cp -r ./files/$folder gs://costellr-data-perf --project=constellr2025  2>&1 >/dev/null)
           # gcloud storage cp ./files/$folder gs://costellr-data-perf --project=constellr2025 
            if [ $? -ne 0 ]; then
                echo "Error executing command for $folder with concurrency $concurrency at iteration $i"
                continue
            fi
            times+=($execution_time)
            echo "Execution $i completed in $execution_time seconds"
        done

        # If there are no valid times, skip to next folder and concurrency level
        if [ ${#times[@]} -eq 0 ]; then
            echo "No valid execution times were recorded for $folder with concurrency $concurrency."
            continue
        fi

        # Write times to a temporary file
        tmpfile=$(mktemp)
        echo "${times[*]}" | tr ' ' '\n' > "$tmpfile"

        # Use datamash to calculate mean and standard deviation
        mean=$(datamash mean 1 < "$tmpfile")
        std_dev=$(datamash sstdev 1 < "$tmpfile")

        # Format the output to 3 decimal places
        formatted_mean=$(printf "%.3f" "$mean")
        formatted_std_dev=$(printf "%.3f" "$std_dev")

        # Echo results to console
        echo "Mean execution time for $folder with concurrency $concurrency: $formatted_mean seconds, Standard deviation: $formatted_std_dev seconds"

        # Append results to CSV
        echo "$folder,$concurrency,$formatted_mean,$formatted_std_dev,${times[*]}" >> "$results_file"

        # Clean up the temporary file
        rm "$tmpfile"
    done

    # Reset concurrency level to default after testing each concurrency level
    # awslocal configure set default.s3.max_concurrent_requests 10
done
