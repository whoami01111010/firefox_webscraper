#!/bin/bash

# Function to print the banner
print_banner() {
    clear
    echo -e "\e[1;36m"
    echo "#########################################"
    echo "#           Firefox Web Scraper         #"
    echo "#           Scrape Your History         #"
    echo "#            by Robert Mitnick          #"
    echo "#########################################"
    echo -e "\e[0m"
}

# Define the Firefox profile path
PROFILE_PATH="/home/robert/.mozilla/firefox/mnu44pif.default-esr"
PLACES_DB="$PROFILE_PATH/places.sqlite"

# Check if places.sqlite exists
if [ ! -f "$PLACES_DB" ]; then
    echo "Error: places.sqlite not found in $PROFILE_PATH"
    exit 1
fi

# Initialize counters for different websites and specific URLs
declare -A counts
counts["youtube"]=0
counts["shorts"]=0
counts["reels"]=0
counts["instagram"]=0
counts["hiddenchats"]=0
counts["other_sites"]=0

# Function to extract and list search keywords (Only top 10)
list_search_keywords() {
    clear
    echo -e "\n\e[1;32mFetching search keywords...\e[0m"
    sqlite3 "$PLACES_DB" "
    SELECT url FROM moz_places
    WHERE url LIKE '%search?q=%' OR url LIKE '%q=%' OR url LIKE '%query=%';
    " | sed -E 's/.*[?&](q|query|search)=([^&]+).*/\2/' | sed 's/+/\ /g' | head -n 10 | column -t

    # Ask the user for a file name to save the data
    read -p "Enter a filename to save the data (e.g., search_keywords.txt): " filename
    sqlite3 "$PLACES_DB" "
    SELECT url FROM moz_places
    WHERE url LIKE '%search?q=%' OR url LIKE '%q=%' OR url LIKE '%query=%';
    " | sed -E 's/.*[?&](q|query|search)=([^&]+).*/\2/' | sed 's/+/\ /g' > "$filename"

    echo -e "\nData has been saved to $filename"
    read -p "Press Any Key to Return to Menu "
}

# Function to list all visited websites (Only top 10)
list_all_websites() {
    clear
    echo -e "\n\e[1;32mFetching all visited websites...\e[0m"
    sqlite3 "$PLACES_DB" "
    SELECT url FROM moz_places ORDER BY visit_count DESC;
    " | head -n 10 | column -t

    # Ask the user for a file name to save the data
    read -p "Enter a filename to save the data (e.g., visited_websites.txt): " filename
    sqlite3 "$PLACES_DB" "
    SELECT url FROM moz_places ORDER BY visit_count DESC;" > "$filename"

    echo -e "\nData has been saved to $filename"
    read -p "Press Any Key to Return to Menu "
}

# Function to list all traffic details (Only top 10)
list_traffic_details() {
    clear
    echo -e "\n\e[1;32mFetching traffic details...\e[0m"
    sqlite3 "$PLACES_DB" "
    SELECT datetime(moz_historyvisits.visit_date/1000000, 'unixepoch') AS visit_time, url
    FROM moz_places
    JOIN moz_historyvisits ON moz_places.id = moz_historyvisits.place_id
    ORDER BY visit_time DESC;
    " | head -n 10 | column -t

    # Ask the user for a file name to save the data
    read -p "Enter a filename to save the data (e.g., traffic_details.txt): " filename
    sqlite3 "$PLACES_DB" "
    SELECT datetime(moz_historyvisits.visit_date/1000000, 'unixepoch') AS visit_time, url
    FROM moz_places
    JOIN moz_historyvisits ON moz_places.id = moz_historyvisits.place_id
    ORDER BY visit_time DESC;
    " > "$filename"

    echo -e "\nData has been saved to $filename"
    read -p "Press Any Key to Return to Menu "
}

# Function to count and display website visit statistics
list_webvisit_count() {
	read -p "Enter the Filename where your dataset Located(e.g., website_data.txt):" filename
    clear
    echo -e "\n\e[1;32mFetching the counts...\e[0m"
    
    # Read the input file once, and increment counts based on URLs
    while IFS= read -r line; do
        if [[ "$line" == *"youtube.com"* ]]; then
            counts["youtube"]=$((counts["youtube"] + 1))
            [[ "$line" == *"/shorts/"* ]] && counts["shorts"]=$((counts["shorts"] + 1))
        elif [[ "$line" == *"instagram.com"* ]]; then
            counts["instagram"]=$((counts["instagram"] + 1))
            [[ "$line" == *"/reels/"* ]] && counts["reels"]=$((counts["reels"] + 1))
        elif [[ "$line" == *"hiddenchats.com"* ]]; then
            counts["hiddenchats"]=$((counts["hiddenchats"] + 1))
        else
            counts["other_sites"]=$((counts["other_sites"] + 1))
        fi
    done < $filename

    # Display the counts in a table format
    echo -e "\n\e[1;33mVisited Website Counts:\e[0m"
    echo "-----------------------------------------"
    echo "|    Website      |   Count             |"
    echo "-----------------------------------------"
    echo "| YouTube         | ${counts["youtube"]}       "
    echo "| Shorts          | ${counts["shorts"]}        "
    echo "| Instagram       | ${counts["instagram"]}     "
    echo "| Reels           | ${counts["reels"]}         "
    echo "| HiddenChats     | ${counts["hiddenchats"]}   "
    echo "| Other Sites     | ${counts["other_sites"]}   "
    echo "-----------------------------------------"

    # Ask the user for a file name to save the data
    read -p "Enter a filename to save the data (e.g., visit_counts.txt): " filename
    echo -e "\nVisited Website Counts:" > "$filename"
    echo "-----------------------------------------" >> "$filename"
    echo "|    Website      |   Count             |" >> "$filename"
    echo "-----------------------------------------" >> "$filename"
    echo "| YouTube         | ${counts["youtube"]}       " >> "$filename"
    echo "| Shorts          | ${counts["shorts"]}        " >> "$filename"
    echo "| Instagram       | ${counts["instagram"]}     " >> "$filename"
    echo "| Reels           | ${counts["reels"]}         " >> "$filename"
    echo "| HiddenChats     | ${counts["hiddenchats"]}   " >> "$filename"
    echo "| Other Sites     | ${counts["other_sites"]}   " >> "$filename"
    echo "-----------------------------------------" >> "$filename"

    echo -e "\nData has been saved to $filename"
    read -p "Press Any Key to Return to Menu "
}

# Menu system
while true; do
    print_banner
    echo -e "\n\e[1;36mFirefox History Menu\e[0m"
    echo -e "1. List all search keywords"
    echo -e "2. List all visited websites"
    echo -e "3. List all traffic details"
    echo -e "4. List Counts of Visited Websites"
    echo -e "5. Exit"
    read -p "Choose an option (1-5): " choice

    case $choice in
        1) list_search_keywords ;;
        2) list_all_websites ;;
        3) list_traffic_details ;;
        4) list_webvisit_count ;;
        5) echo -e "\n\e[1;31mExiting... Goodbye!\e[0m"; exit 0 ;;
        *) echo -e "\n\e[1;31mInvalid choice! Please select a valid option.\e[0m"; read -p "Press any key to try again" ;;
    esac
done
