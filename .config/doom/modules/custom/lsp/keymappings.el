;; Easily navigate between errors
(map! :prefix "["
      :desc "Previous diagnostic" :n "e" #'flycheck-previous-error)
(map! :prefix "]"
      :desc "Next diagnostic" :n "e" #'flycheck-next-error)

;; Show help info
(map! :prefix "g"
 :desc "show signature help" :n "s" #'lsp-signature-activate
 :desc "show hover docs" :n "h" #'lsp-ui-doc-show)

(map! :mode lsp-ui-doc-frame-mode
      :prefix "g"
      :desc "Focus into hover doc childframe" :n "h" #'lsp-ui-doc-focus-frame)

(after! evil
  ;; Use peek
  (map! :prefix "g"
        :desc "Find references" :n "r" #'lsp-ui-peek-find-references
        :desc "Find implmentation" :n "I" #'lsp-ui-peek-find-implementation
        :desc "Find definitions" :n "d" #'lsp-ui-peek-find-definitions
        :desc "Find workspace symbol" :n "w" #'lsp-ui-peek-find-workspace-symbol
        )

  (map! :leader
        :desc "Show imenu" :n "cI" #'lsp-ui-imenu)
  )
