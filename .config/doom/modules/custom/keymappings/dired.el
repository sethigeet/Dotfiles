(evil-define-key 'normal dired-mode-map
      (kbd "M-RET") 'dired-display-file

      ;; evil movements
      (kbd "h") 'dired-up-directory
      (kbd "l") 'dired-open-file ; use dired-open-file instead of dired-open.

      ;; marks
      (kbd "m") 'dired-mark
      (kbd "t") 'dired-toggle-marks
      (kbd "u") 'dired-unmark

      ;; file ops
      (kbd "Y") 'dired-do-copy
      (kbd "D") 'dired-do-delete
      (kbd "R") 'dired-do-rename
      (kbd "T") 'dired-do-touch
      (kbd "cp") 'dired-do-chmod
      (kbd "co") 'dired-do-chown

      ;; create
      (kbd "a") 'dired-create-empty-file
      (kbd "A") 'dired-create-directory

      ;; misc
      (kbd "J") 'dired-goto-file
      (kbd "P") 'dired-do-print
      (kbd "% l") 'dired-downcase
      (kbd "% u") 'dired-upcase
      )
