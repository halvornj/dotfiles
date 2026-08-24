;;; -*- lexical-binding: t -*-


(require 'package)
(add-to-list 'package-archives
                                '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

(use-package jetbrains-darcula-theme
  :config
  (load-theme 'jetbrains-darcula t))

(require 'dashboard)
(dashboard-setup-startup-hook)
(setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
(setq dashboard-display-icons-p t)     ; display icons on both GUI and terminal
(setq dashboard-icon-type 'nerd-icons) ; use `nerd-icons' package
(setq dashboard-center-content t)
(setq dashboard-vertically-center-content t)

;; !IMPORTANT! run M-x nerd-icons-install-fonts.
(require 'nerd-icons)
(setq nerd-icons-color-icons nil) ;; disable color icons.
(require 'nerd-icons-dired) ;; icons for dired
(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)

;; (global-hl-line-mode)

;;(set-face-attribute 'default nil :family "JetBrainsMono Nerd Font")
;;(add-to-list 'default-frame-alist
;;	     '(font . "JetbrainsMono Nerd Font-12"))

(tool-bar-mode 0)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(setq auto-save-default nil)
(setq sgml-quick-keys 'close)

(require 'simple-httpd)

(require 'magit)

(define-key global-map (kbd "C-c g") 'magit-status)

;; modeline
(require 'doom-modeline)
(doom-modeline-mode 1)
;;(setq doom-modeline-major-mode-icon 0)
;; (setq doom-modeline-major-mode-color-icon nil)


;; dired auto-readme
(require 'dired-auto-readme)
(setq dired-auto-readme-file '("manifest\\W" ;; lets exclude manifest.jar
                               "readme\\.\\(org\\|rst\\|md\\|markdown\\)"))
(add-hook 'dired-mode-hook 'dired-auto-readme-mode)

;; dired git info
(require 'dired-git-info)
(add-hook 'dired-after-readin-hook 'dired-git-info-auto-enable)

;; org mode
;; (setq org-startup-folded t)


 '(package-selected-packages
   '(auctex dashboard dired-auto-readme dired-git-info doom-modeline
	    jetbrains-darcula-theme magit nerd-icons-dired
	    simple-httpd))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; LaTeX
(require 'pdf-tools)
(require 'auctex)
(setq +latex-viewers '(pdf-tools))



 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(auctex dashboard dired-auto-readme dired-git-info doom-modeline
	    jetbrains-darcula-theme magit nerd-icons-dired pdf-tools
	    simple-httpd))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection
   '(((output-dvi has-no-display-manager) "dvi2tty")
     ((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi")
     (output-pdf "PDF Tools") (output-html "xdg-open"))))
