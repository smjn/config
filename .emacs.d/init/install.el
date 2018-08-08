(defun my:installPackages()
;;; for installing packages
  (require 'package)

  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t) ; melpa collection of packages
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t) ; default archives

  ;; installed packages initialization
  (package-initialize)
  (defvar pkg-list
    '(;; ac-c-headers
      ;; ac-clang
      ;; ac-html
      ;; ac-html-angular
      ;; ac-html-csswatcher
      ;; ac-js2
      ace-jump-mode
      airline-themes
      magit                         ;git stuff for emacs like fugitive
      ;; auto-complete
      ;; auto-complete-clang-async
      projectile                   ;better inproject navigation
      cider                        ;repl and ide for clojure
      clojure-mode                 ;stuff for writing clojure progs
      rainbow-delimiters           ;same as below
      rainbow-blocks                  ;to show braces in different colors
      comment-dwim-2                ;better comments in native emacs
      company                       ;better autocomplete
      company-c-headers
      company-ghc    		;haskell :)
      company-go                    ;golang autocomplete via company
      company-irony                 ;company wrapper for irony (c/cpp completion)
      company-jedi                  ;python autocomplete via company
      company-lua
      company-shell                 ;shell autocomplete via company
      evil                          ;vim mode
      evil-commentary               ;tpopes vim commentary
      evil-surround                 ;surround like vim (tpope)
      exec-path-from-shell          ;to copy env variables from shell
      flycheck                      ;syntax checker
      gnutls
      helm                          ;assistant
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

(provide 'install)
;;; install.el ends here
