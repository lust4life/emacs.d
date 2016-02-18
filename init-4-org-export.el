(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files nil)
 '(org-export-async-init-file nil)
 '(org-export-default-language "zh")
 '(org-export-with-section-numbers nil)
 '(org-html-doctype "html5")
 '(org-html-postamble t)
 '(org-html-postamble-format
   (quote
    (("zh" "<p class=\"author\">Author: %a (%e)</p>
            <p class=\"date\">Created: %d</p>
            <p>Modified: %C</p>
            <p class=\"creator\">Build With %c</p>
<p><a rel=\"license\" href=\"http://creativecommons.org/licenses/by-nc/4.0/\"><img alt=\"知识共享许可协议\" style=\"border-width: 0\" src=\"https://i.creativecommons.org/l/by-nc/4.0/88x31.png\"/></a></p>"))))
 '(org-html-preamble-format
   (quote
    (("zh" "  <p>Created : <span name=\"create-date\">%d</span></p>
  <p>Modified: <span name=\"modified-date\">%C</span></p>"))))
 '(org-reveal-root "http://lust4life.github.io/slide/reveal/")
 '(org-startup-truncated t))

;; debug async export
(setq org-export-async-debug t)
