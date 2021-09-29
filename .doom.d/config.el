;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Dmytro Holubiev"
      user-mail-address "a1extra3a@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; remove emphasis markers i org-mode
(use-package org
  :config
  (setq org-hide-emphasis-markers t))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; use movement in russin keyboard layouts
(use-package reverse-im
  :ensure t
  :custom
  (reverse-im-input-methods '("russian-computer" "ukrainian-computer" "programmer-dvorak"))
  :config
  (reverse-im-mode t))

;; set filetype to web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-hook! web-mode
  (flycheck-select-checker 'web-php)
 (setq web-mode-ac-sources-alist
      '(("css" . (ac-source-words-in-buffer ac-source-css-property))
        ("html" . (ac-source-words-in-buffer ac-source-abbrev))
        ("php" . (ac-source-words-in-buffer
                  ac-source-words-in-same-mode-buffers
                  ac-source-dictionary)))))

(map! :ne "SPC t v" #'visual-line-mode)
(map! :ne "SPC o n" #'neotree-toggle)

;;; web-beautify.el --- Format HTML, CSS and JavaScript/JSON

;; Copyright (C) 2013-2016 Yasuyuki Oka and web-beautify contributors

;; Author: Yasuyuki Oka <yasuyk@gmail.com>
;; Version: 0.3.2
;; URL: https://github.com/yasuyk/web-beautify

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Add the following to your Emacs init file.

;;     (require 'web-beautify) ;; Not necessary if using ELPA package
;;     (eval-after-load 'js2-mode
;;       '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
;;     (eval-after-load 'json-mode
;;       '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))
;;     (eval-after-load 'sgml-mode
;;       '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))
;;     (eval-after-load 'css-mode
;;       '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))

;; If you want to automatically format before saving a file,
;; add the following hook to your Emacs configuration:

;;     (eval-after-load 'js2-mode
;;       '(add-hook 'js2-mode-hook
;;                  (lambda ()
;;                    (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

;;     (eval-after-load 'json-mode
;;       '(add-hook 'json-mode-hook
;;                  (lambda ()
;;                    (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

;;     (eval-after-load 'sgml-mode
;;       '(add-hook 'html-mode-hook
;;                  (lambda ()
;;                    (add-hook 'before-save-hook 'web-beautify-html-buffer t t))))


;; For more information, See URL https://github.com/yasuyk/web-beautify.


;;; Code:

(defvar web-beautify-html-program "html-beautify"
  "The executable to use for formatting HTML.")

(defvar web-beautify-css-program "css-beautify"
  "The executable to use for formatting CSS.")

(defvar web-beautify-js-program "js-beautify"
  "The executable to use for formatting JavaScript and JSON.")

(defconst web-beautify-args '("-"))

(defun web-beautify-command-not-found-message (program)
  "Construct a message about PROGRAM not found."
  (format
   "%s not found. Install it with `npm -g install js-beautify`."
   program))

(defun web-beautify-format-error-message (buffer-name)
  "Construct a format error message with BUFFER-NAME."
  (format
   "Could not apply web-beautify. See %s to for details."
   buffer-name))

(defun web-beautify-get-shell-command (program)
  "Join PROGRAM with the constant js-beautify args."
  (mapconcat 'identity (append (list program) web-beautify-args) " "))

(declare-function web-mode-reload "ext:web-mode")
(declare-function js2-mode "ext:js2-mode")

(defun web-beautify-reload ()
  "Reload mode to activate faces."
  (deactivate-mark)
  (cond ((eq major-mode 'web-mode)
         (web-mode-reload))
        ((eq major-mode 'js2-mode)
         (js2-mode))))

(defun web-beautify-format-region (program beginning end)
  "By PROGRAM, format each line in the BEGINNING .. END region."
  ;; Check that js-beautify is installed.
  (if (executable-find program)
      (let* ((output-buffer-name "*Web Beautify Errors*")
             (output-buffer (get-buffer-create output-buffer-name))
             ;; Stash the previous point/window positions so they can be
             ;; reclaimed after the buffer is replaced. Otherwise there is a
             ;; disturbing "jump" to vertically-center point after being
             ;; momentarily bounced to the top of the file.
             (previous-point (point))
             (previous-window-start (window-start))
             (shell-command (web-beautify-get-shell-command program)))
        ;; Run the command.
        (if (zerop (shell-command-on-region beginning end shell-command (current-buffer) t output-buffer t))
            (progn
              ;; Reclaim position for a smooth transition.
              (goto-char previous-point)
              (set-window-start nil previous-window-start)
              (message "Applied web-beautify.")
              (web-beautify-reload)
              (kill-buffer output-buffer))
          ;; Unfortunately an error causes the buffer to be replaced with
          ;; emptiness... so undo that. Kind of an ugly hack. But a
          ;; properly-configured web-beautify shouldn't encounter this much, if
          ;; ever.
          (undo)
          (message (web-beautify-format-error-message output-buffer-name))))
    (message (web-beautify-command-not-found-message program))))

(defun web-beautify-format-buffer (program)
  "By PROGRAM, format current buffer with EXTENSTION."
  (web-beautify-format-region program (point-min) (point-max)))

;;;###autoload
(defun web-beautify-html ()
  "Format region if active, otherwise the current buffer.
Formatting is done according to the html-beautify command."
  (interactive)
  (if (use-region-p)
      (web-beautify-format-region
       web-beautify-html-program
       (region-beginning) (region-end))
    (web-beautify-html-buffer)))

;;;###autoload
(defun web-beautify-html-buffer ()
  "Format the current buffer according to the html-beautify command."
  (web-beautify-format-buffer web-beautify-html-program))

;;;###autoload
(defun web-beautify-css ()
  "Format region if active, otherwise the current buffer.
Formatting is done according to the css-beautify command."
  (interactive)
  (if (use-region-p)
      (web-beautify-format-region
       web-beautify-css-program
       (region-beginning) (region-end))
    (web-beautify-css-buffer)))

;;;###autoload
(defun web-beautify-css-buffer ()
  "Format the current buffer according to the css-beautify command."
  (web-beautify-format-buffer web-beautify-css-program))

;;;###autoload
(defun web-beautify-js ()
  "Format region if active, otherwise the current buffer.
Formatting is done according to the js-beautify command."
  (interactive)
  (if (use-region-p)
      (web-beautify-format-region
       web-beautify-js-program
       (region-beginning) (region-end))
    (web-beautify-js-buffer)))

;;;###autoload
(defun web-beautify-js-buffer ()
  "Format the current buffer according to the js-beautify command."
  (web-beautify-format-buffer web-beautify-js-program))

 ;;;dvorak mode
;(use-package evil-dvorak
  ;:ensure t
  ;:config (global-evil-dvorak-mode 1)
  ;:diminish evil-dvorak-mode)

(provide 'web-beautify)

;; Local Variables:
;; coding: utf-8
;; eval: (checkdoc-minor-mode 1)
;; End:

;;; web-beautify.el ends here

;;;     (eval-after-load 'css-mode
;;;       '(add-hook 'css-mode-hook
;;;                  (lambda ()
;;;                    (add-hook 'before-save-hook 'web-beautify-css-buffer t t))))


;; create custom php-checker for web-mode
(flycheck-define-checker web-php
  "A PHP syntax checker using the PHP command line interpreter.

See URL `http://php.net/manual/en/features.commandline.php'."
  :command ("php" "-l" "-d" "error_reporting=E_ALL" "-d" "display_errors=1"
            "-d" "log_errors=0" source)
  :error-patterns
  ((error line-start (or "Parse" "Fatal" "syntax") " error" (any ":" ",") " "
          (message) " in " (file-name) " on line " line line-end))
  :modes (php-mode php+-mode web-mode))

;; telega
(setq telega-use-docker t) ;; use docker for start telega-server
(define-key global-map (kbd "C-c t") telega-prefix-map) ;; set global key for telega
(define-key global-map (kbd "C-M-t") 'telega) ;; start telega
(add-hook 'telega-load-hook 'telega-notifications-mode) ;; enable notifications
;; (add-hook 'telega-load-hook 'telega-mode-line-mode) ;; show status in statusline
(add-hook 'telega-load-hook 'telega-appindicator-mode)
