;;; init.el --- SUMMARY - my config

;;; Commentary:
;;; my init.el


;;; Code:
(defvar my:init-dir
  (expand-file-name "init" user-emacs-directory))
(dolist (file (directory-files my:init-dir t "\\w+$"))
  (when (file-regular-p file)
    (message "loading %s" file)
    (load file)))

(declare-function my:configure-basic "basic" ())
(declare-function my:installPackages "install" ())
(declare-function my:configure-packages "configure-packages" ())
(declare-function my:keys "set-keys" ())
(declare-function my:vars "set-vars" ())

(defun my:init()
  (my:configure-basic)
  (my:installPackages)
  (my:configure-packages)
  (my:keys)
  (my:vars))

(my:init)

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3eb93cd9a0da0f3e86b5d932ac0e3b5f0f50de7a0b805d4eb1f67782e9eb67a4" default)))
 '(package-selected-packages
   (quote
    (cider clojure-mode projectile zenburn-theme yasnippet-snippets use-package swiper solarized-theme rainbow-delimiters rainbow-blocks org-bullets nlinum neotree monokai-theme lush-theme linum-relative json-mode jbeans-theme helm ggo-mode flycheck exec-path-from-shell evil-surround evil-commentary elisp-lint elisp-format diminish company-tern company-shell company-lua company-jedi company-irony company-go company-ghc company-emacs-eclim company-c-headers compact-docstrings comment-dwim-2 color-theme-sanityinc-solarized auto-complete-clang-async airline-themes ace-jump-mode ac-js2 ac-html-csswatcher ac-html-angular ac-html ac-clang ac-c-headers))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
