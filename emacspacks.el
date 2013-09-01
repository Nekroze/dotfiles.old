; Package list
(setq package-list '(marmalade makefile-runner org
			       color-theme-solarized
			       markdown-mode git-commit
			       git-commit-mode flycheck flymake
			       auto-complete auto-indent-mode
			       d-mode gitignore-mode highlight
			       lineno marmalade python
			       starter-kit starter-kit-bindings
			       idomenu ido-ubiquitous jinja2-mode))
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
