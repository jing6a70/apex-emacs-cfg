


;; ~/.emacs.d/modules/use-lsp.el

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook
  ((python-mode c-mode c++-mode go-mode java-mode js-mode web-mode vue-mode html-mode) . lsp-deferred)
  (lsp-mode . lsp-enable-which-key-integration)
  :init
  ;; 性能优化（建议全局设置或在这里）
  (setq lsp-keep-workspace-alive nil
        lsp-enable-indentation t
        lsp-enable-on-type-formatting t
        lsp-auto-guess-root t
        lsp-enable-snippet t  ; yasnippet 已恢复，开启 LSP snippet 支持
        lsp-modeline-diagnostics-enable t
        lsp-idle-delay 0.5  ; 诊断 debounce 0.5s
        lsp-completion-provider :capf
        lsp-use-plists nil)  ; 暂时关闭 plist，避免 hash-table-p 兼容错误

  ;; 全局性能调优
  (setq read-process-output-max (* 1024 1024)))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :init
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-childframe t     ; Emacs 29+
        lsp-ui-doc-use-webkit nil
        lsp-ui-doc-delay 0.3
        lsp-ui-doc-include-signature t
        lsp-ui-doc-position 'bottom
        lsp-eldoc-enable-hover nil
        lsp-ui-imenu-window-width 30
        lsp-ui-imenu-window-fix-width t
        lsp-ui-imenu-auto-refresh t
        lsp-ui-imenu-colors '("#61afef" "#98c379")  ; 柔和蓝 + 绿

        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-hover t
        lsp-ui-sideline-show-code-actions t
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-ignore-duplicate t
        lsp-headerline-breadcrumb-enable t)
  :config
  (setq lsp-ui-flycheck-enable nil))


;; vertico lsp
(use-package consult-lsp
  :ensure t
  :after lsp-mode)

(use-package lsp-treemacs
  :ensure t
  :after lsp-mode  ; treemacs 按需自动加载
  :commands (lsp-treemacs-errors-list
             lsp-treemacs-symbols
             lsp-treemacs-call-hierarchy)
  :hook (lsp-mode . lsp-treemacs-sync-mode)  ; 自动启用项目同步（切换文件自动刷新 symbols）
  :init
  (add-hook 'lsp-after-initialize-hook
            (lambda ()
              (run-with-idle-timer 2 nil #'lsp-treemacs-symbols)
              (run-with-idle-timer 2.5 nil #'lsp-ui-imenu)))  ; 启动后自动显示面板
  :config
  (define-key lsp-mode-map (kbd "M-9") #'lsp-treemacs-errors-list)
  (define-key lsp-mode-map (kbd "C-c s") #'lsp-treemacs-symbols)
  (define-key lsp-mode-map (kbd "C-c i") #'lsp-ui-imenu)
  ;; lsp-ui-imenu: 双击跳转 + 切 buffer 自动刷新
  (with-eval-after-load 'lsp-ui-imenu
    (define-key lsp-ui-imenu-mode-map (kbd "<double-mouse-1>") #'lsp-ui-imenu--visit))
  (defvar my/lsp-imenu-refresh-timer nil)
  (defun my/lsp-imenu-auto ()
    (when (timerp my/lsp-imenu-refresh-timer)
      (cancel-timer my/lsp-imenu-refresh-timer))
    (setq my/lsp-imenu-refresh-timer
          (run-with-timer 0.3 nil
                          (lambda ()
                            (when (bound-and-true-p lsp-mode)
                              (ignore-errors (lsp-ui-imenu)))))))
  (advice-add 'switch-to-buffer :after (lambda (&rest _) (my/lsp-imenu-auto)))
  (advice-add 'other-window    :after (lambda (&rest _) (my/lsp-imenu-auto))))

;; 加载 特定模式的LSP
;; Python
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred))))

;; Java
(use-package lsp-java
  :ensure t
  :hook (java-mode . lsp-deferred))

;; C/C++ clangd — 性能优化
(setq lsp-clients-clangd-executable "clangd"
      lsp-clients-clangd-args '("-j=4"
                                "--background-index"
                                "--pch-storage=memory"
                                "--header-insertion=never"))


(provide 'use-lspmode)



