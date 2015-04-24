;;; org-publish-config.el --- publish org file to lust4life-site

;;; Commentary:

;;; Code;
(require 'ox-publish)

;;; Code:
(setq org-publish-project-alist '(
                                  ("org-notes"
                                   :base-directory "e:/git/lust4life/src/org/"
                                   :publishing-directory "e:/git/lust4life/src/org/org-html/"
                                   :recursive t
                                   :publishing-function org-html-publish-to-html
                                   :auto-sitemap t
                                   :sitemap-filename "categories.org"
                                   :sitemap-title "Categories"
                                   )

                                  ("org-static"
                                   :base-directory "e:/git/lust4life/src/org/"
                                   :base-extension "jpg|mp4"
                                   :publishing-directory "e:/git/lust4life/src/org/org-html/"
                                   :recursive t
                                   :publishing-function org-publish-attachment
                                   )

                                  ("lust4life" :components ("org-notes" "org-static"))
                                  ))

(defun publish-lust4life-site nil
  "Publish lust4life site project."
  (interactive)
  (org-publish-project "lust4life")
  )

(provide 'org-publish-config)

;;; org-publish-config.el ends here
