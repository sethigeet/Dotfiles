;; Theme
;; (setq doom-theme 'doom-tokyo-night)
(setq doom-theme 'doom-one)

;; Fonts
(setq doom-font (font-spec :family "Fira Code Nerd Font" :size 18 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Nunito Nerd Font" :size 18)
      doom-unicode-font (font-spec :family "Fira Code Nerd Font" :size 18)
      doom-big-font (font-spec :family "Fira Code Nerd Font" :size 22)
      )
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))
(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.8))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.2)))))

;; Transparency
;; (set-frame-parameter (selected-frame) 'alpha '(98 100))
;; (add-to-list 'default-frame-alist '(alpha 98 100))

;; Don't show symbols instead of words
;; TODO: Fix this (why is this not working?)
(setq global-prettify-symbols-mode nil)
(setq prettify-symbols-mode nil)
