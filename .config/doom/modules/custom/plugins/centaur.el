;; Keymaps
(map!
 :desc "Goto next tab" :n (kbd "<C-tab>") #'centaur-tabs-forward
 :desc "Goto next tab" :n (kbd "<C-iso-lefttab>") #'centaur-tabs-backward)

(map!
 :n (kbd "M-1") "1gt"
 :n (kbd "M-2") "2gt"
 :n (kbd "M-3") "3gt"
 :n (kbd "M-4") "4gt"
 :n (kbd "M-5") "5gt"
 :n (kbd "M-6") "6gt"
 :n (kbd "M-7") "7gt"
 :n (kbd "M-8") "8gt"
 :n (kbd "M-9") "9gt"
 )


(after! evil
  (map!
   :desc "Goto next tab" :n (kbd "<tab>") #'centaur-tabs-forward
   :desc "Goto next tab" :n (kbd "<backtab>") #'centaur-tabs-backward))

;; TODO: Remove this after this issue is fixed: https://github.com/doomemacs/doomemacs/issues/6280
(after! centaur-tabs
  (centaur-tabs-group-by-projectile-project))
