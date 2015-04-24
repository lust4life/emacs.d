;; author: $+J
;; e-mail: lust4life.jun@gmail.com


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

;; 替换默认的 cperl mode
(require 'prelude-perl)

;; directory tree
(require 'dirtree)

;; enable linum mode
(global-linum-mode 1) ; Always show line numbers
(setq linum-format "%d") ; set format


;; Setting English Font
(set-face-attribute 'default nil :family "Input 11")

;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Microsoft YaHei UI" :size 14)))


;; run as a server mode
(server-start)


;; add org-page blog system static page generate
(require 'org-page)
(setq op/repository-directory "e:/git/lust4life/")   ;; the repository location
(setq op/site-domain "http://lust4life.github.io/")         ;; your domain
;;; the configuration below you should choose one, not both
(setq op/personal-disqus-shortname "lust4life")    ;; your disqus commenting system

;; about erc

;; joining && auto joinning
(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
      '((".*\\.freenode.net" "#emacs" "#perl" "#perl6" "##csharp" "##asp.net")))

;; check channels
(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE" "324" "329" "332" "333" "353" "477"))

;; don't show any of this
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

(defun djcb-erc-start-or-switch ()
  "Connect to ERC, or switch to last active buffer"
  (interactive)
  (if (get-buffer "irc.freenode.net:6667") ;; ERC already active?
      (erc-track-switch-buffer 1) ;; yes: switch to last active
    (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC
      (erc :server "irc.freenode.net" :port 6667 :nick "lustlife" :full-name "lustlife.Jun" :password "lust4life"))))

;; switch to ERC with Ctrl+c e
(global-set-key (kbd "C-c e") 'djcb-erc-start-or-switch) ;; ERC


;; use for paste clipboard image to org-mode

(defun paste-img ()
  "paste the img from clipboard to org-buffer int the same directory and insert a link "
  (interactive)

  (setq foldername (concat (buffer-file-name) "-IMG/"))
  (if (not (file-exists-p foldername))
      (mkdir foldername))

  ;; (setq imgName (concat "img_" (format-time-string "%Y_%m_%d__%H_%M_%S") ".png"))
  (setq imgName (read-string "fileName:"))
  (setq imgPath (concat (buffer-name) "-IMG/" imgName))

  (call-process "perl" nil nil nil "E:/git/quick.dirty.perl/Perl STH/tools/pasteIntoFile.pl" (concat "-f=" imgPath))

  (setq relativeFilename (concat "./" imgPath))

  (insert (concat "[[" relativeFilename "]]"))
  )

(global-set-key (kbd "C-c v") 'paste-img)

;; exports your Org documents to reveal.js presentations
(require 'ox-reveal)

;; 配置 org-publish
(require 'org-publish-config)


(provide 'init-local)
