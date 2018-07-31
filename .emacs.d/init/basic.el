(defun my:configure-basic()
  ;; disable menubar
  (menu-bar-mode -1)

  ;; disable toolbar
  (tool-bar-mode -1)

  ;; disable scrollbar
  (scroll-bar-mode -1)

  ;; expandtab
  (setq-default indent-tabs-mode nil)
  (setq tab-width 4))

(provide 'basic)
;;; basic.el ends here
