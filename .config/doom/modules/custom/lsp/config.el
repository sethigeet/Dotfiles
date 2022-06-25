(load! "keymappings")

(after! lsp-ui
  (setq lsp-ui-sideline-enable t
        lsp-ui-sideline-show-code-actions nil
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-show-hover nil

        ;; Show extra info in completion window
        lsp-completion-show-kind t
        lsp-completion-show-detail t

        lsp-log-io nil
        lsp-lens-enable t ; not working properly with ccls!

        lsp-diagnostics-provider :auto

        ;; Highlight symbol under the cursor
        lsp-enable-symbol-highlighting t

        ;; Show breadcrumbs in the headerline
        ;;lsp-headerline-breadcrumb-enable t ;; Done after loading lsp-treemacs so that icons work properly!
        ))

;; Show breadcrumbs in the headerline
(after! lsp-treemacs
  (setq lsp-headerline-breadcrumb-enable t)
  (setq lsp-headerline-breadcrumb-enable-diagnostics t))

;; Format on save modes
(defvar +format-on-save-enabled-modes
  '(not sql-mode           ; sqlformat is currently broken
        tex-mode           ; latexindent is broken
        latex-mode
        org-msg-edit-mode) ; doesn't need a formatter
  )
