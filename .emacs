(set-language-environment "utf-8")

;;; Shouldn't these be in customize-set-variable?
(setq backup-directory-alist '(("." . "/home/gajon/.vim/backupfiles/")))
(setq-default indent-tabs-mode nil)
(setq-default indicate-buffer-boundaries 'left)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(ido-mode t)

(defalias 'qrr 'query-replace-regexp)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ColorTheme
;;; http://www.emacswiki.org/emacs/ColorTheme
;;; http://code.google.com/p/gnuemacscolorthemetest/
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
(require 'color-theme)
(require 'color-theme-folio)
(eval-after-load "color-theme"
  '(progn ;(color-theme-initialize)
    (color-theme-folio)))

(defun small-font ()
  (interactive)
  (set-frame-font "-*-terminus-medium-r-*-*-12-*-*-*-*-*-*-*" :keep-size))
(defun medium-font ()
  (interactive)
  (set-frame-font "-*-terminus-medium-r-*-*-14-*-*-*-*-*-*-*" :keep-size))
(defun large-font ()
  (interactive)
  (set-frame-font "-*-terminus-medium-*-*-*-20-*-*-*-*-*-*-*" :keep-size))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; SLIME
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(require 'slime)

(add-hook 'lisp-mode-hook (lambda ()
                            (slime-mode t)
                            (setq show-trailing-whitespace t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

(setq inferior-lisp-program "/home/gajon/Lisp/clbuild2/clbuild lisp"
      lisp-indent-function 'common-lisp-indent-function
      common-lisp-hyperspec-root "file:///home/gajon/Lisp/HyperSpec/"
      slime-complete-symbol-function 'slime-fuzzy-complete-symbol
      slime-autodoc-use-multiline-p nil
      slime-net-coding-system 'utf-8-unix
      ;; Invoke SLIME with a negative prefix, M-- M-x slime to select
      ;; a program from this list.
      slime-lisp-implementations '((sbcl ("/home/gajon/Lisp/clbuild2/clbuild" "lisp"))
                                   (clisp ("/usr/bin/clisp")))
      )

(slime-setup '(slime-fancy
               slime-banner
               ;slime-asdf
               ;slime-highlight-edits
               slime-indentation
               slime-sprof))

;;;
;;; Keybindings
;;;

(defun lisp-keys ()
  (interactive)
  (keyboard-translate ?\( ?\[)
  (keyboard-translate ?\[ ?\()
  (keyboard-translate ?\) ?\])
  (keyboard-translate ?\] ?\)))

(defun normal-keys ()
  (interactive)
  (keyboard-translate ?\( ?\()
  (keyboard-translate ?\[ ?\[)
  (keyboard-translate ?\) ?\))
  (keyboard-translate ?\] ?\]))

;(global-set-key (kbd "C-c l") 'goto-line)
(global-set-key (kbd "C-<backspace>") 'join-line)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key (kbd "s-h") 'help-command)
(global-set-key "\C-h" 'backward-delete-char-untabify)
(global-set-key [f5] 'call-last-kbd-macro)
(global-set-key "\C-cs" 'slime-selector)

(global-set-key [(shift delete)] 'clipboard-kill-region)
(global-set-key [(control insert)] 'clipboard-kill-ring-save)
(global-set-key [(shift insert)] 'clipboard-yank)

(define-key isearch-mode-map "\C-h" 'isearch-delete-char)

(define-key slime-mode-map (kbd "TAB") 'slime-indent-and-complete-symbol)
(define-key slime-mode-map (kbd "C-c ;") 'slime-insert-balanced-comments)
(define-key slime-mode-map (kbd "C-c M-;") 'slime-remove-balanced-comments)

(define-key slime-repl-mode-map (kbd "C-c ;") 'slime-insert-balanced-comments)
(define-key slime-repl-mode-map (kbd "C-c M-;") 'slime-remove-balanced-comments)

;; (define-key slime-mode-map (kbd "(") (lambda () (interactive) (insert-parentheses)))
;; (define-key slime-mode-map (kbd ")") (lambda () (interactive) (move-past-close-and-reindent)))
;; (define-key slime-repl-mode-map (kbd "(") (lambda () (interactive) (insert-parentheses)))
;; (define-key slime-repl-mode-map (kbd ")") (lambda () (interactive) (move-past-close-and-reindent)))
;; (define-key slime-mode-map (kbd "M-(") (lambda () (interactive) (insert "(")))
;; (define-key slime-repl-mode-map (kbd "M-(") (lambda () (interactive) (insert "(")))
;; (define-key slime-mode-map (kbd "M-)") (lambda () (interactive) (insert ")")))
;; (define-key slime-repl-mode-map (kbd "M-)") (lambda () (interactive) (insert ")")))


;; From: http://bc.tech.coop/blog/070425.html
(defun slime-new-repl (&optional new-port)
  "Create additional REPL for the current Lisp connection."
  (interactive)
  (if (slime-current-connection)
      (let ((port (or new-port (slime-connection-port (slime-connection)))))
	(slime-eval `(swank::create-server :port ,port))
	(slime-connect slime-lisp-host port))
    (error "Not connected")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CUSTOMIZE
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(scroll-bar-mode nil)
 '(scroll-conservatively 5)
; '(scroll-step 3)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(menu-bar-mode nil))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "xos4" :family "Terminus")))))
