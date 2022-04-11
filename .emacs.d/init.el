(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(set-frame-font "JetBrains Mono 16" nil t)

(set-language-environment 'utf-8)                                                           
(setq locale-coding-system 'utf-8)

;; set the default encoding system                                                          
(prefer-coding-system 'utf-8)                                                               
(setq default-file-name-coding-system 'utf-8)                                               
(set-default-coding-systems 'utf-8)                                                         
(set-terminal-coding-system 'utf-8)                                                         
(set-keyboard-coding-system 'utf-8)  

(setq backup-directory-alist '((".*" . "~/.waste")))

(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(setq custom-file (concat user-emacs-directory  "/custom.el"))
(when (file-exists-p custom-file)
  (load-file custom-file))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))


(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(global-set-key (kbd "C-c l") 'display-line-numbers-mode)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package company
  :init
  (global-company-mode t)
  :ensure t
  :hook
  (lsp-mode . company-mode)
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.1))


(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package swiper)

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

(use-package ivy
  :diminish
  :after (swiper)
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done))
  :config
  (ivy-mode 1))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-dle-timeout 0.3))


(use-package ivy-rich
  :after (ivy)
  :init
  (ivy-rich-mode 1))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)

  :config
  (evil-mode 1))

(use-package evil-commentary
  :after (evil)
  :ensure t
  :config (evil-commentary-mode 1))

(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


(use-package neotree
  :ensure t
  :bind
  (("C-c p" . neotree-toggle)))

(use-package python-mode
  :ensure t
  :hook
  (python-mode . lsp-deferred)
  (python-mode . yas-minor-mode)
  (before-save . lsp-format-buffer)
  (before-save . lsp-organize-imports)
  :custom
  (python-shell-interpreter "python3"))


(use-package go-mode
  :ensure t
  :config
  (setq-default tab-width 4)
  (setq-default indent-tabs-mode nil)
  :hook
  (go-mode . lsp-deferred)
  (go-mode . yas-minor-mode)
  (before-save . lsp-format-buffer)
  (before-save . lsp-organize-imports))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox t))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))