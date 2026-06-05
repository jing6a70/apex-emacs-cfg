;; 配置yasnippet插件, 为Emacs提供代码片段支持
;; Configure the yasnippet plug-in to provide snippet support for Emacs
(use-package yasnippet
  :ensure t
  :bind
  ("C-c y" . yas-insert-snippet)  ; Vertico minibuffer 模糊搜索代码片段
  :config
  (add-to-list 'yas-snippet-dirs (expand-file-name "snippets" user-emacs-directory))
  (yas-global-mode t)
  (yas-reload-all))


(provide 'use-yasnippet)
