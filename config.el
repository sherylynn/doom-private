;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "sherylynn"
      user-mail-address "sherylynn@qq.com")
(setq max-lisp-eval-depth 10000)
(setq max-specpdl-size 10000)
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
;;(setq doom-theme 'doom-one) no tabs
;;(setq doom-theme 'doom-one-light);; too light
;;(setq doom-theme 'doom-monokai-pro) ;;no tabs
;;(setq doom-theme 'doom-solarized-dark);;no tabs
;;(setq doom-theme 'doom-solarized-light);;no tabs
(setq doom-theme 'doom-dark+)
;;(load-theme 'vscode-dark-plus t)
;;(setq doom-theme 'doom-material) ;; lack of js syntax
;;(setq doom-theme 'doom-oceanic-next) ;;ugly

;; stop alert me about quit emacs
(setq confirm-kill-emacs nil)
;;
;; set mouse for terminal but lost mouse click
;;(remove-hook 'tty-setup-hook #'xterm-mouse-mode)
;;(xterm-mouse-mode -1)
;;
;;Mouse scrolling in terminal
(unless (display-graphic-p)
  (xterm-mouse-mode 1)
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line)
  ;;关闭终端下 xclip－mode 以应对 termux 下 doom 会使用 termux－clipboard 导致终端无法粘贴
  ;; (xclip-mode nil)
  ;; 需要加载 hook
  ;;(add-hook! 'xclip-mode-hook (lambda() (xclip-mode -1)))
  ;;hook 也无效，算拉还是用我自个的配制
  ;;把傻逼默认的 hook 干掉
  (remove-hook 'tty-setup-hook 'doom-init-clipboard-in-tty-emacs-h)
  )
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/work/")
;;(setq default-input-method "rime")
(global-pangu-spacing-mode 1)
(setq pangu-spacing-real-insert-separtor t)
;;手动 set 一下才没有问题？native 版本离谱
(setq
 warning-suppress-log-types '((org-element-cache)))
;;测试感觉还是 minibuffer 最快，cpu 占用最小
;;然后就是 postframe 排第二，arm 会卡
;;效果最卡是 popup，台式机上都卡
;;视觉最好是 postframe，
;;(setq rime-show-candidate 'popup)
;;
;;
(when (file-exists-p "/home/linuxbrew")
  (setq rime-emacs-module-header-root
        "/home/linuxbrew/.linuxbrew/include"
        ))
(setq rime-show-candidate 'posframe)
(defun toggle-rime-show-candidate()
  "toggle rime show candidate"
  (interactive)
  (if (equal rime-show-candidate 'posframe)
      (setq rime-show-candidate 'minibuffer)
    (setq rime-show-candidate 'posframe))
  )
(setq rime-user-data-dir "~/rime")
(setq rime-share-data-dir "~/rime")
;;rime-user-data-dir "~/storage/download/rime")
;;
(with-eval-after-load "liberime"
  (liberime-try-select-schema "luna_pinyin_simp")
  (setq pyim-default-scheme 'rime-quanpin))
(after! pyim
  ;;加载用户词库
  ;;(setq pyim-dicts
  ;;'((:name "tsinghua" :file "~/.emacs.d_doom/.local/straight/repos/pyim-tsinghua-dict/pyim-tsinghua-dict.pyim")
  ;;))
  (pyim-basedict-enable)
  (pyim-tsinghua-dict-enable)
  (setq pyim-page-tooltip 'posframe )
  ;;(pyim-default-scheme 'quanpin)
  (require 'pyim-dregcache)
  (setq pyim-dcache-backend 'pyim-dregcache)
  )
(setq default-input-method 'pyim)
;;
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(defun async-shell-command-no-window
    (command)
  (interactive)
  (setq async-shell-command-buffer "new buffer")
  (let
      ((display-buffer-alist
        (list
         (cons
          "\\*Async Shell Command\\*.*"
          (cons #'display-buffer-no-window nil)))))
    (async-shell-command
     command)))

(async-shell-command-no-window "git -C ~/.doom.d pull")
(async-shell-command-no-window "git -C ~/.emacs.d_my pull")
(async-shell-command-no-window "git -C ~/sh pull")
(async-shell-command-no-window "git -C ~/work pull")
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
(defun set-input-method-rime()
  "set input method rime"
  (interactive)
  (set-input-method 'rime)
  )
(defun insert-now-schedule()
  "insert now schedule"
  (interactive)
  (org-schedule "HH:MM")
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
       ;;(:desc "neotree" :g "1" #'neotree-toggle)
       ;;缺少 all-icon 所以 neotree 不知道用不了,treemacs 不会显示正常当前路径
       (:desc "treemacs" :g "1" #'treemacs)
       (:desc "org time stamp" :g "2" #'org-time-stamp)
       ;;(:desc "toggle terminal" :g "tt" #'+eshell/toggle)
       (:desc "toggle terminal" :g "tt" #'+vterm/toggle)
       (:desc "toggle rime show" :g "ts" #'toggle-rime-show-candidate)
       (:desc "turn on rime input method" :g "ti" #'set-input-method-rime)
       (:desc "exec" :g "x" #'execute-extended-command)

       ;;SPC z
       (:desc "edit editor configure" :g "ze" #'configure-emacs)
       (:desc "edit org mode file" :g "zo"
              (cmd! (find-file "~/work/todo.org")))
       (:desc "reload editor configure" :g "zr" #'doom/reload)
       (:desc "show todo tree" :g "zt" #'org-show-todo-tree)
       (:desc "edit editor configure" :g "zf" #'magit-pull-from-upstream)
       (:desc "exit emacs" :g "zz" #'kill-emacs)
       (:desc "insert todo" :g "3" #'todo-insert )

       ;;SPC h
       (:g "hf" #'describe-function)
       (:g "hv" #'describe-variable)
       (:g "hk" #'find-function-on-key)

       ;;SPC o
       (:desc "org item right" :g "ol" #'org-demote-subtree)
       (:desc "org item left" :g "oh" #'org-promote-subtree)
       (:desc "org item down" :g "oj" #'outline-move-subtree-down)
       (:desc "org item up" :g "ok" #'outline-move-subtree-up)

       ;;SPC i
       (:desc "insert checkbox" :g "ic" #'checkbox-insert )
       (:desc "insert todo" :g "it" #'todo-insert )
       (:desc "insert now time" :g "in" #'insert-now-time )
       (:desc "insert now schedule" :g "id" #'insert-now-schedule)
       (:desc "insert heading" :g "ih" #'org-insert-heading-respect-content)
       ;;SPC SPC
       (:desc "find file" :g "SPC" #'projectile-find-file)
       ;;SPC gg
       (:desc "magit-status" :g "gg" #'magit-status)

       ;;SPC -=
       (:desc "font size decrease" :g "-" #'doom/decrease-font-size)
       (:desc "font size increase" :g "=" #'doom/increase-font-size)

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
