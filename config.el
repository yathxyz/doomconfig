;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Ioannis Eleftheriou"
      user-mail-address "me@yath.xyz"
      epg-user-id user-mail-address)

(setq doom-font (font-spec :family "Fira Code" :size 16))
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

(setq doom-theme 'doom-oksolar-dark)

(setq display-line-numbers-type 'relative)

(setq org-directory (getenv "WORKDIR"))


(setq! citar-bibliography (list (concat (getenv "WORKDIR") "librarium/library.bib")))

(map! :leader :desc "Insert org mode timestamp at point with current date and time"
      :n "y d t" #'insert-now-timestamp-inactive)
(setq! org-roam-directory (concat org-directory "roam/"))

(defun refresh-citar-bibliography ()
  (interactive)
  (setq! citar-bibliography
         (directory-files-recursively (concat (getenv "WORKDIR") "librarium/") "\\.bib$"))
  (message "Refreshed list of bib files!"))

(setq! citar-citeproc-csl-styles-dir "~/Zotero/styles/")

(setq! citar-library-paths
       (list (concat (getenv "WORKDIR") "librarium/")))

(setq! citar-notes-paths (list (concat org-roam-directory "references/")))

(map! :leader :desc "Toggle centered window mode" :n "y c" #'centered-window-mode)
(map! :leader :desc "Toggle automatic fill mode" :n "y a" #'auto-fill-mode)
(map! :leader :desc "Find bibliographic entry" :n "y b e" #'citar-open-entry)
(map! :leader :desc "Open document from bib entry" :n "y o" #'citar-open)
(map! :leader :desc "Fill region" :n "y w" #'fill-region)
;;(map! :leader :desc "Toggle global flycheck mode" :n "y f f f" #'global-flycheck-mode)
(map! :leader :desc "Refresh bib files" :n "y b r" #'refresh-citar-bibliography)
(map! :leader :desc "Open URL in bibtex entry" :n "y l" #'citar-open-links)
(map! :leader :desc "Toggle autocompletion" :n "y x" #'+company/toggle-auto-completion)
;;(map! :leader :desc "Quick ai prompt in the buffer" :n "y q" #'org-ai-prompt)

(setq org-journal-time-prefix "* "
      org-journal-date-format "%a, %Y-%m-%d"
      org-journal-file-format "%Y%m%d.org"
      org-journal-date-prefix "#+TITLE: ")

(setq deft-directory (concat (getenv "WORKDIR") "roam/"))
(setq company-idle-delay 0)

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))
