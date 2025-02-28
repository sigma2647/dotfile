import os
import requests
from pathlib import Path

def fetch_github_hosts(url):
    """从指定 URL 获取最新的 GitHub hosts 内容。"""
    try:
        response = requests.get(url)
        response.raise_for_status()
        return response.text
    except requests.RequestException as e:
        print(f"获取 GitHub hosts 失败：{e}")
        return None

def update_local_hosts(github_hosts, marker="### GitHub520 Host Start"):
    """将 GitHub hosts 内容添加到本地的 hosts 文件中。"""
    hosts_path = Path("/etc/hosts")
    if not os.access(hosts_path, os.W_OK):
        print("需要管理员权限才能修改 /etc/hosts 文件，请以 sudo 运行。")
        return

    try:
        # 读取原始 hosts 文件内容
        with hosts_path.open("r") as file:
            lines = file.readlines()

        # 查找标记位置
        try:
            start_index = lines.index(f"{marker}\n")
            end_index = lines.index("### GitHub520 Host End\n")
            # 删除旧的 GitHub hosts 内容
            del lines[start_index:end_index + 1]
        except ValueError:
            # 如果标记不存在，则在文件末尾添加
            start_index = len(lines)

        # 插入新的 GitHub hosts 内容
        new_lines = [f"{marker}\n", github_hosts, "### GitHub520 Host End\n"]
        lines[start_index:start_index] = new_lines

        # 写回 hosts 文件
        with hosts_path.open("w") as file:
            file.writelines(lines)
        print("/etc/hosts 文件已更新，将 GitHub 域名解析添加成功。")
    except Exception as e:
        print(f"修改 /etc/hosts 文件失败：{e}")

if __name__ == "__main__":
    # GitHub520 项目提供的最新 hosts 文件地址
    github_hosts_url = "https://raw.githubusercontent.com/521xueweihan/GitHub520/main/hosts"
    github_hosts_content = fetch_github_hosts(github_hosts_url)
    if github_hosts_content:
        update_local_hosts(github_hosts_content)

