;;; use-treemacs.el --- Treemacs 项目目录树配置 -*- lexical-binding: t; -*-

(use-package treemacs
  :ensure t
  :init
  (when (boundp 'winum-keymap)
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :bind
  ((:map global-map
         ("M-0"       . treemacs-select-window)
         ("C-x t 1"   . treemacs-delete-other-windows)
         ("C-x t t"   . treemacs)
         ("C-x t B"   . treemacs-bookmark)
         ("C-x t C-t" . treemacs-find-file)
         ("C-x t M-t" . treemacs-find-tag))
   (:map treemacs-mode-map
         ("C-x }" . treemacs-increase-width)
         ("C-x {" . treemacs-decrease-width)))
  :config
  (setq treemacs-collapse-dirs                   3
        treemacs-deferred-git-apply-delay        0.5
        treemacs-directory-name-transformer      #'identity
        treemacs-display-in-side-window          t
        treemacs-eldoc-display                   'simple
        treemacs-file-event-delay                2000
        treemacs-file-follow-delay               0.2
        treemacs-file-name-transformer           #'identity
        treemacs-follow-after-init               t
        treemacs-expand-after-init               t
        treemacs-goto-tag-strategy               'refetch-index
        treemacs-indentation                     2
        treemacs-indentation-string              " "
        treemacs-is-never-other-window           nil
        treemacs-max-git-entries                 5000
        treemacs-missing-project-action          'ask
        treemacs-move-forward-on-expand          nil
        treemacs-no-png-images                   nil
        treemacs-no-delete-other-windows         t
        treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
        treemacs-position                        'left
        treemacs-recenter-distance               0.1
        treemacs-recenter-after-file-follow      nil
        treemacs-recenter-after-tag-follow       nil
        treemacs-recenter-after-project-jump     'always
        treemacs-recenter-after-project-expand   'on-distance
        treemacs-show-cursor                     nil
        treemacs-show-hidden-files               t
        treemacs-silent-refresh                  nil
        treemacs-sorting                         'alphabetic-asc
        treemacs-select-when-already-in-treemacs 'stay
        treemacs-space-between-root-nodes        t
        treemacs-tag-follow-delay                1.5
        treemacs-width                           35
        treemacs-width-increment                 5
        treemacs-width-is-initially-locked       nil)  ; 允许鼠标拖拽调整宽度

  ;; 鼠标拖拽：像素级精确调整窗口大小
  (setq window-resize-pixelwise t)

  ;; HiDPI 图标 — 当前 Emacs 无 imagemagick，resize-icons 无效且导致模糊
  ;; (treemacs-resize-icons 44)

  ;; 模式启用
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode 'always)
  (treemacs-hide-gitignored-files-mode t)

  ;; Git 集成
  (pcase (cons (not (null (executable-find "git")))
               (not (null (executable-find "python3"))))
    (`(t . t) (treemacs-git-mode 'deferred))
    (`(t . _) (treemacs-git-mode 'simple)))

  ;; 启动时自动打开
  (treemacs))

(use-package treemacs-icons-dired
  :ensure t
  :hook (dired-mode . treemacs-icons-dired-mode))

(use-package treemacs-magit
  :ensure t
  :after (treemacs magit))

(provide 'use-treemacs)
;;; use-treemacs.el ends here