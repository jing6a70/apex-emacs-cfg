
(use-package ox-hugo
  :ensure t
  :after ox
  :config
  (setq org-hugo-section "posts")
  (setq org-hugo-export-with-section-numbers t)
  (setq org-hugo-auto-set-lastmod t))

(provide 'use-hugo)

