(defun package(packageName)
  "See if Package is installed, if not - install it"
  (unless (package-installed-p packageName) (package-install packageName)))

(require 'package)

(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/"))

(package-refresh-contents)
(package-initialize)

(package 'evil)
(package 'evil-collection)
(package 'dashboard)
(package 'doom-modeline)
(package 'page-break-lines)
(package 'writeroom-mode)

(package 'doom-themes)
(package 'all-the-icons)
(package 'all-the-icons-dired)
(package 'org-superstar)

(package 'haskell-mode)

(setq evil-want-integration t)
(setq evil-want-keybinding nil)

(setq evil-vsplit-window-right t)
(setq evil-split-window-above t)

(evil-mode)
(evil-collection-init)

(require 'dashboard)
(dashboard-setup-startup-hook)

(setq dashboard-show-shortcuts t)
(setq dashboard-banner-logo-title "Welcome to GNU Emacs")
(setq dashboard-startup-banner 'logo)

(setq dashboard-items '((recents . 7)
		  (bookmarks . 7)))


(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-page-separator "\n\f\n")

(dashboard-modify-heading-icons '((recents . "file-text")
	                          (bookmarks . "book")))

(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

(require 'page-break-lines)
(page-break-lines-mode)

(doom-modeline-mode 1)
(setq dashboard-modeline-hud t)
(setq dashboard-modeline-buffer-file-name-style 'truncate-upto-root)
(setq doom-modeline-height 30
      doom-modeline-bar-width 5
      doom-modeline-persp-name t
      doom-modeline-persp-icon t)

(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(load-theme 'doom-one t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(set-face-attribute 'default nil :family "Fira Code Retina" :height 140)

(setq display-line-numbers 'relative)
(global-display-line-numbers-mode 1)

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(setq dired-listing-switches "-aBhl --group-directories-first")

(global-set-key (kbd "s-k") 'kill-current-buffer)
(global-set-key (kbd "s-b") 'bookmark-set)
(global-set-key (kbd "s-d") 'dired)

(global-set-key (kbd "s-v") 'evil-window-vsplit)
(global-set-key (kbd "s-h") 'evil-window-split)

(global-set-key (kbd "s-i") 'ibuffer)
(global-set-key (kbd "s-x") 'toggle-write-mode)

(defun toggle-org-indenting ()
    (org-indent-mode))

(add-hook 'org-mode-hook 'toggle-org-indenting)
(add-hook 'org-mode-hook 'outline-hide-body)
(add-hook 'org-mode-hook 'electric-indent-mode)
