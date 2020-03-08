
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


;;; Code:
(require 'package)
(add-to-list 'package-archives '("MELPA"."http://melpa.milkbox.net/packages/") t)
(package-initialize)
(eval-when-compile
  (require 'use-package))

(use-package benchmark-init
  :ensure t
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))


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
    (evil-tutor evil benchmark-init stan-mode phi-search ace-window avy web-mode graphviz-dot-mode clojure-mode json-mode csv-mode yaml-mode julia-mode nix-mode xclip list-packages-ext markdown-mode powerline diredfl js2-refactor spacemacs-dark dracula-theme expand-region hydra exec-path-from-shell python-mode rainbow-mode fill-column-indicator solidity-flycheck flycheck multi-term rg counsel-world-clock counsel wgrep ivy magit org-journal))))


;; Magit
(use-package magit
  :init
  (setq magit-repository-directories '(("~/src" . 1)))
  :bind (("C-x g" . magit-status)
         ("C-c M-g" . magit-file-dispatch)))


;; Org mode
(use-package org
  :defer 2
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
  (use-package org-journal
    :config
    (setq org-journal-dir "~/Documents/org/journal/"
	  org-journal-file-format "%Y%m%d.org"
	  org-journal-date-prefix "#+TITLE: Daily Notes "))
  (unbind-key "C-'" org-mode-map)
  (unbind-key "C-," org-mode-map)
  :bind (("C-c c" . org-capture)
	 ("C-c a" . org-agenda)))


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
  :bind (("C-:" . avy-goto-char)    ;; doesn't work in terminal
	 ("C-'" . avy-goto-char-2)  ;; doesn't work in terminal
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

(use-package wgrep
  :defer 2)

(use-package hydra
  :defer 2)

(use-package diredfl
  :commands diredfl-global-mode
  :init (diredfl-global-mode))


;;
;; Python development
;;

;; ;; SLOW startup
;; ;; -- needed for activating virtualenv below
;; (use-package exec-path-from-shell
;;   :commands exec-path-from-shell-initialize
;;   :init (exec-path-from-shell-initialize))

;; Anaconda mode
(use-package anaconda-mode
  :after exec-path-from-shell
  :commands (pythonic-activate
             pythonic-deactivate
             anaconda-eldoc-mode)
  :init
  ;; (defun activate (virtualenv)
  ;;   "Activate a virtual environment so that pytest recognizes it."
  ;;   (interactive "DEnv: ")
  ;;   (pythonic-activate virtualenv)
  ;;   (exec-path-from-shell-setenv
  ;;    "PATH"
  ;;    (string-join (python-shell-calculate-exec-path) ":")))
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode))

;; Pytest
(use-package python-pytest
  :bind ("C-c t" . python-pytest-popup))

;; Flycheck
;; TODO: Make function that loads the desired virtual environment

(use-package flycheck
  :defer 5
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

(use-package js2-mode
  :ensure t
  :mode "\\.js\\'")

(use-package rjsx-mode
  :ensure t
  :mode "\\.js\\'")

(use-package web-mode
  :mode (("//.html//'" . web-mode)
	 ("//.css//'" . web-mode)))

;;
;; Multiline editing
;;

(use-package expand-region
  :after (org)
  :bind ("C-." . er/expand-region)
  :init
  (require 'expand-region)
  (require 'cl)
  (defun mark-around* (search-forward-char)
    ;; Linting gives a warning `mark-around* not known to be defined
    ;; -- can be avoided by setting above
    ;; -- (declare-function mark-around* "init" ())
    (let* ((expand-region-fast-keys-enabled nil)
           (char (or search-forward-char
                     (char-to-string
                      (read-char "Mark inner, starting with:"))))
           (q-char (regexp-quote char))
           (starting-point (point)))
      (when search-forward-char
        (search-forward char (point-at-eol)))
      (cl-flet ((message (&rest args) nil))
        (er--expand-region-1)
        (er--expand-region-1)
        (while (and (not (= (point) (point-min)))
                    (not (looking-at q-char)))
          (er--expand-region-1))
        (er/expand-region -1))))
  (defun mark-around ()
    (interactive)
    (mark-around* nil))
  (define-key global-map (kbd "M-i") 'mark-around))

(use-package multiple-cursors
  :defer 2
  :init
  (define-key global-map (kbd "C-'") 'mc-hide-unmatched-lines-mode)
  (define-key global-map (kbd "C-,") 'mc/mark-next-like-this)
  (define-key global-map (kbd "C-;") 'mc/mark-all-dwim))

(use-package phi-search
  :after multiple-cursors
  :init (require 'phi-replace)
  :bind ("C-:" . phi-replace)
  :bind (:map mc/keymap
              ("C-s" . phi-search)
              ("C-r" . phi-search-backward)))


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
(define-key global-map "\C-a" 'back-to-indentation)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))  ;; All backups to same dir
(xclip-mode 1)  ;; Enable clipboard when using emacs -nw
(delete-selection-mode 1)  ;; Overwrite selection
(setq column-number-mode t)  ;; Display column numbers
(add-hook 'before-save-hook 'delete-trailing-whitespace)  ;; Delete trailing whitespace
(add-to-list 'auto-mode-alist '(".gitignore" . sh-mode))  ;; Syntax highlight in .gitignore
;; SLOW startup
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

;; Scroll screen
(define-key global-map "\M-n" 'scroll-up-line)
(define-key global-map "\M-p" 'scroll-down-line)

;; Additional syntax highlighting
(use-package markdown-mode
  :commands (markdown-mode)
  :mode (("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode)))

(use-package csv-mode
  :mode "\\.csv\\'"
  :init (setq csv-separators '(";")))

(use-package graphviz-dot-mode
  :defer 5)

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package json-mode
  :mode "\\.json\\'")

(use-package julia-mode
  :mode "\\.jl\\'")

(use-package yaml-mode
  :mode (("\\.yaml\\'" . yaml-mode)
	 ("\\.yml\\'" . yaml-mode)))

(use-package clojure-mode
  :mode (("\\.clj\\'" . clojure-mode)
	 ("\\.cljs\\'" . clojure-mode)
	 ("\\.cljc\\'" . clojure-mode)
	 ("\\.edn\\'" . clojure-mode)))

(use-package stan-mode
  :mode "\\.stan\\'")

;; Adjusting window size
(define-key global-map (kbd "C-x C-<up>") 'enlarge-window)
(define-key global-map (kbd "C-x C-<down>") 'shrink-window)

;; Ace window
(global-set-key (kbd "M-o") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;;
;; Appearance
;;

;;
;; Fonts
;; SLOW startup
;; -- Find out current font: describe-font
(set-face-attribute 'default nil :height 120 :family "DejaVuSansMono")

(use-package powerline
  :defer 1
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


;; Spacemacs theme customized
(load-theme 'spacemacs-dark t)
(custom-theme-set-faces
 'spacemacs-dark
;; '(font-lock-comment-delimiter-face ((t (:foreground "#2aa1ae"))))
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

(provide 'init)
;;; init ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
