import os
import shutil
from datetime import datetime

# ホームディレクトリのパス
home_dir = os.path.expanduser("~")

# dotfilesフォルダのパス
dotfiles_dir = os.path.join(home_dir, "dotfiles", "dotfiles")

# バックアップディレクトリの名前を現在の日時から生成
backup_dir_name = datetime.now().strftime("%Y%m%d%H%M%S")
backup_dir = os.path.join(home_dir, "backup", backup_dir_name)

# バックアップディレクトリが存在しない場合は作成
os.makedirs(backup_dir, exist_ok=True)

# dotfilesフォルダ内のファイルとディレクトリを処理
for item in os.listdir(dotfiles_dir):
    item_path = os.path.join(dotfiles_dir, item)
    target_path = os.path.join(home_dir, item)

    # 同名のファイルまたはディレクトリが存在する場合はバックアップを作成
    if os.path.exists(target_path):
        # バックアップディレクトリ内にバックアップを作成
        backup_item_path = os.path.join(backup_dir, item)
        shutil.move(target_path, backup_item_path)
        print(f"Backup: {target_path} -> {backup_item_path}")

    # シンボリックリンクを作成
    os.symlink(item_path, target_path)
    print(f"Created symlink: {item_path} -> {target_path}")

print("Dotfiles symlink setup completed.")
