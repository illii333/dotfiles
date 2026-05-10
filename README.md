# dotfiles

## 目录

| 目录 | 软件 |
|------|------|
| `alacritty/` | 终端模拟器 |
| `wezterm/` | 终端模拟器 |
| `nushell/` | Shell |
| `helix/` | 编辑器 |
| `zellij/` | 终端复用器 |
| `yazi/` | 文件管理器 |
| `niri/` | Wayland 合成器 |
| `bookokrat/` | 电子书管理 |
| `mdfried/` | Markdown 阅读器 |
| `termusic/` | 终端音乐播放器 |

## Rust 终端工具推荐（待安装）

| 工具 | 替代 | 用途 |
|------|------|------|
| bat | cat | 语法高亮 + 行号 |
| eza | ls | 图标 + git 状态 |
| fd | find | 快速文件搜索 |
| ripgrep | grep | 极速文本搜索 |
| zoxide | cd | 智能目录跳转 |
| delta | git diff | diff 美化 |
| gitui | lazygit | 终端 git 客户端 |
| tealdeer | tldr | 命令示例速查 |
| dust | du | 磁盘占用分析 |
| starship | - | shell prompt 美化 |

## 推送方法

```bash
cd ~/dotfiles
git add -A
git commit -m "更新说明"
git push
```

## 更新单个配置

以 niri 为例：

```bash
cp ~/.config/niri/config.kdl ~/dotfiles/niri/
cd ~/dotfiles
git add -A
git commit -m "更新 niri 配置"
git push
```
