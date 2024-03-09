;; Fill Column Settings
;; First we set the width and then we display it.
(setq-default display-fill-column-indicator-column 80)
(global-display-fill-column-indicator-mode)

;;  Dynamic Org specific column width setting.
;;
;;  Org mode indents your lines visually (but not literally) under a header and
;;  so this is here to offset that in order to keep me from being constrained
;;  by the default 80 line character width to something like 50 characters on
;;  average.
;;
;;  When opening a raw file, everything will obey an 80 column width
;;  restriction.
(defun set-fill-column-based-on-header ()
  (if (eq major-mode 'org-mode)
      (save-excursion
        (beginning-of-line)
        (let ((level (org-current-level)))
          (setq-default display-fill-column-indicator-column
                        (if level (+ 80 (* 2 level)) 80))))
    ;; For any other major mode that isn't org-mode
    (setq-default display-fill-column-indicator-column 80)))

;;  Update the fill column after navigation commands.
(defun org-update-fill-column-after-navigation (&rest _)
  (set-fill-column-based-on-header))

;; Advise navigation functions. These are non destructive additions to the regular
;; functions of these name. Nice feature if you ask me.
(advice-add 'evil-backward-char :after 'org-update-fill-column-after-navigation)
(advice-add 'evil-next-line :after 'org-update-fill-column-after-navigation)
(advice-add 'evil-previous-line :after 'org-update-fill-column-after-navigation)
(advice-add 'evil-forward-char :after 'org-update-fill-column-after-navigation)
(advice-add 'evil-ret :after 'org-update-fill-column-after-navigation)


;; Keep the PDF's dark
(add-hook 'pdf-tools-enabled-hook 'pdf-view-midnight-minor-mode)
