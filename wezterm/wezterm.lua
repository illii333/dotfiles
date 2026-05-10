local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder and wezterm.config_builder() or {}

config.color_scheme = "Dracula (Official)"
config.font_size = 14
config.font = wezterm.font_with_fallback({ "JetBrains Mono", "WenQuanYi Zen Hei" })
config.window_decorations = "NONE"
config.default_cursor_style = "BlinkingBar"
config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 30000
config.window_padding = { top = 10, bottom = -10 }
config.tab_bar_at_bottom = false
config.window_close_confirmation = "NeverPrompt"

config.window_background_opacity = 0.8
config.default_prog = { "nu" }

config.key_tables = {
    resize_pane = {
        { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
        { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
        { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
        { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
        { key = "Escape", action = "PopKeyTable" },
    },
}

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1500 }

config.keys = {
    { key = "L", mods = "CTRL", action = act.DisableDefaultAssignment },
    { key = "H", mods = "CTRL", action = act.DisableDefaultAssignment },
    { key = "D", mods = "CTRL", action = "ShowDebugOverlay" },

    { key = "w", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "z", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },

    { key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
    { key = "b", mods = "LEADER", action = act.PaneSelect },
    { key = " ", mods = "LEADER", action = act.TogglePaneZoomState },
    { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
}

return config

-- - 复制到剪贴板和主选区，滚动到底部，关闭。执行多个嵌套操作
-- - 弹出当前键表
-- - 滚动到底部，关闭。执行多个嵌套操作
-- - 编辑：激活命令面板。显示命令面板模态框 `Shift-Ctrl-P`
-- - 编辑：激活复制模式。进入仅使用键盘选择文本的免鼠标复制模式 `Shift-Ctrl-X`
-- - 编辑：清除滚动回滚。清除已滚出当前窗格视口的任何文本 `Shift-Ctrl-K`
-- - 编辑：清除键表堆栈。移除堆栈中的所有条目
-- - 编辑：清除滚动回滚和视口。移除屏幕和滚动回滚中的所有
-- - 编辑：复制到剪贴板。将文本复制到剪贴板 `Shift-Ctrl-C`
-- - 编辑：复制到主选区。将文本复制到主选区 `Ctrl-Insert`
-- - 编辑：进入Emoji/字符选择模式。激活当前窗格的字符选择UI `Shift-Ctrl-U`
-- - 编辑：进入快速选择模式。激活当前窗格的快速选择UI `Shift-Ctrl-Space`
-- - 编辑：从剪贴板粘贴。将文本从剪贴板粘贴 `Shift-Ctrl-V`
-- - 编辑：粘贴主选区。将主选区粘贴 `Shift-Insert`
-- - 编辑：搜索窗格输出。进入当前窗格的搜索模式UI `Shift-Ctrl-F`
-- - 帮助：在GitHub上讨论。访问wezterm的GitHub讨论区
-- - 帮助：文档。访问wezterm文档网站
-- - 帮助：在GitHub上搜索或报告问题。访问wezterm的GitHub问题页
-- - 帮助：显示调试覆盖层。激活调试覆盖层和Lua REPL `Shift-Ctrl-L`
-- - Shell：关闭当前窗格。关闭当前窗格，终止其中运行的进程
-- - Shell：关闭当前标签页。关闭当前标签页，终止所有进程 `Shift-Ctrl-W`
-- - Shell：新建标签页。在当前域中创建同一域的新标签页 `Shift-Ctrl-T`
-- - Shell：新建标签页 (域名SSH::host)
-- - Shell：新建标签页 (域名SSH:machine:/host)
-- - Shell：新建标签页 (本地域名)
-- - Shell：新建窗口。将默认程序启动到新窗口 `Shift-Ctrl-N`
-- - Shell：打开鼠标光标处的链接。如果鼠标光标下没有链接，则无效。
-- - Shell：重置当前窗格中的终端仿真状态
-- - Shell：显示启动器。显示启动菜单
-- - Shell：水平分割（左/右）。将当前窗格水平分割成两个窗格 `Shift-Alt-Ctrl-%`
-- - Shell：垂直分割（上/下）。将当前窗格垂直分割成两个窗格，按 `Shift-Alt-Ctrl-"`
-- - Shell | 附加：附加域名SSHMUX:主机
-- - Shell | 附加：附加域名SSHMUX:machine:/host
