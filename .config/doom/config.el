(map! :leader
      :desc "List bookmarks"
      "b L" #'list-bookmarks
      :leader
      :desc "Save current bookmarks to bookmark file"
      "b w" #'bookmark-save)

(setq centaur-tabs-set-bar 'over
      centaur-tabs-set-icons t
      centaur-tabs-gray-out-icons 'buffer
      centaur-tabs-height 24
      centaur-tabs-set-modified-marker t
      centaur-tabs-style "bar"
      centaur-tabs-modified-marker "•")
(map! :leader
      :desc "Toggle tabs on/off"
      "t c" #'centaur-tabs-local-mode)
(evil-define-key 'normal centaur-tabs-mode-map (kbd "g <right>") 'centaur-tabs-forward        ; default Doom binding is 'g t'
                                               (kbd "g <left>")  'centaur-tabs-backward       ; default Doom binding is 'g T'
                                               (kbd "g <down>")  'centaur-tabs-forward-group
                                               (kbd "g <up>")    'centaur-tabs-backward-group)

(map! :leader
      :desc "Dired"
      "d d" #'dired
      :leader
      :desc "Dired jump to current"
      "d j" #'dired-jump
      (:after dired
        (:map dired-mode-map
         :leader
         :desc "Peep-dired image previews"
         "d p" #'peep-dired
         :leader
         :desc "Dired view file"
         "d v" #'dired-view-file)))
;; Make 'h' and 'l' go back and forward in dired. Much faster to navigate the directory structure!
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
;; If peep-dired is enabled, you will get image previews as you go up/down with 'j' and 'k'
(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;; Get file icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))

(setq doom-theme 'doom-one)
(map! :leader
      :desc "Load new theme"
      "h t" #'counsel-load-theme)

(map! :leader
      :desc "Evaluate elisp in buffer"
      "e b" #'eval-buffer
      :leader
      :desc "Evaluate defun"
      "e d" #'eval-defun
      :leader
      :desc "Evaluate elisp expression"
      "e e" #'eval-expression
      :leader
      :desc "Evaluate last sexpression"
      "e l" #'eval-last-sexp
      :leader
      :desc "Evaluate elisp in region"
      "e r" #'eval-region)

(setq browse-url-browser-function 'eww-browse-url)
(map! :leader
      :desc "Eww web browser"
      "e w" #'eww
      :leader
      :desc "Eww reload page"
      "e R" #'eww-reload
      :leader
      :desc "Search web for text between BEG/END"
      "s w" #'eww-search-words)

(setq doom-font (font-spec :family "Fira Code" :size 18)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 18)
      doom-big-font (font-spec :family "Fira Code" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))
(setq global-ligature-mode t)

(setq ivy-posframe-display-functions-alist
      '((swiper                     . ivy-posframe-display-at-point)
        (complete-symbol            . ivy-posframe-display-at-point)
        (counsel-M-x                . ivy-display-function-fallback)
        (counsel-esh-history        . ivy-posframe-display-at-window-center)
        (counsel-describe-function  . ivy-display-function-fallback)
        (counsel-describe-variable  . ivy-display-function-fallback)
        (counsel-find-file          . ivy-display-function-fallback)
        (counsel-recentf            . ivy-display-function-fallback)
        (counsel-register           . ivy-posframe-display-at-frame-bottom-window-center)
        (dmenu                      . ivy-posframe-display-at-frame-top-center)
        (nil                        . ivy-posframe-display))
      ivy-posframe-height-alist
      '((swiper . 20)
        (dmenu . 20)
        (t . 10)))
(ivy-posframe-mode 1) ; 1 enables posframe-mode, 0 disables it.

(map! :leader
      :desc "Ivy push view"
      "v p" #'ivy-push-view
      :leader
      :desc "Ivy switch view"
      "v s" #'ivy-switch-view)

(setq display-line-numbers-type t)
(map! :leader
      :desc "Toggle truncate lines"
      "t t" #'toggle-truncate-lines)

(after! neotree
  (setq neo-smart-open t
        neo-window-fixed-size nil))
(after! doom-themes
  (setq doom-neotree-enable-variable-pitch t))
(map! :leader
      :desc "Toggle neotree file viewer"
      "t n" #'neotree-toggle
      :leader
      :desc "Open directory in neotree"
      "d n" #'neotree-dir)

(map! :leader
      :desc "Edit agenda file"
      "- a" #'(lambda () (interactive) (find-file "~/Org/agenda.org"))
      :leader
      :desc "Edit doom config.org"
      "- c" #'(lambda () (interactive) (find-file "~/.doom.d/config.org"))
      :leader
      :desc "Edit doom init.el"
      "- i" #'(lambda () (interactive) (find-file "~/.doom.d/init.el"))
      :leader
      :desc "Edit doom packages.el"
      "- p" #'(lambda () (interactive) (find-file "~/.doom.d/packages.el")))

(after! org
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq org-directory "~/Documents/Org/"
        org-agenda-files '("~/Documents/Org/agenda.org")
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ▼ "
        org-log-done 'time
        org-journal-dir "~/Documents/Org/journal/"
        org-journal-date-format "%B %d, %Y (%A) "
        org-journal-file-format "%Y-%m-%d.org"
        org-hide-emphasis-markers t
        ;; ex. of org-link-abbrev-alist in action
        ;; [[arch-wiki:Name_of_Page][Description]]
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
        '(("google" . "http://www.google.com/search?q=")
          ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
          ("wiki" . "https://en.wikipedia.org/wiki/"))
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
        '((sequence
           "TODO(t)"           ; A task that is ready to be tackled
           "PROJ(p)"           ; A project that contains other tasks
           "EXAM(e)"           ; An examination that is yet to be given
           "WAIT(w)"           ; Something is holding up this task
           "|"                 ; The pipe necessary to separate "active" states and "inactive" states
           "DONE(d)"           ; Task has been completed
           "CANCELLED(c)" )))) ; Task has been cancelled
(require 'ox-man)

(defun dt/org-babel-tangle-async (file)
  "Invoke `org-babel-tangle-file' asynchronously."
  (message "Tangling %s..." (buffer-file-name))
  (async-start
   (let ((args (list file)))
  `(lambda ()
        (require 'org)
        ;;(load "~/.emacs.d/init.el")
        (let ((start-time (current-time)))
          (apply #'org-babel-tangle-file ',args)
          (format "%.2f" (float-time (time-since start-time))))))
   (let ((message-string (format "Tangling %S completed after " file)))
     `(lambda (tangle-time)
        (message (concat ,message-string
                         (format "%s seconds" tangle-time)))))))

(defun dt/org-babel-tangle-current-buffer-async ()
  "Tangle current buffer asynchronously."
  (dt/org-babel-tangle-async (buffer-file-name)))

(map! :leader
      :desc "Copy to register"
      "r c" #'copy-to-register
      :leader
      :desc "Frameset to register"
      "r f" #'frameset-to-register
      :leader
      :desc "Insert contents of register"
      "r i" #'insert-register
      :leader
      :desc "Jump to register"
      "r j" #'jump-to-register
      :leader
      :desc "List registers"
      "r l" #'list-registers
      :leader
      :desc "Number to register"
      "r n" #'number-to-register
      :leader
      :desc "Interactively choose a register"
      "r r" #'counsel-register
      :leader
      :desc "View a register"
      "r v" #'view-register
      :leader
      :desc "Window configuration to register"
      "r w" #'window-configuration-to-register
      :leader
      :desc "Increment register"
      "r +" #'increment-register
      :leader
      :desc "Point to register"
      "r SPC" #'point-to-register)

(map! :leader
      :desc "Ssh into distrotube.com"
      "\\ d" #'(lambda () (interactive) (find-file "/scp:derek@distrotube.com"))
      :leader
      :desc "Ssh into my nextcloud"
      "\\ n" #'(lambda () (interactive) (find-file "/scp:derek@distrotube.net")))

(setq shell-file-name "/bin/zsh"
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "htop" "ssh" "top" "zsh")
      vterm-max-scrollback 5000)
(map! :leader
      :desc "Counsel eshell history"
      "e h" #'counsel-esh-history)

(defun prefer-horizontal-split ()
  (set-variable 'split-height-threshold nil t)
  (set-variable 'split-width-threshold 40 t)) ; make this as low as needed
(add-hook 'markdown-mode-hook 'prefer-horizontal-split)
(map! :leader
      :desc "Clone indirect buffer other window"
      "b c" #'clone-indirect-buffer-other-window)
(evil-define-key nil 'global
  (kbd "M-h") 'windmove-left
  (kbd "M-j") 'windmove-down
  (kbd "M-k") 'windmove-up
  (kbd "M-l") 'windmove-right)

(map! :leader
      "w <right>" #'winner-redo
      :leader
      :desc "Winner undo"
      "w <left>" #'winner-undo)

(evil-define-key 'visual 'global
  "J" (kbd ":move '>+1 RET gv-gv")
  "K" (kbd ":move '<-2 RET gv-gv"))

(map! "C-s" #'save-buffer
      :desc "Save the current buffer")
