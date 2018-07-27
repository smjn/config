;;; init.el --- SUMMARY - my config

;;; Commentary: 
;;; my init.el

;;; Code:
;; disable menubar
(menu-bar-mode -1)

;; disable toolbar
(tool-bar-mode -1)

;; disable scrollbar
(scroll-bar-mode -1)

;; expandtab
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

;;; custom function to install my packages
(defun my:installPackages()
  (setq pkg-list
        '(jbeans-theme
          use-package
          flycheck
          yasnippet
          yasnippet-snippets
          evil
          evil-commentary
          linum-relative
          airline-themes
          comment-dwim-2
          powerline
          auto-complete
          auto-complete-clang-async
          org-bullets
          solarized-theme))
  (unless package-archive-contents
    (package-refresh-contents))

  (dolist (pkg pkg-list)
    (unless (package-installed-p pkg)
      (package-install pkg))))

;;; for installing packages
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/")) ; melpa larger collection than stable
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")) ; default archives

;; installed packages initialization
(package-initialize)

;; install any missing packages
(my:installPackages)

;; use the declarative package config style
(eval-when-compile
  (require 'use-package))

;; relative line numbers on left margin
(use-package linum-relative
  :ensure t
  :config
  (linum-relative-global-mode))

;; start autocomplete with emacs
(use-package auto-complete
  :ensure t
  :config
  (ac-config-default))

;; org mode specific stuff
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; airline (statusbar)
(use-package airline-themes
  :ensure t
  :init
  (use-package powerline)
  :config
  (load-theme 'airline-dark t))

;; ui theme
(use-package jbeans-theme
  :ensure t
  :config
  (load-theme 'jbeans t))

;; for better comment action in native emacs
(use-package comment-dwim-2
  :ensure t
  :config
  ( global-set-key (kbd "M-;") 'comment-dwim-2))

;; vim mode and vim-commentary
(use-package evil-commentary
  :ensure t
  :init
  (use-package evil
    :ensure t
    :config
    (evil-mode 1))
  :config
  (evil-commentary-mode))

;; flycheck (syntax checker)
(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

;; yasnippets
(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t)
  (yas-reload-all)
  (yas-global-mode 1))

;;; install package end

;; custom keys
( global-set-key (kbd "C-M-k") (lambda () (interactive) (load-file "~/.emacs.d/init.el")))
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
 )
