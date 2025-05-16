#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
current_date=$(date "+%Y年%m月%d日 %A %H:%M:%S")
hostname=$(hostname)
# 获取主板信息
get_pm_info() {
    echo -e "${RED}主板信息${NC}:"
    sudo dmidecode -t 1 | grep -E "Manufacturer|Product Name|Serial Number"
    echo ""
}
# 获取CPU信息
get_cpu() {
    echo -e "${RED}CPU信息:${NC}"
    sudo dmidecode -t processor | grep -E 'Socket|Core Count|Version'
    echo ""
}
# 获取内存信息
get_mem() {
    # 获取内存槽位总数
    total_slots=$(sudo dmidecode -t memory | grep -i "Number Of Devices" | awk '{print $NF}')
    echo -e "${RED}内存信息:${NC}"
    echo "内存槽位总数: $total_slots"
    # 提取已安装的内存模块数量及详细信息
    installed_memory_count=0
    echo "  已安装的内存模块:"
    while IFS= read -r line; do
        size=$(echo "$line" | awk '{print $2}')
        slot=$(echo "$line" | awk -F': ' '{print $1}')
        if [[ "$size" != "No" && "$size" != "Unknown" ]]; then
            installed_memory_count=$((installed_memory_count + 1))
            echo "    ${slot}: ${size} GB"
        fi
    done < <(sudo dmidecode -t memory | grep -E "Size:|Locator:")
    echo "  已安装的内存模块数量: $installed_memory_count"
    # 获取内存总数（总容量）
    memory_total=$(free -h | awk '/^Mem:/ {print $2}')
    echo "  内存总数: $memory_total"
    echo ""
}
# 获取磁盘信息
get_disk() {
    echo -e "${RED}磁盘信息:${NC}"
    lsblk -d -o NAME,TYPE,SIZE | grep -v loop
    echo ""
}
# 获取GPU信息
get_gpu() {
    echo -e "${RED}GPU信息:${NC}"
    if command -v nvidia-smi &> /dev/null; then
        nvidia-smi -L
    else
        echo -e "未检测到NVIDIA GPU或nvidia-smi命令不可用。"
        echo -e "尝试使用lspci查找其他GPU设备："
    fi
    echo ""
}
# 获取网络信息
get_network() {
    # 获取所有网络接口名称
    interfaces=$(ls /sys/class/net/)
    
    # 打印所有网络接口名称
    echo -e "${RED}所有网络接口:${NC}"
    for iface in $interfaces; do
        echo -e "  ${GREEN}${iface}${NC}"
    done
    # 打印每个接口及其对应的 IPv4 地址
    echo -e "\n${RED}接口及对应的 IPv4 地址:${NC}"
    for iface in $interfaces; do
        ip_address=$(ip -4 addr show dev "$iface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
        if [ -n "$ip_address" ]; then
            echo -e "  ${GREEN}${iface}:${NC} ${ip_address}"
        else
            echo -e "  ${GREEN}${iface}:${NC} 无 IPv4 地址"
        fi
    done
    echo ""
}
# 主函数
main() {
    echo -e "==================== 服务器硬件信息报告 ===================="
    echo -e "日期: $current_date"
    echo -e "主机名: $hostname"
    echo -e "============================================================"
    get_pm_info
    get_cpu
    get_mem
    get_disk
    get_gpu
    get_network
}
# 执行主函数并将输出保存到文件
main | tee /tmp/server_info_$(date +%F_%H-%M-%S).txt