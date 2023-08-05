(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(setq inhibit-startup-message t) 
(setq initial-scratch-message nil)
(set-frame-font "JetBrains Mono Light 14" nil t)

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

(setq custom-file (concat user-emacs-directory  "custom.el"))
(when (file-exists-p custom-file) 
  (load-file custom-file))

;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t)

(use-package 
  exec-path-from-shell 
  :ensure t 
  :init (exec-path-from-shell-initialize))

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(global-set-key (kbd "C-c l") 'display-line-numbers-mode)
(global-set-key (kbd "C-c b l") 'list-bookmarks)

(unless (package-installed-p 'use-package) 
  (package-install 'use-package))


(use-package 
  company 
  :init (global-company-mode t) 
  :ensure t 
  :hook (lsp-mode . company-mode) 
  :custom (company-minimum-prefix-length 1) 
  (company-idle-delay 0.1))

(use-package 
  rainbow-delimiters 
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package 
  swiper)

(use-package 
  counsel 
  :bind (("M-x" . counsel-M-x) 
	 ("C-x b" . counsel-ibuffer) 
	 ("C-x C-f" . counsel-find-file) 
	 :map minibuffer-local-map ("C-r" . 'counsel-minibuffer-history)))

(use-package 
  ivy
  :diminish 
  :after (swiper) 
  :bind (("C-s" . swiper) :map ivy-minibuffer-map ("TAB" . ivy-alt-done)) 
  :config (ivy-mode 1))

(use-package 
  which-key 
  :init (which-key-mode) 
  :diminish which-key-mode 
  :config (setq which-key-dle-timeout 0.3))


(use-package 
  ivy-rich 
  :after (ivy) 
  :init (ivy-rich-mode 1))

(use-package 
  evil 
  :init (setq evil-want-integration t) 
  (setq evil-want-keybinding nil) 
  (setq evil-want-C-u-scroll t) 
  :config (evil-mode 1))

(use-package 
  evil-commentary 
  :after (evil) 
  :ensure t 
  :config (evil-commentary-mode 1))

(use-package 
  helpful 
  :ensure t 
  :custom (counsel-describe-function-function #'helpful-callable) 
  (counsel-describe-variable-function #'helpful-variable) 
  :bind ([remap describe-function] . counsel-describe-function) 
  ([remap describe-command] . helpful-command) 
  ([remap describe-variable] . counsel-describe-variable) 
  ([remap describe-key] . helpful-key))


(use-package 
  neotree 
  :ensure t 
  :config (setq neo-show-hidden-files t) 
  :bind (("C-c p" . neotree-toggle)))

(use-package 
  haskell-mode 
  :ensure t)

(use-package 
  python-mode 
  :ensure t 
  :config (add-hook 'python-mode-hook 'lsp-deferred) 
  (add-hook 'before-save-hook (lambda () 
				(when (eq major-mode 'python-mode) 
				  (lsp-format-buffer) 
				  (lsp-organize-imports)))) 
  :custom (python-shell-interpreter "python3"))


(use-package 
  go-mode 
  :ensure t 
  :config (add-hook 'go-mode-hook 'lsp-deferred) 
  (add-hook 'go-mode-hook 'yas-minor-mode) 
  (add-hook 'before-save-hook (lambda () 
				(when (eq major-mode 'go-mode) 
				  (lsp-format-buffer) 
				  (lsp-organize-imports)))))

(use-package 
  doom-themes 
  :ensure t 
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-gruvbox t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package 
  all-the-icons)

(use-package 
  gruvbox-theme)

(use-package 
  org-bullets 
  :ensure t 
  :config (add-hook 'org-mode-hook (lambda () 
				     (org-bullets-mode 1))))

(use-package 
  flycheck 
  :ensure t 
  :init (global-flycheck-mode t))

(use-package 
  lsp-mode 
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c s") 
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (python-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration)) 
  :commands lsp)

;; optionally
(use-package 
  lsp-ui 
  :commands lsp-ui-mode)
;; if you are ivy user
(use-package 
  lsp-ivy 
  :commands lsp-ivy-workspace-symbol)
(use-package 
  lsp-treemacs 
  :commands lsp-treemacs-errors-list)

(use-package 
  evil-collection 
  :after evil 
  :ensure t 
  :config (evil-collection-init))

(use-package 
  format-all 
  :ensure t 
  :bind (("C-c f" . format-all-buffer)))

(use-package 
  elisp-format 
  :ensure t 
  :config (add-hook 'before-save-hook (lambda () 
					(when (eq major-mode 'emacs-lisp-mode) 
					  (elisp-format-buffer)))))
