(defun my:keys()
  (global-set-key (kbd "C-M-k") (lambda () (interactive) (load-file "~/.emacs.d/init.el")))
  (global-set-key (kbd "C-c M-x") 'helm-M-x)
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
  (global-set-key (kbd "M-/") 'undo-tree-visualize) ;graphic showing undo history
  (global-set-key (kbd "C-M-z") 'switch-to-next-buffer) ;easy switch between buffers
  (global-set-key (kbd "C-c SPC") 'ace-jump-mode)
  (global-set-key (kbd "C-c C-c SPC") 'ace-jump-line-mode)
  (global-set-key (kbd "C-c C-s") 'isearch-forward)
  (global-set-key (kbd "C-c C-r") 'isearch-backward)
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "C-r") 'swiper)
  (global-set-key (kbd "C-x p") 'projectile-find-file)
  (global-set-key [f8] 'neotree-toggle))

(provide 'set-keys)
;;; set-keys.el ends here
