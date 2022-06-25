(defun custom/save-without-formatting ()
  (interactive)
  (format-all-mode -1)
  (save-buffer)
  (format-all-mode +1)
  )

(map!
 :desc "Save the current file" :n "C-s" #'save-buffer
 :desc "Save the current file without formatting" :n "M-s" #'custom/save-without-formatting
 ;; :desc "Duplicate current line" :n (kbd "yp") "yyp"
 :desc "Close current buffer" :n "X" #'kill-current-buffer
 :desc "Open terminal" :n "`" #'+vterm/toggle

  :desc "Duplicate selected line" :n "M-y" #'avy-copy-line
  :desc "Duplicate selected region" :n "M-Y" #'avy-copy-region

 (:prefix "g"
  :desc "Duplicate line" :n "y" "yyp"
  :desc "Duplicate lines and comment original" :v "Y" #'evilnc-copy-and-comment-lines
  )

 (:leader
  :desc "Paste without yanking" :n "p" "\"_dPP")
 )
