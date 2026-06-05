;; ~/.emacs.d/modules/use-company.el

(use-package company
  :ensure t
  :diminish " Com."
  :hook (after-init . global-company-mode)
  :bind
  ((:map company-mode-map ("M-/" . company-complete))
   (:map company-active-map ("M-/" . company-other-backend))
   (:map company-active-map ("C-n" . company-select-next))
   (:map company-active-map ("C-p" . company-select-previous)))
  :config
  ;; 基础设置
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.1
        company-echo-delay 0
        company-show-numbers t
        company-tooltip-limit 20
        company-tooltip-offset-display 'scrollbar
        company-require-match nil
        company-dabbrev-ignore-case t
        company-dabbrev-downcase nil
        company-dabbrev-code-everywhere t
        company-dabbrev-code-other-buffers 'all
        company-dabbrev-other-buffers 'all
        company-begin-commands '(self-insert-command))

  ;; 合并 capf + yasnippet 为一个 backend 组，两者结果同时显示
  ;; :separate 让 LSP补全和代码模板在菜单中分行显示、互不干扰
  ;; 先移除默认的 company-capf，避免重复
  (setq company-backends (delq 'company-capf company-backends))
  (add-to-list 'company-backends '(company-capf :separate company-yasnippet))

  ;; lsp-mode 的 lsp-completion-mode 会通过 cl-adjoin 把单独的
  ;; company-capf 插回 buffer-local company-backends 头部，破坏上面的
  ;; group 配置。用 advice 在 lsp-completion-mode 执行后修正。
  (defun my/company-backends-after-lsp (&rest _)
    "Fix buffer-local company-backends after lsp-completion-mode."
    (when (bound-and-true-p company-mode)
      (setq-local company-backends
                  (cons '(company-capf :separate company-yasnippet)
                        (remove 'company-capf company-backends)))))

  (with-eval-after-load 'lsp-completion
    (advice-add 'lsp-completion-mode :after #'my/company-backends-after-lsp))
  )

(use-package company-quickhelp
  :ensure t
  :hook (company-mode . company-quickhelp-mode)  ; 改成跟 company-mode 一起启用
  :init
  (setq company-quickhelp-delay 0.3))

(use-package company-prescient
  :ensure t
  :after company
  :init
  (company-prescient-mode 1))

(provide 'use-companymode)
