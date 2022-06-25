;; Enable tree-sitter powered syntax highlighting for all buffers
(use-package! tree-sitter
  :init (require 'tree-sitter))
(use-package! tree-sitter-langs
  :init (require 'tree-sitter-langs)
  :config
  (progn
    (global-tree-sitter-mode)
    (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
    )
  )
