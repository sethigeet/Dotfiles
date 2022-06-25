;; Load a different icon theme
;; (use-package! treemacs-all-the-icons
;;   :defer t
;;   :after (treemacs all-the-icons)
;;   :init
;;   (require 'treemacs-all-the-icons)
;;   :config
;;   (treemacs-load-theme "all-the-icons"))

(setq doom-themes-treemacs-enable-variable-pitch nil
      doom-themes-treemacs-theme "doom-colors")
(doom-themes-treemacs-config)

;; Keymaps
(after! treemacs
  (define-key evil-treemacs-state-map (kbd "a") #'treemacs-create-file)
  (define-key evil-treemacs-state-map (kbd "A") #'treemacs-create-dir))

(map! :leader
      :desc "Open filetree" :g "e" #'treemacs)
