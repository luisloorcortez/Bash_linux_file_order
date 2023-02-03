# Bash File Order

![Development Status](https://img.shields.io/badge/STATUS-DEVELOPING-blue)

## Description
A bash script to organize files and folders in a specific directory into subdirectories based on their extensions or type.

## Variables
- `src_dir`: the source directory where the files and folders are located.
- `dst_dir`: the destination directory where the organized files and folders will be moved to.

## Extension Directory
An associative array named `extension` is defined to store the destination directory of each file extension. It contains the following file extensions and their corresponding destination directories:
- `.sql` files to `$dst_dir/db`
- `.pem` files to `$dst_dir/aws`
- `.pdf`, `.epub`, `.mobi` files to `$dst_dir/pdf`

## Entry Point and Verification
The script checks if the source directory `$src_dir` exists. If it does, it changes the current working directory to `$src_dir`. If `$dst_dir` does not exist, it is created. If `$src_dir` does not exist, the script terminates with an error message.

## Iteration List
The script iterates through the files and folders in the source directory. Directories are moved to a subdirectory named "folder" in the destination directory. Files with extensions defined in the `extension` array are moved to the corresponding destination directory. Files with undefined extensions are moved to a subdirectory named "other" in the destination directory. The script checks if the subdirectories and files already exist in the destination directory and takes the appropriate action (delete or create subdirectory) based on the result.

## Folders
If the element is a folder, the script checks if a folder named "folder" exists within the destination directory. If not, it is created. If a folder with the same name already exists within "folder", the original folder is deleted. If a folder with the same name does not exist, the original folder is moved to "folder".

## Files with Known Extensions
If the file has a known extension, the script checks if a folder with the same name as the extension exists within the destination directory. If not, it is created. If a file with the same name already exists within the folder corresponding to the extension, the original file is deleted. If a file with the same name does not exist, the original file is moved to the folder corresponding to the extension.

## Files with Unknown Extensions
If the file does not have a known extension, the script checks if a folder named "other" exists within the destination directory. If not, it is created. If a file with the same name already exists within "other", the original file is deleted. If a file with the same name does not exist, the original file is moved to "other".

## Output
There is no specific output from the script, but messages will be displayed on the screen if any elements are deleted due to naming conflicts.

