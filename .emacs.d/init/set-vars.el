(defun my:vars()
  (setq linum-relative-current-symbol "")
  (add-hook 'prog-mode-hook (lambda()
                              (show-paren-mode 1)
                              (setq electric-pair-pairs '(
                                                          (?\{ . ?\})
                                                          (?\" . ?\")
                                                          (?\' . ?\')
                                                          ))
                              (electric-pair-mode 1)))
  
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(custom-safe-themes
     (quote
      ("3eb93cd9a0da0f3e86b5d932ac0e3b5f0f50de7a0b805d4eb1f67782e9eb67a4" default))))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   ))
(provide 'set-vars)
;;; set-vars.el ends here
