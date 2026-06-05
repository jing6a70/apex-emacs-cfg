;;; Code:
;;  进行简约配置: 关闭菜单栏, 工具栏, 滑动条
;;  Choose a minimalist configuration: close memubar, toolbar, scrollbar.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; 禁止开机启动界面, 设置默认光标类型
;; inhibit splash screen and set default cursor type
(setq inhibit-splash-screen t)
(setq-default cursor-type 'bar)


;; 关闭自动创建备份文件的功能
;;  Disables the generation of backup files
(setq make-backup-files nil)

;; 打开Emacs行号 Enable line numbers mode.
(global-display-line-numbers-mode t)

;; 自动补全括号 Bracket completion
(electric-pair-mode t)
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)


;; 设置4个空格表示的tab的格数
;;  Set the number of tabs represented by 4 spaces
(setq-default indent-tabs-mode nil) ;; 设置默认tab键为插入空格 Change tab key to insert space
(setq c-basic-offset 4)             ;; C/C++语言空格数为4     C/C++ indent space of 4
(setq c-default-style "linux")      ;; 设置样式为'linux'      Set style to "linux"
(setq-default tab-width 4)          ;; 设置默认tab键的宽度     Set width of default tab key

;; docstring 长度设置,防止lsp-mode报警
(setq byte-compile-docstring-max-column 120)

;; 禁用 GUI 对话框，所有交互走 minibuffer（避免弹出系统文件选择器）
(setq use-dialog-box nil)

;; 命令行打开文件时不保留 *scratch* buffer（nil: 有文件参数时只打开文件）
(setq initial-buffer-choice nil)
