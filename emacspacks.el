; Package list
(setq package-list '(marmalade makefile-runner org color-theme
                               ample-zen-theme markdown-mode
                               git-commit git-commit-mode
                               gitconfig gitignore-mode flycheck
                               flymake auto-complete
                               auto-indent-mode lineno marmalade
                               python starter-kit
                               starter-kit-bindings idomenu
                               ido-ubiquitous lua-mode
                               flymake-lua d-mode flymake-d))
; Repositories
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/"))
)

; Activate packages
(package-initialize)

; Get available packages
(when (not package-archive-contents)
  (package-refresh-contents))

; Install missing packages
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package))
)
