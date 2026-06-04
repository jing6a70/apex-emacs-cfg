


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
        lsp-auto-guess-root nil
        lsp-enable-snippet t
        lsp-modeline-diagnostics-enable t
        lsp-idle-delay 0.5
        lsp-completion-provider :capf
        lsp-use-plists t)  ; 推荐开启

  ;; 全局性能调优
  (setq read-process-output-max (* 1024 1024)))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :init
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-childframe t     ; Emacs 29+
        lsp-ui-doc-use-webkit nil
        lsp-ui-doc-delay 0.3
        lsp-ui-doc-include-signature t
        lsp-ui-doc-position 'bottom
        lsp-eldoc-enable-hover nil
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
  :after (lsp-mode treemacs)   ; 确保依赖加载后
  :commands (lsp-treemacs-errors-list
             lsp-treemacs-symbols
             lsp-treemacs-call-hierarchy)
  :hook (lsp-mode . lsp-treemacs-sync-mode)  ; 自动启用项目同步
  :config
  ;; 可选绑定快捷键（推荐）
  (define-key lsp-mode-map (kbd "M-9") #'lsp-treemacs-errors-list)
  (define-key lsp-mode-map (kbd "C-c s") #'lsp-treemacs-symbols))

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

;; C/C++ clangd
(setq lsp-clients-clangd-executable "clangd")


(provide 'use-lspmode)



