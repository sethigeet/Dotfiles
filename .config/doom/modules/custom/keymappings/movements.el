(map!
 ;; Move between buffers
 :desc "Goto next tab" :n (kbd "<C-tab>") #'next-buffer
 :desc "Goto previous tab" :n (kbd "<C-iso-lefttab>") #'previous-buffer
 )

(after! evil
  (map!
   ;; Move between buffers
   :desc "Goto next tab" :n (kbd "<tab>") #'next-buffer
   :desc "Goto previous tab" :n (kbd "<backtab>") #'previous-buffer

   :desc "Goto next tab" :n "H" #'next-buffer
   :desc "Goto previous tab" :n "L" #'previous-buffer

   ;; Move between splits
   :desc "Goto right split" :n "M-l" "C-w l"
   :desc "Goto left split" :n "M-h" "C-w h"
   :desc "Goto top split" :n "M-k" "C-w k"
   :desc "Goto top split" :n "M-j" "C-w j"

   ;; Resize splits
   :desc "Resize splits" :n "M-r" #'resize-window
   )
  )
