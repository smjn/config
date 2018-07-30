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
        '(;; ac-c-headers
          ;; ac-clang
          ;; ac-html
          ;; ac-html-angular
          ;; ac-html-csswatcher
          ;; ac-js2
          ace-jump-mode
          airline-themes
          ;; auto-complete
          ;; auto-complete-clang-async
          comment-dwim-2
          company
          company-c-headers
          company-ghc
          company-go
          company-jedi
          company-lua
          company-shell
          company-go
          company-tern
          evil
          evil-commentary
          flycheck
          gnutls
          ivy
          jbeans-theme
          linum-relative
          lush-theme
          neotree
          org-bullets
          powerline
          solarized-theme
          swiper
          use-package
          yasnippet
          yasnippet-snippets))
  (unless package-archive-contents
    (package-refresh-contents))

  (dolist (pkg pkg-list)
    (unless (package-installed-p pkg)
      (package-install pkg))))

;;; for installing packages
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t) ; melpa collection of packages
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t) ; default archives

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
;; (use-package auto-complete
;;   :ensure t
;;   :config
;;   (ac-config-default))

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
;; (use-package jbeans-theme
;;   :ensure t
;;   :config
;;   (load-theme 'jbeans t))

(use-package lush-theme
  :ensure t
  :config
  (load-theme 'lush  t))


;; for better commenting features in native emacs
(use-package comment-dwim-2
  :ensure t
  :config
  (global-set-key (kbd "M-;") 'comment-dwim-2))

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

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (global-company-mode))

(use-package company-jedi
  :ensure t
  :config
  (add-hook 'python-mode-hook 'jedi:setup))

(defun my:python-mode-hook()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my:python-mode-hook)

(use-package company-irony
  :ensure t
  :config
  (add-to-list 'company-backends 'company-irony))

(use-package company-shell
  :ensure t
  :config
  (add-to-list 'company-backends 'company-shell))

(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package company-tern
  :ensure t
  :config
  (add-to-list 'company-backends 'company-tern)
  (add-hook 'js2-mode-hook (lambda ()
                             (tern-mode)
                             (company-mode))))

(use-package company-go
  :ensure t
  :config
  (add-hook 'go-mode-hook (lambda ()
                            (set (make-local-variable 'company-backends) '(company-go))
                            (company-mode))))

(use-package ivy
  :ensure t
  :config
  (ivy-mode t))

(use-package swiper
  :ensure t)

(use-package neotree
  :ensure t
  :config
  (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter))))


;;; install package end

;; custom keys
(global-set-key (kbd "C-M-k") (lambda () (interactive) (load-file "~/.emacs.d/init.el")))
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(global-set-key (kbd "M-/") 'undo-tree-visualize)
(global-set-key (kbd "C-M-z") 'switch-to-next-buffer)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)
(global-set-key (kbd "C-c C-s") 'isearch)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key [f8] 'neotree-toggle)

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

(provide 'init)
;;; init.el ends here
