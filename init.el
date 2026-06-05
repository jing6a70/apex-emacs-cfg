;; init.el
;; ┌─┐┌─┐┬─┐┌─┐┌─┐  ┌─┐┬ ┬┌─┐┬  ┌─┐┌─┐
;; ├─┘├┤ ├┬┘├┤ ├┤   ├─┤│ │├─┤│  ├┤ └─┐
;; ┴  └─┘┴└─└  └─┘  ┴ ┴└─┘┴ ┴┴─┘└─┘└─┘
;;       A P E X     E M A C S
;;
;; Commentary: emacs的初始化文件 Initialization emacs' file
;; 在Emacs打开时候会自动加载该配置文件.


;; 启动时临时提高 GC 阈值加速启动，after-init 后恢复
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook
          (lambda () (setq gc-cons-threshold 800000)))

;; 抑制 native-comp 编译警告（docstring 宽度等，不影响功能）
(setq native-comp-async-report-warnings-errors nil)
(setq byte-compile-docstring-max-column 120)

;; 设置 关键变量{ user-emacs-directory } => ~/.emacs.d/
(if (boundp 'load-file-name)
    (setq user-emacs-directory (file-name-as-directory (file-name-directory load-file-name)))
  (setq user-emacs-directory (file-name-as-directory "~/.emacs.d/")))

;; 定义{ core-dir }变量 ./core 目录完整路径
(defvar core-dir (expand-file-name "core" user-emacs-directory))

;; 加载 Emacs编辑器基础配置
(load (expand-file-name "use-common-emacs.el" core-dir) t t)

;; 加载 自定义{ package-archives }包源配置 C-h v : package-archives 查询详细
(load (expand-file-name "package-sources.el" core-dir) t t)
(package-initialize) ;; 初始化包管理器

;; 加载 custom-config 配置
(load (expand-file-name "custom-config.el" core-dir) t t)

;; 加载 主题配置
(load (expand-file-name "use-theme.el" core-dir) t t)

(use-package gptel
  :ensure t
  :config
  ;; 1. 将 DeepSeek 注册为 gptel 的后端 (Backend)
  (gptel-make-openai "DeepSeek"
    :host "api.deepseek.com"
    :endpoint "/v1/chat/completions"
    :stream t
    :key (lambda () (getenv "DEEPSEEK_API_KEY")) ; 推荐从系统环境变量中读取，更安全
    :models '(deepseek-chat deepseek-reasoning))  ; 支持标准对话模型与深度思考(R1)模型

  ;; 2. 设置默认使用 DeepSeek 的标准对话模型
  (setq gptel-backend (gptel-get-backend "DeepSeek")
        gptel-model 'deepseek-chat))


;; 加载各USE配置
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))
(defvar my/local-modules
  '(use-vertico        ;; Emacs 系统补全框架
    ;; use-corfu       ;; 代码补全基础 (Corfu, 替代 company-mode) — 暂不启用
    use-lspmode        ;; 语言协议服务器 language server protocol
    use-treemacs       ;; 左侧边项目树USE包
    use-magit          ;; Git管理工具USE包
    use-orgmode        ;; org文档编写USE包
    use-yasnippet      ;; 代码片段支持USE — Vertico 模糊搜索
    use-hungry-delete  ;; 快速删除多余空格USE
    use-undo-tree      ;; C-x u可视化树
    use-which-key      ;; 按键提示USE包
    ))
(dolist (module my/local-modules)
  (require module nil 'noerror))

;; 自定义功能与键绑定
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))
(require 'init-func-def)
(require 'init-func-key)


