;;; use-treemacs.el --- Treemacs 项目目录树配置 -*- lexical-binding: t; -*-

(use-package treemacs
  :ensure t
  :defer t
  :init
  (when (boundp 'winum-keymap)
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  ;; 启动完成后自动打开 treemacs（emacs-startup-hook 在文件加载完毕后执行，避免分屏）
  (add-hook 'emacs-startup-hook (lambda () (treemacs)))
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
        treemacs-width-is-initially-locked       nil)

  ;; 鼠标拖拽：像素级精确调整窗口大小
  (setq window-resize-pixelwise t)

  ;; 模式启用
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode 'always)
  (treemacs-hide-gitignored-files-mode t)

  ;; Git 集成
  (let ((has-git (executable-find "git"))
        (has-python (executable-find "python3")))
    (cond
     ((and has-git has-python)
      (treemacs-git-mode 'deferred))
     (has-git
      (treemacs-git-mode 'simple)))))

(use-package treemacs-icons-dired
  :ensure t
  :hook (dired-mode . treemacs-icons-dired-mode))

(use-package treemacs-magit
  :ensure t
  :after (treemacs magit))

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1))

(use-package treemacs-projectile
  :ensure t
  :after (treemacs projectile)
  :config
  ;; 打开文件时自动将当前 projectile 项目加入 Treemacs workspace
  (defun my/treemacs-auto-add-project ()
    "如果当前 buffer 属于 projectile 项目且该项目不在 Treemacs 中，自动添加。"
    (when-let ((root (ignore-errors (projectile-project-root))))
      (let ((canonical (treemacs-canonical-path root)))
        (unless (or (treemacs-is-path canonical :in-workspace)
                    (string-equal canonical (treemacs-canonical-path user-emacs-directory)))
          (treemacs-add-project-to-workspace canonical)))))
  (add-hook 'find-file-hook #'my/treemacs-auto-add-project))

(provide 'use-treemacs)
;;; use-treemacs.el ends here