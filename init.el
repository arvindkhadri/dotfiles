;;; package --- load necessary files and set custom variables
;;; Commentary: The first file that gets loaded when emacs is started

;;; Code:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(android-mode-sdk-dir "/home/zoso/Projects/opt/android-sdk-linux")
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#839496" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#002b36"))
 '(c-basic-offset 2)
 '(css-indent-offset 2)
 '(custom-enabled-themes (quote (sanityinc-solarized-light)))
 '(custom-safe-themes
   (quote
    ("4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(custom-theme-directory "~/.emacs.d/themes/")
 '(fci-rule-color "#073642")
 '(flycheck-phpcs-standard "Drupal,DrupalPractice")
 '(flycheck-python-flake8-executable "/usr/bin/flake8-python2")
 '(js2-basic-offset 2)
 '(js2-bounce-indent-p t)
 '(json-reformat:indent-width 2)
 '(org-agenda-files (quote ("~/Projects/Orgfiles/test.org")) t)
 '(org-html-use-infojs t)
 '(php-mode-coding-style (quote drupal))
 '(py-shell-name "/usr/bin/ipython")
 '(python-indent-guess-indent-offset nil)
 '(python-indent-offset 4)
 '(safe-local-variable-values (quote ((todo-categories "Important" "Todo"))))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#cb4b16")
     (60 . "#b58900")
     (80 . "#859900")
     (100 . "#2aa198")
     (120 . "#268bd2")
     (140 . "#d33682")
     (160 . "#6c71c4")
     (180 . "#dc322f")
     (200 . "#cb4b16")
     (220 . "#b58900")
     (240 . "#859900")
     (260 . "#2aa198")
     (280 . "#268bd2")
     (300 . "#d33682")
     (320 . "#6c71c4")
     (340 . "#dc322f")
     (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(neo-file-link-face ((t (:foreground "white")))))

;;;;; Code:
(add-to-list 'auto-mode-alist '("\\.wsgi$" . python-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("zshrc" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . js2-mode))

;;Line numbers by default
(require 'linum)
(global-linum-mode 1)


;; auto-fill mode on
(auto-fill-mode 1)

;;For snippets
;; (add-to-list 'load-path "/home/zoso/Projects/yasnippet")
;; (require 'yasnippet)
;; (yas/global-mode 1)


(require 'battery)
(display-battery-mode 1)

;;For python IDE
(load-file "/home/zoso/Projects/emacs-for-python/epy-init.el") ;;Emacs for
;;python

;; (require 'comint)
;; (define-key comint-mode-map (kbd "M-n") 'comint-next-input)
;; (define-key comint-mode-map (kbd "M-p") 'comint-previous-input)
;; (define-key comint-mode-map [down] 'comint-next-matching-input-from-input)
;; (define-key comint-mode-map [up] 'comint-previous-matching-input-from-input)

;; (autoload 'pylookup-lookup "pylookup")
;; (autoload 'pylookup-update "pylookup")
;; (setq pylookup-program "/home/zoso/Projects/awesome/pylookup.py")
;; (setq pylookup-db-file "/home/zoso/Projects/awesome/pylookup.db")
;; (load-file "/home/zoso/Projects/awesome/pylookup.el")
;; (global-set-key "\C-ch" 'pylookup-lookup)

(add-hook 'python-mode-hook
          #'(lambda () (push '(?' . ?')
                             (getf autopair-extra-pairs :code))
              (setq autopair-handle-action-fns
                    (list #'autopair-default-handle-action
                          #'autopair-python-triple-quote-action))))

(require 'epy-setup)
(require 'epy-python)
(require 'epy-completion)
(require 'epy-editing)
(epy-setup-ipython)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq flycheck-check-syntax-automatically '(mode-enabled save new-line))
(add-hook 'after-init-hook #'global-flycheck-mode)


;;(require 'w3m-load)
;; (require 'mime-w3m)
;; (setq browse-url-browser-function 'w3m-browse-url)
;; (setq browse-url-default-browser "w3m")
;; (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; ;; optional keyboard short-cut
;;  (global-set-key "\C-xm" 'browse-url-at-point)

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
;; M-x rename-file-and-buffer to rename the file and the buffer. TODO Use a keystroke to do this.
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(global-set-key (kbd "\C-c r") 'rename-file-and-buffer)



;;Binding newline-and-indent to RET for python mode
(add-hook 'python-mode-hook '(lambda ()
                               (local-set-key (kbd "RET") 'newline-and-indent)))


;;org-mode customization
(setq org-agenda-files (list "/home/zoso/Projects/Orgfiles/org"))
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;;ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;;indentation and tab setup
;; set tabs mode to be disabled, DO NOT MIX tabs and spaces ever!
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default standard-indent 4)
(setq-default tab-stop-list '(0 4 8 12 16 20 24 28 32))
(setq-default fill-column 79)


;;el-get like apt-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
        (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)


;;Set package repos
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
;;Load org mode themes
(add-to-list 'load-path "~/.emacs.d/themes/")
;; (require 'color-theme) ; tells Emacs to always enable color-theme mode
;; (color-theme-initialize) ; not necessary for the Solarized colors, but this
                                        ; tells Emacs to load all the color-themes at
                                        ; startup so that you can immediately switch
                                        ; between them if you wish

;; (load "color-theme-zenburn")
;; (load "color-theme-tangotango")
;; (load "color-theme-zenash")
;; (load "color-theme-solarized")
;; (color-theme-solarized-dark)
;; (setq my-color-themes (list
;;                        'color-theme-zenburn
;;                        'color-theme-tangotango
;;                        'color-theme-zenash
;;                        'color-theme-solarized-dark
;;                        ))

;; (defun my-theme-set-default () ; Set the first row
;;   (interactive)
;;   (setq theme-current my-color-themes)
;;   (funcall (car theme-current)))

;; (defun my-describe-theme () ; Show the current theme
;;   (interactive)
;;   (message "%s" (car theme-current)))

;;                                         ; Set the next theme (fixed by Chris Webber - tanks)
;; (defun my-theme-cycle ()
;;   (interactive)
;;   (setq theme-current (cdr theme-current))
;;   (if (null theme-current)
;;       (setq theme-current my-color-themes))
;;   (funcall (car theme-current))
;;   (message "%S" (car theme-current)))

;; (setq theme-current my-color-themes)
;; (setq color-theme-is-global nil) ; Initialization
;; (my-theme-set-default)
;; (global-set-key [f4] 'my-theme-cycle)

;;Set magit-status to bind with f6
(global-set-key [f6] 'magit-status)

;; Set neotree-toggle to bind with f8
(global-set-key [f8] 'neotree-toggle)

;;Set C-cd to bind with delete-region
(global-set-key (kbd "\C-d") 'delete-region)

;; Start jedi when python mode starts.
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; Aliasing utf-8 to UTF-8, mule constantly keeps asking to change utf-8
;; as it is not recognized.
(define-coding-system-alias 'UTF-8 'utf-8)

;; Setup for elfeed

(global-set-key [f7] 'elfeed)
(setq elfeed-feeds
      '("https://news.ycombinator.com/rss"))


;; Switch on rainbow-delimiters-mode
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Set android-mode sdk dir
(require 'android-mode)

;; Set keybinding for vc-git-grep
(global-set-key (kbd "\C-x v f") 'vc-git-grep)

;; Scrum boards in org
;; (load-file "/home/zoso/Projects/awesome/scrum.el")
;; (require 'scrum)

;; Load gh-md.el
(load-file "/home/zoso/Projects/dotfiles/gh-md.el")
(require 'gh-md)

;; Set hooks of js2-mode for jscs
(add-hook 'js2-mode-hook #'jscs-indent-apply)

;; Set keybinding for split-window-horizontal/vertical
(global-set-key (kbd "\C-x -") 'split-window-vertically)
(global-set-key (kbd "\C-x |") 'split-window-horizontally)

;; Set offset of case label in c-mode
;; php-mode uses c-mode vars \o/
(add-hook 'php-mode-hook
          (lambda () (c-set-offset 'case-label 2)))
;; Enable smartparens in all the buffers
(require 'smartparens)
('smartparens-global-mode 1)

;; Customize php-mode to use ac-php for auto completion
(require 'cl)
(require 'php-mode)
(add-hook 'php-mode-hook
          '(lambda ()
             (auto-complete-mode t)
             (require 'ac-php)
             ;;(setq ac-php-use-cscope-flag  t ) ;;enable cscope
             (setq ac-sources  '(ac-source-php ) )
             (yas-global-mode 1)
             (define-key php-mode-map  (kbd "C-]") 'ac-php-find-symbol-at-point)   ;goto define
             (define-key php-mode-map  (kbd "C-t") 'ac-php-location-stack-back   ) ;go back
             ))
(provide 'init)
;;; init.el ends here
