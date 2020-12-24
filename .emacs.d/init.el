(setq inhibit-startup-message t)  ; disable initial screen

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)              ; little bit of padding around the work area
(menu-bar-mode -1)

(setq visible-bell t)

(setq vc-follow-symlinks t)

(setq custom-file (concat user-emacs-directory "/custom.el"))

(when (file-exists-p custom-file)
   (load-file custom-file))

(set-face-attribute 'default  nil :font "Hack" :height 105)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
(dolist (mode '(org-mode-hook
		eshell-mode-hook
		shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
(global-set-key (kbd "C-c l") 'display-line-numbers-mode)

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


(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 14)))


(use-package doom-themes)
(load-theme 'doom-dracula 1)


(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-dle-timeout 0.3))


(use-package ivy-rich
  :after (ivy)
  :init
  (ivy-rich-mode 1))


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
  
