;; Fix the "s" key
(after! evil-snipe
  (evil-snipe-mode -1))
(map! :mode evil-motion-state-map
      :n "s" #'evil-substitute
      :n "S" #'evil-change-whole-line
      )

;; Fix the "y" key
(map!
 :n "Y" "y$")
