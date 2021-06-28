;; general UI
(menu-bar-mode -1)
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

;; custom files and paths
(setq locale-coding-system 'utf-8)
(setq custom-file (concat user-emacs-directory "/custom.el"))
(when (file-exists-p custom-file)
  (load-file custom-file))

;; custom package archives
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

;; package installation boilerplate
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; custom packages
(use-package swiper)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

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
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))


(use-package ivy-rich
  :after (ivy)
  :init
  (ivy-rich-mode 1))


(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-timeout 0.3))


(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state))


(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay nil))


(use-package doom-themes
  :ensure t
  :init
  (load-theme 'doom-gruvbox t))


(use-package general
  :ensure t
  :config
  (general-evil-setup t)
  (general-create-definer smjn/leader-keys
    :keymaps '(normal)
    :prefix "SPC")

  (smjn/leader-keys
   "t" '(:ignore t :which-key "toggles")
   "tt" '(counsel-load-theme :which-key "choose theme")
   "tl" 'display-line-numbers-mode
   "tc" '((lambda () (interactive)
	   (if company-idle-delay
	       (setq company-idle-delay nil)
	     (setq company-idle-delay 0.1))) :which-key "toggle company mode")
   "ts" '(evil-ex-nohighlight :which-key "toggle hlsearch")
   "b" '(:ignore b :which-key "buffers")
   "bl" '(counsel-switch-buffer :which-key "choose buffer")))
