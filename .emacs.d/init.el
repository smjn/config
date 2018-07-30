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
          comment-dwim-2                ;better comments in native emacs
          company                       ;better autocomplete
          company-c-headers
          company-ghc    		;haskell :)
          company-go                    ;golang autocomplete via company
          company-irony                 ;company wrapper for irony (c/cpp completion)
          company-jedi                  ;python autocomplete via company
          company-lua
          company-shell                 ;shell autocomplete via company
          company-tern                  ;js autocomplete via company
          evil                          ;vim mode
          evil-commentary               ;tpopes vim commentary
          flycheck                      ;syntax checker
          gnutls
          helm
          irony                         ;c/cpp completion backend
          ivy                           ;replaces find file
          jbeans-theme                  ;default theme earlier but minibuffer not very readable, use lush-theme instead
          linum-relative                ;relative line numbers on left
          lush-theme                    ;cool theme good contrasts
          neotree                       ;like nerdtree, needs specific bindings in evil mode
          org-bullets                   ;interpret org-mode symbols beautifully
          powerline                     ;more info on the status line
          solarized-theme
          swiper                        ;replaces isearch
          use-package                   ;declarative style package config
          yasnippet                     ;snippet engine
          yasnippet-snippets))          ;snippet collection
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

(eval-when-compile
  (require 'use-package))

(use-package linum-relative
  :ensure t
  :config
  (linum-relative-global-mode))

;; start autocomplete with emacs
;; (use-package auto-complete
;;   :ensure t
;;   :config
;;   (ac-config-default))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

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

(use-package evil-commentary
  :ensure t
  :init
  (use-package evil
    :ensure t
    :config
    (evil-mode 1))
  :config
  (evil-commentary-mode))

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

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

(use-package helm
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
(global-set-key (kbd "C-c M-x") 'helm-M-x)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(global-set-key (kbd "M-/") 'undo-tree-visualize) ;graphic showing undo history
(global-set-key (kbd "C-M-z") 'switch-to-next-buffer) ;easy switch between buffers
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
