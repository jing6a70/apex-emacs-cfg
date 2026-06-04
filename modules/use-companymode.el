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

  ;; 优先使用 capf（lsp-mode 会通过它提供补全）
  (add-to-list 'company-backends '(company-capf :with company-yasnippet))

  ;; 可选：其他通用 backend
  ;; (add-to-list 'company-backends 'company-files)
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
