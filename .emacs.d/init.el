;;; init.el --- SUMMARY - my config

;;; Commentary:
;;; my init.el

;;; Code:
(load-file "~/.emacs.d/init/basic.el")
(load-file "~/.emacs.d/init/install.el")
(load-file "~/.emacs.d/init/configure-packages.el")
(load-file "~/.emacs.d/init/set-keys.el")
(load-file "~/.emacs.d/init/set-vars.el")

(defun my:init()
  (my:configure-basic)
  (my:installPackages)
  (my:configure-packages)
  (my:keys)
  (my:vars))

(my:init)


(provide 'init)
;;; init.el ends here
