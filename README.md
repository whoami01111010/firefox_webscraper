Firefox Web Scraper

Firefox Web Scraper is a bash script tool designed to scrape and analyze your Firefox browsing history. It interacts directly with Firefox's internal SQLite database (places.sqlite) to extract data such as visited websites, search keywords, traffic details, and provides detailed statistics on website visits.

This tool is helpful for users who want to analyze their Firefox browsing history for research, personal insights, or data recovery purposes. It comes with an easy-to-use, text-based menu system, allowing you to fetch and store various types of browser history data.
Features:
    Search Keywords: Extracts and lists search terms from your browsing history (e.g., Google, Bing).
    Visited Websites: Displays the most frequently visited websites from your Firefox history.
    Traffic Details: Fetches detailed visit information, including timestamps for when each website was visited.
    Website Visit Counts: Provides statistics about the number of times specific websites (e.g., YouTube, Instagram) were visited, including breakdowns for categories like Shorts and Reels.
    Export Data: Allows users to save the scraped data to a text file for further analysis.

Requirements:
    Linux: This script is designed to work on Linux-based systems (Ubuntu, Fedora, etc.).
    Firefox: The script relies on Firefox’s profile and places.sqlite database, which stores browsing history.
    SQLite3: The script uses sqlite3 to query the Firefox database.
    Bash: The tool is written in bash, making it easy to use on Linux systems.
Installation:
    Clone the repository:

    git clone https://github.com/yourusername/firefox-web-scraper.git
    cd firefox-web-scraper

Make the script executable:

    chmod +x firefox-web-scraper.sh

Run the script:

    ./firefox-web-scraper.sh

How It Works:

The script interacts with Firefox's places.sqlite file located in the user’s profile folder.
    It queries the SQLite database to extract:
        Search keywords (search?q=)
        Visited websites and their visit counts
        Traffic details with visit timestamps
        Counts of specific websites (like YouTube, Instagram) with optional breakdowns (Shorts, Reels)
    The results are displayed in a tabular format, and users can choose to save the output to a file.

Menu Options:
    List all search keywords: Extracts and displays the search terms used in the browser.
    List all visited websites: Lists the websites you’ve visited most frequently.
    List all traffic details: Displays the visit timestamps along with URLs.
    List counts of visited websites: Displays the counts of visits for specific websites (YouTube, Instagram, etc.).
    Exit: Exit the script.
