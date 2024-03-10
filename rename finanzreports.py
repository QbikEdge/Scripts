import os
import re

def rename_financial_report(directory):
    file_names = os.listdir(directory)
    
    for file_name in file_names:
        file_path = os.path.join(directory, file_name)
        
        if os.path.isfile(file_path):
            match = re.search(r"Finanzreport_Nr\.\d+_vom_(\d{4}-\d{2}-\d{2}).+\.pdf", file_name)
            if match:
                old_date = match.group(1)
                new_file_name = file_name.replace(old_date, "")
                new_file_name = old_date + "_" + new_file_name
                
                new_file_path = os.path.join(directory, new_file_name)
                os.rename(file_path, new_file_path)
                
                print("The file '{}' has been renamed to '{}'.".format(file_name, new_file_name))
    
    print("All files have been successfully renamed.")

# Example usage of the script
directory_path = input("Enter the path to the directory containing the files: ")
rename_financial_report(directory_path)
