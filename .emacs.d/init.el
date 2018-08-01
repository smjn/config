;;; init.el --- SUMMARY - my config

;;; Commentary:
;;; my init.el

;;; Code:
(defvar my:init-dir
  (expand-file-name "init" user-emacs-directory))
(dolist (file (directory-files my:init-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

(declare-function my:configure-basic "basic" ())
(declare-function my:installPackages "install" ())
(declare-function my:configure-packages "configure-packages" ())
(declare-function my:keys "set-keys" ())
(declare-function my:vars "set-vars" ())

(defun my:init()
  (my:configure-basic)
  (my:installPackages)
  (my:configure-packages)
  (my:keys)
  (my:vars))

(my:init)

(provide 'init)
;;; init.el ends here
