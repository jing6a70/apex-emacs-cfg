;; ~/.emacs.d/modules/use-corfu.el
;; Corfu + Cape: 现代 Emacs 代码补全栈
;; 渐进调试：先只用 Corfu+LSP，确认基础正常后再加 Cape

;;; Corfu: buffer 内补全弹窗
(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.3)
  (corfu-auto-prefix 1)
  :init
  (global-corfu-mode 1))

;;; Cape: dabbrev(fallback) + yasnippet(延迟)
(use-package cape
  :ensure t
  :after corfu
  :config
  ;; dabbrev — 立即生效的基础 fallback
  (defun my/cape-dabbrev-setup ()
    (add-hook 'completion-at-point-functions #'cape-dabbrev 90 t))
  (dolist (hook '(prog-mode-hook text-mode-hook org-mode-hook))
    (add-hook hook #'my/cape-dabbrev-setup))
  ;; yasnippet — 延迟到 yasnippet 加载后（加载顺序靠后）
  (with-eval-after-load 'yasnippet
    (defun my/cape-yasnippet-setup ()
      (add-hook 'completion-at-point-functions #'cape-yasnippet 50 t))
    (dolist (hook '(prog-mode-hook text-mode-hook org-mode-hook))
      (add-hook hook #'my/cape-yasnippet-setup))))

(provide 'use-corfu)
