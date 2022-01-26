;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "sherylynn"
      user-mail-address "sherylynn@qq.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;
(setq doom-theme 'doom-one)
;;(load-theme 'vscode-dark-plus t)

;; stop alert me about quit emacs
(setq confirm-kill-emacs nil)
;;
;; set mouse for terminal but lost mouse click
;;(remove-hook 'tty-setup-hook #'xterm-mouse-mode)
;;(xterm-mouse-mode -1)
;;
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/work/")
(setq default-input-method "rime"
      rime-show-candidate 'posframe)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(defun async-shell-command-no-window
    (command)
  (interactive)
  (let
      ((display-buffer-alist
        (list
         (cons
          "\\*Async Shell Command\\*.*"
          (cons #'display-buffer-no-window nil)))))
    (async-shell-command
     command)))

(async-shell-command-no-window "git -C ~/.doom.d pull")
;;
;;
;;  (let ((default-directory "~/.doom.d"))
;;    (message (pwd))
;;    (call-interactively #'magit-pull-from-upstream)
;;    )
;;
(defun checkbox-insert ()
  "insert checkbox" ;;need desc
  (interactive) ;;need interactive
  (insert "- [ ]")
  (evil-escape )
  (org-update-checkbox-count-maybe )
       )
(defun insert-now-time()
  "insert now time"
  (interactive)
  (org-time-stamp-inactive "HH:MM")
  )
(defun todo-insert ()
  "insert todo" ;;need desc
  (interactive) ;;need interactive
  (org-insert-todo-heading t)
  ;;(insert "TODO")
  ;;(org-todo "t")
  (org-update-checkbox-count-maybe )
       )
(defun configure-emacs ()
  "configure emacs"
  (interactive)
  (find-file "~/.doom.d/packages.el")
  (find-file "~/.doom.d/init.el")
  (find-file "~/.doom.d/config.el")
  )
;;(find-file "~/.doom.d/init.el")
;;(checkbox-insert )
(map! (:leader
        (:desc "neotree" :g "1" #'neotree-toggle)
        (:desc "org time stamp" :g "2" #'org-time-stamp)
        (:desc "toggle terminal" :g "tt" #'+eshell/toggle)
        (:desc "edit editor configure" :g "ee" #'configure-emacs)
        (:desc "edit editor configure" :g "ze" #'configure-emacs)
        (:desc "edit org mode file" :g "zo"
         (cmd! (find-file "~/work/todo.org")))
        (:desc "reload editor configure" :g "zr" #'doom/reload)
        (:desc "insert todo" :g "3" #'todo-insert )
        (:desc "insert checkbox" :g "ic" #'checkbox-insert )
        (:desc "insert todo" :g "it" #'todo-insert )
        (:desc "insert now time" :g "in" #'insert-now-time )
       ))
;;(async-shell-command-no-window "git -C ~/work pull")
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
