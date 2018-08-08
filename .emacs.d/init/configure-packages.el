(defun my:configure-packages()
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

  (use-package projectile
    :ensure t
    :config
    (projectile-global-mode)
    (setq projectile-completion-system 'ivy))

  (use-package lush-theme
    :ensure t
    :config
    (load-theme 'lush  t))


  (use-package comment-dwim-2
    :ensure t
    :config
    (global-set-key (kbd "M-;") 'comment-dwim-2))

  (defun my:start-evil()
    (use-package evil
      :ensure t
      :config
      (evil-mode 1)))

  (use-package evil-commentary
    :ensure t
    :init
    (my:start-evil)
    :config
    (evil-commentary-mode))

  (use-package evil-surround
    :ensure t
    :init
    (my:start-evil)
    :config
    (evil-surround-mode))

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

  (defun my:go-mode-hook()
    (defvar gofmt-command "goimports")
    (add-hook 'before-save-hook 'gofmt-command)
    (set (make-local-variable 'company-backends) '(company-go))
    (add-hook 'go-mode-hook 'company-go))
  (use-package company-go
    :ensure t
    :config
    (add-hook 'go-mode-hook 'my:go-mode-hook))

  (use-package ivy
    :ensure t
    :config
    (ivy-mode t))

  (use-package swiper
    :ensure t)

  (use-package helm
    :ensure t)

  (defun my:neotree-mode-hook()
    (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
    (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
    (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
    (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter))

  (use-package neotree
    :ensure t
    :config
    (add-hook 'neotree-mode-hook 'my:neotree-mode-hook))

  (use-package rainbow-delimiters
    :ensure t
    :config
    (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

  (use-package exec-path-from-shell
    :ensure t
    :if (memq window-system '(mac ns x))
    :config
    (setq exec-path-from-shell-variables '("GOROOT" "GOPATH" "GOBIN" "PATH"))
    (exec-path-from-shell-initialize))

  (use-package magit
    :ensure t))

(provide 'configure-packages)
;;; configure-packages.el ends here
