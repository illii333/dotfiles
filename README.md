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
