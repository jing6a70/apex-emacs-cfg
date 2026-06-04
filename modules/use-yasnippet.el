;; 配置yasnippet插件, 为Emacs提供代码片段支持
;; Configure the yasnippet plug-in to provide snippet support for Emacs
(use-package yasnippet
  :ensure t
  :config
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
  (yas-global-mode t))


(provide 'use-yasnippet)
