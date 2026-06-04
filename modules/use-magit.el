;; ~/.emacs.d/modules/use-magit.el

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)        ; 全局快捷键：打开 Magit status 缓冲区
         ("C-x M-g" . magit-dispatch))   ; 弹出 Magit 所有命令菜单
  :config
  ;; 推荐设置（提升性能和体验）
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)  ; 全窗口显示 status
  (setq magit-diff-refine-hunk 'all)     ; diff 高亮更细粒度（所有单词级变化）
  (setq magit-save-repository-buffers 'dontask)  ; 保存相关缓冲区时不询问
  (setq magit-revision-show-gravatars t) ; 显示作者头像（可选，美观）
  (setq magit-refresh-status-buffer nil) ; 关闭自动刷新，提升大型仓库性能（Magit 手册推荐）
  
  ;; 可选优化：避免 GPG 签名报错（无 GPG 环境必备）
  (setq magit-commit-signoff nil)
  (setq magit-gpg-sign-commit nil)
  
  ;; 可选优化：关闭 Magit 后恢复原窗口布局
  (setq magit-bury-buffer-function #'magit-restore-window-configuration-and-bury-buffer)

  ;; 联动 diff-hl：更好的 diff 高亮可视化
  (use-package diff-hl
    :ensure t
    :hook ((magit-pre-refresh . diff-hl-magit-pre-refresh)
           (magit-post-refresh . diff-hl-magit-post-refresh))
    :config
    (global-diff-hl-mode)
    (diff-hl-flydiff-mode t)
    (setq diff-hl-show-staged-changes t)
    (when (not (display-graphic-p))
      (setq diff-hl-side 'right)
      (diff-hl-margin-mode))))

(provide 'use-magit)
