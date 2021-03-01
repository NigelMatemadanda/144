import os
import shutil

desktop_dir = "path to your desktop"
current_dir = os.getcwd()
if not os.path.isdir(current_dir + "/Images"):
    os.makedirs("Images")
    print("Images folder has been created")
else:
    print("Images folder already exists")

if not os.path.isdir(current_dir + "/Documents"):
    os.makedirs("Documents")
    print("Documents folder has been created")
else:
    print("Documents folder already exists")

if not os.path.isdir(current_dir + "/Excel files"):
    os.makedirs("Excel files")
    print("Excel files folder has been created")
else:
    print("Excel files folder already exists")


if not os.path.isdir(current_dir + "/Other files"):
    os.makedirs("Other files")
    print("Other files folder has been created")
else:
    print("Other files folder already exists")

for file in os.listdir(current_dir):
    filename, ext = os.path.splitext(file)
    try:
        if not ext:
            pass
        elif ext in ('.png', '.jpg', '.gif'):
            shutil.move(
                os.path.join(current_dir, f'{filename}{ext}'),
                os.path.join(current_dir, 'Images', f'{filename}{ext}'))

        elif ext in ('.doc', '.docx', '.docm'):
            shutil.move(
                os.path.join(current_dir, f'{filename}{ext}'),
                os.path.join(current_dir, 'Documents', f'{filename}{ext}'))
        elif ext in ('.xls', '.xlsx', '.xlsm', '.xltx'):
            shutil.move(
                os.path.join(current_dir, f'{filename}{ext}'),
                os.path.join(current_dir, 'Excel files', f'{filename}{ext}'))
      
    except (FileNotFoundError, PermissionError):
        pass
