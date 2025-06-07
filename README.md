# 🦊 Firefox Web Scraper

A powerful and user-friendly **Bash script tool** for extracting, analyzing, and exporting Firefox browsing history. This tool interacts directly with Firefox’s internal **SQLite database** (`places.sqlite`) to generate insightful statistics about your online activity.

> 📊 Ideal for researchers, digital forensics experts, privacy auditors, or anyone interested in analyzing their browsing behavior.

---

## 🚀 Features

- 🔍 **Search Keywords Extraction**  
  Extracts search queries from engines like Google, Bing, and others.

- 🌐 **Visited Websites Analysis**  
  Displays the most frequently visited domains in tabular form.

- 🕵️ **Traffic Timeline Details**  
  Fetches URLs with visit timestamps for chronological insights.

- 📈 **Website Visit Counts**  
  Displays visit statistics for common platforms (YouTube, Instagram, etc.), including Shorts and Reels.

- 💾 **Data Export Support**  
  Option to save any output to a `.txt` file for backup or further analysis.

---

## 📦 Requirements

- 🐧 Linux (Ubuntu, Kali, Fedora, etc.)
- 🔥 Firefox browser (profile required)
- 🗃️ `sqlite3` installed (`sudo apt install sqlite3`)
- 🖥️ Bash shell

---

## 📥 Installation

1.Clone the repository using Git:

```bash
git clone https://github.com/whoami01111010/firefox-web-scraper.git
cd firefox-web-scraper
```
2.Make the script executable:
```
chmod +x firefox-web-scraper.sh
```
3.Run the script:
```
./firefox-web-scraper.sh
```
---
🛠️ How It Works

    The script locates your Firefox places.sqlite file, usually found in your profile directory (~/.mozilla/firefox/*.default-release/places.sqlite).
    It runs SQLite queries to fetch the following:

        ✅ Search terms (search?q=)
        ✅ URLs visited and visit counts
        ✅ Exact timestamps of visits
        ✅ Filters for platforms like YouTube, Instagram, etc.

    Results are presented in a clean, text-based format and can optionally be saved to a file.
---
📜 Menu Options
-Upon launching, you’ll see a text-based interface with options:

1. List all search keywords
2. List all visited websites
3. List all traffic details (URLs + timestamps)
4. List counts of visited websites (YouTube, Instagram, etc.)
5. Exit
---

Select any option by entering the corresponding number.
📁 Example Output (Visit Stats)
Website	Visit Count
youtube.com	132
|instagram.com|	78|
|facebook.com |	45|

🔒 Privacy Note
This tool analyzes your own local Firefox history only. It does not transmit or expose data externally. Use responsibly.

⚠️ Disclaimer
This tool is intended for educational, auditing, or recovery purposes only. Use it only on Firefox profiles you own or have permission to inspect.

📜 License
This project is licensed under the MIT License. See the LICENSE file for details.

👨‍💻 Author
whoami01111010
GitHub: github.com/whoami01111010
