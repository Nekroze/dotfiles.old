; Package list
(setq package-list '(marmalade makefile-runner org
                               solarized-theme markdown-mode
                               git-commit git-commit-mode
                               gitignore-mode flycheck flymake
                               auto-complete auto-indent-mode
                               lineno python starter-kit
                               starter-kit-bindings lua-mode
                               flymake-lua d-mode flymake-d
                               flylisp idomenu ido-ubiquitous
                               gitconfig))
; Repositories
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
                         )
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
