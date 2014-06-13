;; author: $+J
;; e-mail: lust4life.jun@gmail.com


;; 半透明
(when window-system
  (setq alpha-list '((80 50) (100 100)))
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
(set-face-attribute
'default nil :font "PragmataPro")

;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
(set-fontset-font (frame-parameter nil 'font)
charset
(font-spec :family "Microsoft YaHei UI" :size 10)))



(provide 'init-local)
