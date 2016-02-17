;;; org-publish-config.el --- publish org file to lust4life-site

;;; Commentary:

;;; Code;
(require 'ox-publish)

;;; Code:
(setq org-publish-project-alist '(
                                  ("org-notes"
                                   :base-directory "e:/git/blog.site.src/src/org/"
                                   :publishing-directory "e:/git/blog.site.src/src/org-html/"
                                   :recursive t
                                   :publishing-function org-html-publish-to-html
                                   :auto-sitemap t
                                   :exclude "20\(08\|09\|10\|11\|12\|13\|14\)+"
                                   :section-numbers nil
                                        ;:sitemap-sort-files anti-chronologically ;; 这里会导致程序无响应
                                   )

                                  ("lust4life" :components ("org-notes"))
                                  ))

;; debug async export
(setq org-export-async-debug t)

(defun publish-lust4life-site nil
  "Publish lust4life site project."
  (interactive)
  (org-publish-project "lust4life" nil t)
  )

(provide 'org-publish-config)

;;; org-publish-config.el ends here
