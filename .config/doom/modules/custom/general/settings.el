;; Take new window space from all other windows (not just current)
;; (setq-default window-combination-resize t)

;; Autmatically scroll the *Messages* buffer when new messages arrive
(toggle-buffer-tail "*Messages*" "on")

;; Split horizontally to right, vertically below the current window
;; (setq evil-vsplit-window-right t
;;       evil-split-window-below t)

;; Undo stuff
(setq undo-limit 80000000   ; Raise undo-limit to 80Mb
      evil-want-fine-undo t ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t  ; Nobody likes to lose work, I certainly don't

      ;; Scroll stuff
      scroll-preserve-screen-position 'always ; Don't have `point' jump around
      scroll-margin 4                         ; It's nice to maintain a little margin

      ;; Enable relative line numbers
      display-line-numbers-type 'relative
      )

;; Stretch cursor to the glyph width
(setq-default x-stretch-cursor t)

;; Smooth scrolling
(if (> emacs-major-version 28)
    (pixel-scroll-precision-mode 1)
  (use-package! good-scroll
    :config (good-scroll-mode 1)))

;; Show a minimap on the size
(scroll-bar-mode 1)

;; Add mouse support in terminal version
(xterm-mouse-mode 1)

;; Highlight colors
(rainbow-mode 1)
;; Highlight parens
(rainbow-delimiters-mode 1)
