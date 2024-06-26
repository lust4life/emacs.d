;;; init-local  --- init local
;;; Commentary:
;;; author: $+J
;;; e-mail: lust4life.jun@gmail.com
;;; Code:

;; exports your Org documents to reveal.js presentations
;; (require-package 'org-re-reveal)
;; (require 'org-re-reveal)
(require-package 'ox-reveal)
(require 'ox-reveal)

(require-package 'pdf-tools)
(require 'pdf-tools)
(require-package 'org-noter)
(require 'org-noter)

(require-package 'youdao-dictionary)
(require 'youdao-dictionary)
(require-package 'helm-org-rifle)
(require 'helm-org-rifle)

;; org-download
(require-package 'org-download)
(require 'org-download)

;; org-download
(require-package 'org-journal)
(require 'org-journal)

;; 替换默认的 cperl mode
(require 'prelude-perl)

;; 配置 org-publish
(require 'org-publish-config)

;; org mode customer
(setq org-startup-indented t)

;; 半透明
(when window-system
  (setq alpha-list '((90 75) (100 100)))
  (defun wf-toggle-alpha ()
    (interactive)
    (let ((h (car alpha-list)))
      ((lambda (a ab)
         (set-frame-parameter (selected-frame) 'alpha (list a ab))
         (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
         ) (car h) (car (cdr h)))
      (setq alpha-list (cdr (append alpha-list (list h))))))
  (wf-toggle-alpha))

;;; 设置中英文字体,方便 org table 对齐
;; Setting English Font
(set-face-attribute 'default nil :font (font-spec :name "FiraCode Nerd Font" :size 14))


(cond ((eq system-type 'darwin)
       (setq cn-font (font-spec :family "PingFang SC"))
       ;; do not set size in above, since this will affect when scale text, so only set rescale
       (setq face-font-rescale-alist (cons (cons cn-font 1.3) nil))
       (setq emoji-font "Apple Color Emoji"))
      ((eq system-type 'gnu/linux)
       (setq cn-font (font-spec :family "WenQuanYi Zen Hei")))
      ((eq system-type 'windows-nt)
       (setq cn-font (font-spec :family "KaiTi" :size 18))
       (setq emoji-font "Segoe UI Emoji")))

;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font t charset cn-font))

;; unicode symbol 🐈😿
(dolist (charset '(emoji))
  (set-fontset-font t charset emoji-font))


;;; about erc
(require 'erc-join)
;; joining && auto joinning
(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
      '((".*\\.freenode.net" "#emacs" "#org-mode" "#perl6" )))

;; check channels
(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE" "353"))

;; don't show any of this
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

(defun djcb-erc-start-or-switch ()
  "Connect to ERC, or switch to last active buffer"
  (interactive)
  (if (get-buffer "irc.freenode.net:6666") ;; ERC already active?
      (erc-track-switch-buffer 1) ;; yes: switch to last active
    (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC
      (erc :server "irc.freenode.net" :port 6666 :nick "lustlife" :full-name "lustlife.Jun" :password "lust4life"))))

;; switch to ERC with Ctrl+c e
(global-set-key (kbd "C-c e") 'djcb-erc-start-or-switch) ;; ERC


;;; use for paste clipboard image to org-mode

(defun paste-img ()
  "paste the img from clipboard to org-buffer int the same directory and insert a link "
  (interactive)

  ;; (setq foldername (concat (buffer-file-name) "-IMG/"))
  ;; (setq foldername "e:/git/lust4life/img/")
  ;; (if (not (file-exists-p foldername))
  ;; (mkdir foldername))

  ;; (setq imgName (concat "img_" (format-time-string "%Y_%m_%d__%H_%M_%S") ".png"))
  (setq imgName (read-string "fileName:"))
  (setq imgPath (concat "./img/" (replace-regexp-in-string "\.[^.]*$" "" (buffer-name)) "/" imgName))

  (call-process "perl" nil nil nil "E:/git/quick.dirty.perl/Perl STH/tools/pasteIntoFile.pl" (concat "-f=" imgPath))

  (insert (concat "[[" imgPath "]]"))
  )

(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq imgName (read-string "fileName:"))
  (setq imgName (concat imgName ".png"))
  ;; (setq filename
  ;;       (concat
  ;;        (make-temp-name
  ;;         (concat (buffer-file-name)
  ;;                 "_"
  ;;                 (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (setq filename (concat "./img/" (replace-regexp-in-string "\.[^.]*$" "" (buffer-name)) "/" imgName))
  (shell-command (concat "powershell -command \"Add-Type -AssemblyName System.Windows.Forms;if ($([System.Windows.Forms.Clipboard]::ContainsImage())) {$image = [System.Windows.Forms.Clipboard]::GetImage();[System.Drawing.Bitmap]$image.Save('" filename "',[System.Drawing.Imaging.ImageFormat]::Png); Write-Output 'clipboard content saved as file'} else {Write-Output 'clipboard does not contain image data'}\""))
  (insert (concat "[[file:" filename "]]"))
  (org-display-inline-images))

(global-set-key (kbd "C-c v") 'my-org-screenshot)

(setq system-time-locale "C")

;; global-display-line-mode
(global-display-line-numbers-mode 1)


;; display “lambda” as “λ”
(global-prettify-symbols-mode 1)


;; enable paredit in scheme
(add-hook 'scheme-mode-hook 'paredit-mode)

;; add support for oxs-dictionary
(require-package 'osx-dictionary)
(require 'osx-dictionary)

(global-set-key (kbd "C-c j") 'osx-dictionary-search-word-at-point)

;; set buffer name with word in osx-dictionary to let it create multi buffers
(setq osx-dictionary-generate-buffer-name-function
      (lambda (word)
        (format "*osx-dict-<%s>*" word)))

(provide 'init-local)
