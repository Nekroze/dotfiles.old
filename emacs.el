;; package list
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(recentf-mode 1)

;; Change scratch buffer default mode
(setq initial-major-mode 'org-mode)

;; Remove scratch buffer message
(setq initial-scratch-message "")

;; Font
(set-face-attribute 'default nil :height 100)

;; Powerline Status
(add-to-list 'load-path "~/.emacs.d/powerline")
(require 'powerline)
(powerline-default-theme)

;; Change Keybinds
; Makes keeping emacs open for longer periods easier
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)
(global-set-key (kbd "C-x C-k") 'save-buffers-kill-emacs)
(global-set-key (kbd "C-x C-c") 'kill-this-buffer)

;;Markdown Mode
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))

;;Autofill Mode for org-mode
(add-hook 'org-mode-hook
          (lambda ()
            (set-fill-column 100)
          ))

;Flyspell in python comments
(add-hook 'python-mode-hook
          (lambda ()
            (set-fill-column 79)
            (flyspell-prog-mode)
            (auto-fill-mode 1)
          ))

;;Flyspell in ReST mode
(dolist (hook '(rst-mode-hook))
      (add-hook hook (lambda () (flyspell-mode 1))))

;;Flyspell in Markdown mode
(dolist (hook '(markdown-mode-hook))
      (add-hook hook (lambda () (flyspell-mode 1))))

;; easy spell check
(global-set-key (kbd "<f8>") 'ispell-word)
(global-set-key (kbd "C-S-<f8>") 'flyspell-mode)
(global-set-key (kbd "C-M-<f8>") 'flyspell-buffer)
(global-set-key (kbd "C-<f8>") 'flyspell-check-previous-highlighted-word)
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )
(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)

;;UTF 8 coding
(prefer-coding-system 'utf-8)

;; Enable backup files.
(setq make-backup-files t)
;;(setq make-backup-files nil)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;;line by line scroll
(setq scroll-step 1)
(setq scroll-conservatively 1)

;;Support Wheel Mouse Scrolling
(mouse-wheel-mode t)

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

(add-to-list 'load-path "~/.emacs.d")

;; Show line numbers in left margin
(global-linum-mode t)

;; Show column-number in the mode line
(column-number-mode 1)

;; Key configs
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [delete] 'delete-char)
(global-set-key [C-home] 'beginning-of-buffer)
(global-set-key [C-end] 'end-of-buffer)
(global-set-key "\C-z" 'undo) ; [Undo]

;; Cygwin fix for home and end keys 
(global-set-key "\M-[H" 'beginning-of-line)
(global-set-key "\M-[F" 'end-of-line)

;; ensure unix EOL
(setq inhibit-eol-conversion t)

;; ensure compile scrolls
(setq compilation-scroll-output t)

;; goto line
(global-set-key "\C-l" 'goto-line)

;; cmodes
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))
(defun stroustrup-common-hook ()
     (c-set-style "cc-mode")
     (setq tab-width 4 indent-tabs-mode nil)
)
(add-hook 'c-mode-common-hook 'stroustrup-common-hook)
;;; C programming style
(setq c-default-style "stroustrup" c-basic-offset 4)

;; run script
(defun python-run ()
  "Use compile to run python programs"
  (interactive)
  (message "Running python for buffer %s." (buffer-name))
  (compile (concat "python " (buffer-name)))
  )
(defun perl-run ()
  "Use compile to run perl programs"
  (interactive)
  (message "Running perl for buffer %s." (buffer-name))
  (compile (concat "perl -w " (buffer-name)))
  )
(defun script-run ()
  "Use to run a script"
  (interactive)
  (if (equal (file-name-extension(buffer-name)) "py")
      (python-run))
  (if (equal (file-name-extension(buffer-name)) "pl")
      (perl-run))
  )
(global-set-key [f5] 'script-run)

;; Org-mode settings
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'flyspell-mode)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-font-lock-mode 1)

;; Remove hl line mode from starter kit
(remove-hook 'coding-hook 'turn-on-hl-line-mode)

;; colorize compilation buffer
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; Auto Complete
(when (require 'auto-complete-config nil 'noerror) ;; don't break if not
  ;; installed  
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
  (setq ac-comphist-file  "~/.emacs.d/ac-comphist.dat")
  (ac-config-default))

;; Set theme
(load-theme 'ample-zen t)
