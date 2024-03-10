import os
import re
from datetime import datetime

def replace_date_in_file_names(directory):
    file_names = os.listdir(directory)
    date_patterns = [
        r"\d{4}-\d{2}-\d{2}",  # YYYY-MM-DD
        r"\d{4}/\d{2}/\d{2}",  # YYYY/MM/DD
        r"\d{4}.\d{2}.\d{2}",  # YYYY.MM.DD
        r"\d{2}-\d{2}-\d{4}",  # DD-MM-YYYY
        r"\d{2}/\d{2}/\d{4}",  # DD/MM/YYYY
        r"\d{2}.\d{2}.\d{4}",  # DD.MM.YYYY
        r"\d{2}\.\d{2}\.\d{4}",  # DD.MM.YYYY
        r"\d{4}\.\d{2}\.\d{2}",  # YYYY.MM.DD
    ]
    
    for file_name in file_names:
        file_path = os.path.join(directory, file_name)
        
        if os.path.isfile(file_path):
            for pattern in date_patterns:
                match = re.search(pattern, file_name)
                if match:
                    old_date = match.group()
                    try:
                        date_obj = datetime.strptime(old_date, "%d.%m.%Y")
                        new_date = date_obj.strftime("%Y-%m-%d")
                        new_file_name = file_name.replace(old_date, "")
                        new_file_name = new_date + new_file_name
                        
                        new_file_path = os.path.join(directory, new_file_name)
                        os.rename(file_path, new_file_path)
                        
                        print("The file '{}' has been renamed to '{}'.".format(file_name, new_file_name))
                    except ValueError:
                        print("Skipping file '{}' as it contains an invalid date format.".format(file_name))
    
    print("All files have been successfully renamed.")

# Example usage of the script
directory_path = input("Enter the path to the directory containing the files: ")
replace_date_in_file_names(directory_path)
