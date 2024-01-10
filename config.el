;; Fill Column Settings
;; First we set the width and then we display it.
(setq-default display-fill-column-indicator-column 80)
(global-display-fill-column-indicator-mode)

;;  Org specific column width setting. When opening a raw file, besides lines
;;  with latex code, everything will obey an 80 column width restriction. Org
;;  mode indents your lines visually however, and so this is here to offset that
;;  visually in order to keep me from being constrained to something like 50
;;  character on average.
(defun set-fill-column-based-on-header ()
  (when (eq major-mode 'org-mode)
    (save-excursion
      (beginning-of-line)
      (let ((level (org-current-level)))
        (setq-default display-fill-column-indicator-column
                      (if level (+ 80 (* 2 level)) 80))))))


;;  Update the fill column after navigation commands.
(defun org-update-fill-column-after-navigation (&rest _)
  (set-fill-column-based-on-header))

;; Advise navigation functions. These are non destructive additions to the regular
;; functions of these name. Nice feature if you ask me.
(advice-add 'evil-backward-char :after 'org-update-fill-column-after-navigation)
(advice-add 'evil-next-line :after 'org-update-fill-column-after-navigation)
(advice-add 'evil-previous-line :after 'org-update-fill-column-after-navigation)
(advice-add 'evil-forward-char :after 'org-update-fill-column-after-navigation)


;;  This was instructed for me to do here:
;;  https://orgmode.org/worg/org-contrib/babel/languages/ob-doc-scheme.html
;;  So that I can run scheme code with geiser in source code blocks in org mode.
(org-babel-do-load-languages
 'org-babel-load-languages
 '((scheme . t)))

;;  Scheme org mode source code block boilerplate
(defun scheme-output-boilerplate ()
  (interactive)
  (let ((name (read-string "Enter block name: ")))
    (insert "#+name: " name "\n")
    (insert "#+begin_src scheme :results output :noweb yes\n")
    (insert "\n")
    (insert "\n")
    (insert "\n")
    (insert "#+end_src\n")
    (forward-line -3)))

(global-set-key (kbd "C-c b s") 'scheme-output-boilerplate)

;;  Scheme org mode literal block boilerplate
(defun literal-boilerplate ()
  (interactive)
  (let ((name (read-string "Enter block name: ")))
    (insert "#+name: " name "\n")
    (insert "#+begin\n")
    (insert "\n")
    (insert "\n")
    (insert "\n")
    (insert "#+end\n")
    (forward-line -3)))

(global-set-key (kbd "C-c b l") 'scheme-output-boilerplate)