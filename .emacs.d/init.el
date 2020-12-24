(setq inhibit-startup-message t)  ; disable initial screen

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)              ; little bit of padding around the work area
(menu-bar-mode -1)
(setq vc-follow-symlinks t)

(setq visible-bell t)

(set-face-attribute 'default  nil :font "Hack" :height 130)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; init package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://orgmode.org/elpa")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))


(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package swiper)

(use-package counsel)

(use-package ivy
  :diminish
  :bind(("C-s" . swiper)
	:map ivy-minibuffer-map
	("TAB" . ivy-alt-done))
  :config
  (ivy-mode 1))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 14)))

(use-package doom-themes)
(load-theme 'doom-material 1)

(use-package linum-relative
  :ensure t
  :init
  (setq linum-relative-backend 'display-line-numbers-mode)
  (setq linum-relative-current-symbol "")
  :config
  (linum-relative-global-mode t))

(global-set-key (kbd "C-c l") 'linum-relative-global-mode)
