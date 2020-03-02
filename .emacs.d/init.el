
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


;;; Code:
(require 'package)
(add-to-list 'package-archives '("MELPA"."http://melpa.milkbox.net/packages/") t)
;;(add-to-list 'load-path "~/.emacs.d/python-mode/")
(package-initialize)
(eval-when-compile
  (require 'use-package))


;; Hooks and generic
(add-hook 'before-save-hook 'delete-trailing-whitespace)  ;; Delete trailing whitespace
(use-package exec-path-from-shell)
(setq column-number-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("777a3a89c0b7436e37f6fa8f350cbbff80bcc1255f0c16ab7c1e82041b06fccd" default)))
 '(package-selected-packages
   (quote
    (avy web-mode graphviz-dot-mode clojure-mode json-mode csv-mode yaml-mode julia-mode nix-mode xclip list-packages-ext markdown-mode powerline diredfl js2-refactor spacemacs-dark dracula-theme expand-region hydra exec-path-from-shell python-mode rainbow-mode fill-column-indicator solidity-flycheck flycheck multi-term rg counsel-world-clock counsel wgrep ivy magit org-journal))))


;; Magit
(use-package magit
  :init
  (setq magit-repository-directories '(("~/src" . 1)))
  :bind (("C-x g" . magit-status)
         ("C-c M-g" . magit-file-dispatch)))


;; Org mode
(use-package org
  :commands org-babel-do-load-languages
  :init
  (add-hook 'org-mode-hook (lambda ()
			     (fset 'tex-font-lock-suscript 'ignore)
                             (org-babel-do-load-languages
                              'org-babel-load-languages
                              '((python . t)
                                (shell . t)
				(dot . t)))))
  (setq org-log-done t
	org-src-fontify-natively t
	org-hide-leading-stars t
	org-agenda-files (list "~/Documents/org/")
	org-todo-keywords '((sequence "TODO" "WIP" "WAITING" "HOLD" "DONE" "CANCELED")))
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  :config
  (unbind-key "C-'" org-mode-map)
  (unbind-key "C-," org-mode-map))


;; Org Journal
(use-package org-journal
  :init
  (setq org-journal-dir "~/Documents/org/journal/"
      org-journal-file-format "%Y%m%d.org"
      org-journal-date-prefix "#+TITLE: Daily Notes "))


;; Paren mode
(use-package paren
  :config
  (show-paren-mode 1))


;; Enable auto completion of brackets by default
(use-package electric
  :config
  (electric-pair-mode 1))


;; Ivy, Avy, Counsel
(use-package ivy
  :commands
  ivy-mode
  :init
  (ivy-mode 1)
  (setq ivy-height 15
        ivy-fixed-height-minibuffer t
       	ivy-use-virtual-buffers t)
  :bind (("C-x b" . ivy-switch-buffer)
         ("C-c r" . ivy-resume)
	 ("C-x C-b" . ibuffer)))

(use-package avy
  :bind (("C-:" . avy-goto-char)
	 ("C-'" . avy-goto-char-2)
	 ("M-g f" . avy-goto-line)
	 ("M-g w" . avy-goto-word-1)
	 ("M-g e" . avy-goto-word-0)))

(use-package counsel
  :init
  (setq counsel-find-file-ignore-regexp "\\archive\\'")
  (defun counsel-org-rg ()
    "Search org notes using ripgrep."
    (interactive)
    (counsel-rg "-g*org -g!*archive* -- " "~/Documents/org" nil nil))
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-c g" . counsel-rg)
         ("C-c G" . counsel-git)
         ("C-c o" . counsel-org-rg)
	 ("C-x l" . counsel-locate)
         ("C-x b" . counsel-switch-buffer)
         ("C-c h" . counsel-minibuffer-history)
         ("M-y" . counsel-yank-pop)))

(use-package swiper
  :bind ("C-c s" . swiper))

(use-package wgrep)

(use-package hydra)

(use-package diredfl
  :commands diredfl-global-mode
  :init (diredfl-global-mode))


;;
;; Python development
;;

;; Python mode
(use-package python
  :ensure t
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode))

;; Anaconda mode
(use-package anaconda-mode
  :after exec-path-from-shell
  :commands (pythonic-activate
             pythonic-deactivate
             anaconda-eldoc-mode)
  :init
  (defun activate (virtualenv)
    "Activate a virtual environment so that pytest recognizes it."
    (interactive "DEnv: ")
    (pythonic-activate virtualenv)
    (exec-path-from-shell-setenv
     "PATH"
     (string-join (python-shell-calculate-exec-path) ":")))
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode))

;; Pytest
(use-package python-pytest
  :bind ("C-c t" . python-pytest-popup))

;; Flycheck
;; TODO: Make function that loads the desired virtual environment

(use-package flycheck
  :init
  (setq-default flycheck-emacs-lisp-load-path 'inherit)
  (setq flycheck-flake8-maximum-line-length 79)
  (setq flycheck-python-pylint-executable "~/miniconda/envs/leanheat/bin/pylint")
  (setq flycheck-python-flake8-executable "~/miniconda/envs/leanheat/bin/flake8")
  (add-hook 'python-mode-hook 'global-flycheck-mode)
  :config
  ;; There was a weird warning when opening Python files
  ;; 'no abbrev-file found ...'. It was fixed with adding the below line.
  ;; It is most likely due to Flycheck using the abbrev-mode under the hood.
  ;; Can be fixed either by
  ;; - (setq abbrev-file-name "~/.emacs.d/abbrev_defs")
  ;; - the line below
  (abbrev-mode -1))


;;
;; Web development
;;

;; JS2 mode
(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :interpreter "node")

(use-package web-mode)

;;
;; Multiline editing (TODO)
;;

(use-package expand-region
  :bind
  ("M-2" . er/expand-region))


;;
;; Miscellaneous
;;

;; One liner configs
(setq inhibit-startup-screen t)  ;; Disable startup screen
(global-display-line-numbers-mode)  ;; Display line numbers
(display-time-mode 1)  ;; Display time in modeline
(setq-default fill-column 79)  ;; set default fill width (e.g. M-q)
(display-time-mode 1)  ;; display time in modeline
(global-display-line-numbers-mode)  ;; display line numbers
(unbind-key "C-z" global-map)  ;; unbind keys
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))  ;; All backups to same dir
(xclip-mode 1)  ;; Enable clipboard when using emacs -nw

;; Additional syntax highlighting
(use-package markdown-mode
  :commands (markdown-mode)
  :mode (("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode)))

(use-package csv-mode
  :mode "\\.csv$"
  :init (setq csv-separators '(";")))

(use-package nix-mode)

(use-package json-mode)

(use-package julia-mode)

(use-package yaml-mode)

(use-package clojure-mode)

;; Adjusting window size
(define-key global-map (kbd "C-x C-<up>") 'enlarge-window)
(define-key global-map (kbd "C-x C-<down>") 'shrink-window)

;; Windmove -- easier window switching
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(global-set-key (kbd "C-c C-<left>")  'windmove-left)
(global-set-key (kbd "C-c C-<right>") 'windmove-right)
(global-set-key (kbd "C-c C-<up>")    'windmove-up)
(global-set-key (kbd "C-c C-<down>")  'windmove-down)


;; Zooming in/out globally
(defadvice text-scale-increase (around all-buffers (arg) activate)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      ad-do-it)))


;; Appearance

(use-package powerline
  :init
  (powerline-default-theme))


;; ;; Dracula theme customized
;; (load-theme 'dracula t)
;; (custom-theme-set-faces
;;  'dracula
;;  '(py-decorators-face ((t (:foreground "#bd93f9"))))
;;  '(py-object-reference-face ((t (:foreground "#ce537a"))))
;;  '(py-pseudo-keyword-face ((t (:foreground "#ffb86c"))))
;;  '(py-variable-name-face ((t (:foreground "#8be9fd"))))
;;  '(py-number-face ((t (:foreground "#bd93f9")))))


;; Spacemacs dark customized
(load-theme 'spacemacs-dark t)
(custom-theme-set-faces
 'spacemacs-dark
 '(font-lock-comment-delimiter-face ((t (:foreground "#2aa1ae"))))
 '(py-decorators-face ((t (:foreground "#4f97d7"))))
 '(py-object-reference-face ((t (:foreground "#ce537a"))))
 '(py-pseudo-keyword-face ((t (:foreground "#a45bad"))))
 '(py-variable-name-face ((t (:foreground "#7590db"))))
 '(py-exception-name-face ((t (:foreground "#ce537a" :weight bold))))
 '(py-builtins-face ((t (:foreground "#bc6ec5"))))
 '(py-number-face ((t (:foreground "#a45bad")))))

;; Highlighting some comment keywords
(font-lock-add-keywords 'python-mode
			'(("\\<\\(TODO\\):" 1 font-lock-warning-face prepend)
			  ;;("\\<\\(__.+__\\)" . font-lock-constant-face)
			  ;;("@.+\\b" . font-lock-function-name-face)
			  ("\\<\\(FIXME\\):" 1 font-lock-warning-face prepend)
			  ("\\<\\(XXX\\):" 1 font-lock-warning-face prepend)
			  ("\\<\\(NOTE\\):" 1 font-lock-warning-face prepend)))
