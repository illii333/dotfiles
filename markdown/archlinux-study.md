---
theme:
  override:
    footer:
      style: template
      left: '_笔者:_<span class="noice">自由人</span>'
      center:
        #image: doge.png
      right: "{current_slide} / {total_slides} _页脚_"
    palette:
      classes:
        noice:
          foreground: ffeb3b
---

Arch Linux 完全指南
===

# 第 1 章：系统安装

安装前准备：网络与镜像
---
## 问题
安装 Arch Linux 前需要做哪些准备工作？

<!-- pause -->

## 答案
**1. 设置字体（避免乱码）：**
```bash
setfont ter-132b
```

**2. 连接网络（iwctl）：**
```bash
iwctl
station wlan0 get-networks
station wlan0 connect 你的WiFi名称
exit
ping archlinux.org  # 验证连通
```

**3. 同步时间 & 换镜像源：**
```bash
timedatectl set-ntp true
vim /etc/pacman.d/mirrorlist
# 添加：Server = http://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
pacman -Sy archlinux-keyring
```

<!-- end_slide -->

磁盘分区
---
## 问题
如何对 NVMe 硬盘进行分区？

<!-- pause -->

## 答案

<!-- column_layout: [1, 1] -->

<!-- column: 0 -->
### 查看磁盘
```bash
lsblk
cfdisk /dev/nvme0n1
```

### 分区方案
| 分区 | 大小 | 用途 |
|------|------|------|
| p1 | 512M+ | EFI 启动 |
| p2 | 8G+ | Swap |
| p3 | 剩余 | 根分区 |

<!-- column: 1 -->
### 格式化
```bash
mkfs.fat -F 32 /dev/nvme0n1p1
mkswap /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3
```

### 挂载
```bash
mount /dev/nvme0n1p3 /mnt
swapon /dev/nvme0n1p2
mount --mkdir /dev/nvme0n1p1 /mnt/boot
```

<!-- reset_layout -->

<!-- end_slide -->

基础系统安装
---
## 问题
如何安装基础系统？

<!-- pause -->

## 答案
```bash
pacman -Sy
pacstrap -K /mnt base linux linux-firmware \
  helix networkmanager base-devel openssh

genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```

| 包 | 用途 |
|------|------|
| base | 基础系统 |
| linux | 内核 |
| linux-firmware | 硬件固件 |
| networkmanager | 网络管理 |
| base-devel | 编译工具链 |
| openssh | 远程连接 |

<!-- end_slide -->

系统配置
---
## 问题
chroot 后需要配置什么？

<!-- pause -->

## 答案

<!-- column_layout: [1, 1] -->

<!-- column: 0 -->
### 时区 & 本地化
```bash
ln -sf /usr/share/zoneinfo/
  Asia/Shanghai /etc/localtime
hwclock --systohc
date
```

```bash
helix /etc/locale.gen
# 取消注释 en_US.UTF-8
locale-gen
helix /etc/locale.conf
# LANG=en_US.UTF-8
```

<!-- column: 1 -->
### 主机名 & 用户
```bash
helix /etc/hostname
# 写入主机名
passwd         # root密码
useradd -m aaa # 创建用户
passwd aaa     # 用户密码
helix /etc/sudoers
# aaa ALL=(ALL) NOPASSWD: ALL
```

<!-- reset_layout -->

<!-- end_slide -->

引导安装与收尾
---
## 问题
如何安装 GRUB 引导并完成安装？

<!-- pause -->

## 答案
```bash
# 启动服务
systemctl enable NetworkManager
systemctl enable sshd

# 安装引导
pacman -S grub efibootmgr
grub-install --target=x86_64-efi \
  --efi-directory=/boot \
  --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# 退出重启
exit
umount -R /mnt
reboot
```

> 重启后拔掉安装介质，进入新系统

<!-- end_slide -->

---

Arch Linux 完全指南
===

# 第 2 章：桌面环境

niri + DMS 安装
---
## 问题
如何安装 niri Wayland 桌面和 DMS 组件？

<!-- pause -->

## 答案
```bash
sudo pacman -Syu niri xwayland-satellite \
  xdg-desktop-portal-gnome xdg-desktop-portal-gtk \
  alacritty

paru -S dms-shell-bin matugen wl-clipboard \
  cliphist cava qt6-multimedia-ffmpeg

systemctl --user add-wants niri.service dms
```

| 包 | 用途 |
|------|------|
| niri | Wayland 平铺合成器 |
| dms-shell-bin | DMS 桌面组件 |
| xwayland-satellite | X11 兼容 |
| alacritty | 终端模拟器 |

> 参考：[niri 安装文档](https://docs.akass.cn/niri/Getting-Started.html)

<!-- end_slide -->

NVIDIA 驱动
---
## 问题
如何安装和配置 NVIDIA 显卡驱动？

<!-- pause -->

## 答案
```bash
# 安装内核头文件
sudo pacman -S --needed linux-headers linux-lts-headers

# 卸载开源驱动，安装闭源驱动
sudo pacman -Rns nvidia-open-dkms --noconfirm
sudo pacman -S --needed nvidia-dkms \
  nvidia-utils nvidia-settings

# CUDA 支持
sudo pacman -S --needed cuda cudnn
```

**CUDA 环境变量：**
```bash
sudo helix /etc/environment.d/dcuda.conf
```
```
CUDA_HOME=/opt/cuda
LD_LIBRARY_PATH=/opt/cuda/lib64:/opt/cuda/lib64/stubs
PATH=/opt/cuda/bin:${PATH}
```

<!-- end_slide -->

字体与输入法
---
## 问题
如何安装中文字体和输入法？

<!-- pause -->

## 答案

<!-- column_layout: [1, 1] -->

<!-- column: 0 -->
### 字体
```bash
sudo pacman -S wqy-zenhei \
  ttf-jetbrains-mono \
  wqy-microhei \
  noto-fonts-emoji
```

### 输入法
```bash
sudo pacman -S fcitx5-im \
  fcitx5-chinese-addons \
  fcitx5-rime
```

<!-- column: 1 -->
### 环境变量
`/etc/environment`：
```
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=ibus
fcitx5_dont_use_gsettings=1
```

<!-- reset_layout -->

<!-- end_slide -->

数据盘挂载
---
## 问题
如何自动挂载额外数据盘？

<!-- pause -->

## 答案
```bash
sudo mkdir -p /mnt/Study /mnt/Game
sudo helix /etc/fstab
```

添加：
```
LABEL=Study  /mnt/Study  ext4  defaults  0  2
LABEL=Game   /mnt/Game   ext4  defaults  0  2
```

```bash
sudo systemctl daemon-reload
sudo mount -a
sudo chmod -R 775 /mnt/Study /mnt/Game
df -h   # 验证
```

> 分区时需要先给分区打上对应 LABEL

<!-- end_slide -->

---

Arch Linux 完全指南
===

# 第 3 章：配置与软件

配置文件索引
---
## 问题
各软件的配置文件在哪里？

<!-- pause -->

## 答案
| 软件 | 配置路径 |
|------|----------|
| niri | `~/.config/niri/config.kdl` |
| nushell | `~/.config/nushell/config.nu` |
| helix | `~/.config/helix/config.toml` |
| wezterm | `~/.config/wezterm/wezterm.lua` |
| alacritty | `~/.config/alacritty/alacritty.toml` |
| yazi | `~/.config/yazi/yazi.toml` |
| zellij | `~/.config/zellij/config.kdl` |

> 点击路径可跳转打开配置文件

<!-- end_slide -->

开发工具安装
---
## 问题
Rust 开发环境如何安装？

<!-- pause -->

## 答案

<!-- column_layout: [1, 1] -->

<!-- column: 0 -->
### 终端工具
```bash
sudo pacman -S yazi nushell \
  helix alacritty zellij

sudo pacman -S zed termusic
```

### AUR 工具
```bash
sudo pacman -S paru
paru -S wezterm mcat tdf \
  bookokrat sniffnet
```

<!-- column: 1 -->
### Rust 工具链
```bash
# 通过 rustup 安装
curl --proto '=https' --tlsv1.2 \
  https://sh.rustup.rs -sSf | sh
```

| 工具 | 用途 |
|------|------|
| helix/zed | 编辑器 |
| yazi | 文件管理器 |
| zellij | 终端复用器 |
| nushell | Shell |

<!-- reset_layout -->

<!-- end_slide -->

常用软件
---
## 问题
Arch 上安装哪些常用软件？

<!-- pause -->

## 答案

<!-- column_layout: [1, 1] -->

<!-- column: 0 -->
### 日常应用
```bash
sudo pacman -S firefox thunderbird \
  mpv oculante logseq flatpak

flatpak install flathub \
  org.pegasus_frontend.Pegasus
```

### 创作工具
```bash
sudo pacman -S blender
```

<!-- column: 1 -->
### AI 工具
| 工具 | 说明 |
|------|------|
| ComfyUI | AI 绘图工作流 |
| pyvideotrans | 视频翻译配音 |
| Qwen3-TTS | 通义语音合成 |

- [ComfyUI](https://github.com/comfyanonymous/ComfyUI)
- [pyvideotrans](https://pyvideotrans.com/deply)
- [Qwen3-TTS](https://github.com/QwenLM/qwen3-tts)

<!-- reset_layout -->

<!-- end_slide -->

---

结束
===

> 涵盖 Arch 安装 → 桌面环境 → 开发配置完整流程
> 每步命令可直接复制执行
