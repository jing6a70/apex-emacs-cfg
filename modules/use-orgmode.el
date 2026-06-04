;; moduls/setup-orgmode.el


;; Emacs 29 自带 Org Mode 配置
;; 核心功能：基础样式、TODO 关键字、Babel 多语言支持、Shell 环境配置
;; 添加Latex显示
;; 添加Img显示 jpg png svg...


(use-package org
  :pin gnu  ; 使用Emacs 29 自带的 Org Mode
  :defer t  ; 懒加载，仅打开 Org 文件时加载，提升启动速度
  :config
  ;; Org 基础显示配置
  (setq org-startup-indented t  ; 启动时缩进显示
        org-todo-keywords '((sequence "TODO" "DOING" "DONE"))  ; TODO 状态流转
        org-todo-keyword-faces '(("DOING" . "blue"))  ; DOING 状态标为蓝色
        org-src-fontify-natively t)  ; 代码块原生语法高亮

  ;; Org Babel 多语言支持
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)       ; 启用 Python 代码块执行
     (shell . t)        ; 启用 Shell/Bash 代码块执行
     (js . t)           ; 启用 JavaScript 代码块执行
     (emacs-lisp . t))) ; 启用 Emacs Lisp 代码块执行
;; 取消代码块执行前的确认提示
(setq org-confirm-babel-evaluate
      (lambda (lang body)
        (not (member lang '("python" "shell" "js")))))

;; Shell 环境配置
(setenv "SUDO_ASKPASS" (expand-file-name "sh/emacs-askpass.sh" user-emacs-directory))
(setq org-babel-shell-command "bash -i") ;; 交互模式执行 Shell 命令

;; latex
(setq org-latex-preview-default-process 'dvisvgm)
;; latex外观微调（当前主题颜色匹配 + 大小适配）
(setq org-latex-preview-appearance-options
      '(:foreground default          ; 跟随 Emacs 主题前景色
                    :background "Transparent"    ; 透明背景最自然
                    :scale 1.6                   ; 推荐范围 1.4~2.0，根据屏幕DPI调整
                    :zoom 1.2
                    :page-width 0.85             ; 公式宽度占页面比例
                    :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))

;; 打开文件时自动预览所有 LaTeX 片段
;; (setq org-startup-with-latex-preview t)

;; 自动渲染模式(Emacs 29+)
(when (fboundp 'org-latex-preview-auto-mode)
  (add-hook 'org-mode-hook #'org-latex-preview-auto-mode))

(setq org-startup-with-inline-images t          ;; 打开文件时自动显示图片
      org-display-inline-images t               ;; 允许内联显示
      org-redisplay-inline-images t             ;; 改变大小时自动重绘
      org-image-actual-width '(300))            ;; 默认显示宽度pix,设 nil 表示原尺寸

(define-key org-mode-map (kbd "C-c C-x C-v") #'org-redisplay-inline-images))

;; 手动加载 Org 模块（确保 Babel 等功能生效，兼容懒加载）
(provide 'use-orgmode)


