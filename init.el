
;;; Hide useless crap
(when window-system
  (scroll-bar-mode -1)
  (tool-bar-mode -1))

(unless window-system
  (menu-bar-mode -1))

;;; Font
(when window-system
  ;;(set-frame-font "SF Mono 16" nil t)
  ;;(set-frame-font "Menlo 16" nil t)
  (set-frame-font "Monaco 13" nil t))

;;; Initialize the theme
(setq custom-theme-directory (expand-file-name "themes" user-emacs-directory))

(dolist
    (path (directory-files custom-theme-directory t "\\w+"))
  (when (file-directory-p path)
    (add-to-list 'custom-theme-load-path path)))

(when window-system
  ;; (load-theme 'hydandata-light t)
  (load-theme 'dracula t)
  ;;(load-theme 'magnars t)
  )

;;; Do not load stale files
(setq load-prefer-newer t)

;;; Be careful with third party code
(setq enable-local-variables :safe)

;;; Make Emacs resize properly
(setq frame-resize-pixelwise t)

;;; Information about the user
(setq user-full-name "David Chkhikvadze"
      user-nickname "chkhd"
      user-irc-server "irc.freenode.net"
      user-irc-channels '("#lisp" "#sbcl" "#clasp" "#quicklisp"))

;;; Quiet down and enable expert mode
(setq inhibit-splash-screen t
      inhibit-startup-message t
      initial-scratch-message nil
      visible-bell t
      disabled-command-function nil)

(defun display-startup-echo-area-message nil nil)

(when window-system
  (setq ring-bell-function 'ignore))

;;; Always use the minibuffer
(setq use-dialog-box nil
      echo-keystrokes 0.1)

;;; Simple UX tweaks
(setq gc-cons-threshold 20000000)

(when window-system
  (global-hl-line-mode 1))

(setq eldoc-idle-delay 0.1
      enable-recursive-minibuffers t)

(blink-cursor-mode 0)

(show-paren-mode 1)
(setq show-paren-delay 0
      show-paren-style 'parenthethis
      blink-matching-paren 'offscreen)

(line-number-mode 1)
(column-number-mode 1)
(setq size-indication-mode t)

;;; Quality of life changes
(defalias 'yes-or-no-p 'y-or-n-p)

(setq apropos-do-all t
      isearch-resume-in-command-history t)

;;; Editing
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq require-final-newline t
      mode-require-final-newline t)

(setq-default tab-width 2
              indicate-empty-lines t
              major-mode 'indented-text-mode)

(set-default 'indent-tabs-mode nil)
(set-default 'sentence-end-double-space nil)

;;; Maximum highlighting
(setq font-lock-maximum-decoration t)
(global-font-lock-mode 1)

;;; Copy and paste
(setq mouse-yank-at-point t
      kill-do-not-save-duplicates t
      select-enable-primary t
      x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)
      save-interprogram-paste-before-kill t
      kill-read-only-ok t)

(setq-default transient-mark-mode t)

(delete-selection-mode 1)
(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)

;;; Do not litter the file system
(setq delete-by-moving-to-trash t
      backup-directory-alist `(("." . ,(expand-file-name (concat user-emacs-directory "backups"))))
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t
      tramp-backup-directory-alist backup-directory-alist
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      create-lockfiles nil)

;;; Enable all history features
(setq bookmark-default-file (expand-file-name "bookmarks" user-emacs-directory)
      bookmark-save-flag 1
      history-length 1000
      history-delete-duplicates t
      savehist-additional-variables '(search ring regexp-search-ring)
      savehist-autosave-interval 60
      savehist-file (expand-file-name ".savehist" user-emacs-directory))

(savehist-mode 1)

(require 'saveplace)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

(save-place-mode 1)
(setq switch-to-buffer-preserve-window-point t)

(require 'recentf)

(setq recentf-max-saved-items 150)
(setq recentf-exclude
      '("/elpa/"
        "/Caskroom/"
        "/quicklisp/"
        "/games/"
        "/Cellar/"
        "/.gnupg/"
        "\\.last\\'"))

(recentf-mode 1)

;;; Only show events I care about
(setq holiday-bahai-holidays nil
      holiday-hebrew-holidays nil
      holiday-islamic-holidays nil
      holiday-christian-holidays nil
      holiday-solar-holidays nil
      holiday-oriental-holidays nil
      holiday-other-holidays nil
      holiday-general-holidays nil
      calendar-week-start-day 1
      calendar-mark-holidays-flag t)

;;; Revert automatically and be quite about it
(global-auto-revert-mode 1)

(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil
      auto-revert-check-vc-info t)

;;; Use sane buffer names
(require 'uniquify)
(setq uniquify-buffer-nmae-style 'forward)

;;; Work with compressed files seamlessly
(auto-compression-mode 1)

;;; Automatically reflow comments at fill column
(setq-default fill-column 88)

(defun comment-auto-fill ()
  (setq-local comment-auto-fill-only-comments t)
  (auto-fill-mode 1))

(add-hook 'prog-mode-hook 'comment-auto-fill)

;;; Key bindings
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-c q") 'save-buffers-kill-terminal)
(global-unset-key (kbd "C-x C-c"))
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-x f") 'recentf-open-files)
(global-set-key (kbd "C-c re") 'recursive-edit)

(setq truncate-partial-width-windows nil
      truncate-lines t
      visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))

(global-set-key (kbd "C-c vl") 'visual-line-mode)

;;; Go to eshell buffer from anywhere, easily get back where you were
(defun run-eshell-or-goto-previous-buffer ()
  (interactive)
  (let ((shell "eshell"))
    (if (string-match-p (concat "^*" shell ".*") (buffer-name))
        (switch-to-prev-buffer)
        (funcall (read shell)))))

(global-set-key (kbd "<f10>")
                'run-eshell-or-goto-previous-buffer)

(defun do-eval-buffer ()
  (interactive)
  (save-window-excursion
    (eval-buffer))
  (message "Buffer has been evaluated"))

(global-set-key (kbd "C-x C-c") 'do-eval-buffer)

;;; IELM
(with-eval-after-load 'ielm
  (setq ielm-header "\n")
  (define-key ielm-map "\C-j" 'newline-and-indent))

;;; Save open files and buffers
(setq desktop-save t
      desktop-restore-frames t
      desktop-restore-forces-onscreen t
      desktop-lazy-verbose nil
      desktop-restore-eager nil
      desktop-restore-reuses-frames t)

(desktop-save-mode 1)

;;; Useful functions
(defun untabify-buffer ()
  "Remove tabs from the whole buffer."
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  "Indent the whole buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of cleanup operations on the whitespace
content of a buffer."
  (interactive)
  (save-excursion
    (delete-trailing-whitespace)
    (set-buffer-file-coding-system 'utf-8)))

(defun chomp (str)
  "Chomp leading and tailing whitespace from `str'."
  (while (string-match "\\`\n+\\|^\\s-+\\|\\s-+$\\|\n+\\'" str)
    (setq str (replace-match "" t t str))) str)

(defun get-keychain-password (account-name)
  "Get `account-name' keychain password from OS X Keychain"
  (interactive "sAccount name: ")
  (when (executable-find "security")
    (chomp (shell-command-to-string (concat "security find-generic-password -wa "
                                            account-name)))))

;;; Now that theme and built-in configuration is out of the way, time
;;; for enhancements!

;;; MELPA
(setq package-enable-at-startup nil
      package-archives
      '(("org" . "https://orgmode.org/elpa/")
        ("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)

;;; Quality of life

(global-whitespace-cleanup-mode t)

(smooth-scrolling-mode t)

(which-key-setup-side-window-right-bottom)
(which-key-mode 1)

(exec-path-from-shell-initialize)

(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(global-set-key (kbd "C-c C-p") 'switch-to-previous-buffer)

(global-anzu-mode 1)
(global-set-key [remap query-replace] 'anzu-query-replace)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)

(global-undo-tree-mode 1)

(persistent-scratch-setup-default)

(global-set-key (kbd "C-c n") 'iflipb-next-buffer)
(global-set-key (kbd "C-c p") 'iflipb-previous-buffer)

;;; Do magic with pairs
(with-eval-after-load 'elixir-mode
  (require 'smartparens-elixir))

(with-eval-after-load 'markdown-mode
  (require 'smartparens-markdown))

(with-eval-after-load 'python-mode
  (require 'smartparens-python))

(with-eval-after-load 'js
  (require 'smartparens-javascript))

;;; Copyrights
(setq copyright-names-regexp user-full-name
      copyright-query 'function)

(add-hook 'before-save-hook '(lambda () (copyright-update t t)))

;;; Markdown
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.text\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

;;; Auto-enable wrapping in Markdown buffers
(add-hook 'gfm-mode-hook 'visual-line-mode)

(with-eval-after-load 'gfm-mode
  (setq markdown-make-gfm-checkboxes-buttons t
        markdown-gfm-additional-languages t
        markdown-nested-imenu-heading-index t
        markdown-coding-system 'utf-8
        markdown-enable-math t))

;;; Completion
(icomplete-mode 1)

(set-default 'imenu-auto-rescan t)

(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)
(ido-at-point-mode 1)

(setq ido-enable-flex-matching t
      ido-use-faces nil)

(flx-ido-mode 1)

(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(crm-custom-mode 1)

(setq he-search-loc-backward (make-marker)
      he-search-loc-forward (make-marker)
      hippie-expand-verbose nil)

(defun try-expand-dabbrev-closest-first (old)
  "Try to expand word \"dynamically\", searching the current buffer.
The argument OLD has to be nil the first call of this function, and t
for subsequent calls (for further possible expansions of the same
string).  It returns t if a new expansion is found, nil otherwise."
  (let (expansion)
    (unless old
      (he-init-string (he-dabbrev-beg) (point))
      (set-marker he-search-loc-backward he-string-beg)
      (set-marker he-search-loc-forward he-string-end))

    (if (not (equal he-search-string ""))
        (save-excursion
          (save-restriction
            (if hippie-expand-no-restriction
                (widen))

            (let (forward-point
                  backward-point
                  forward-distance
                  backward-distance
                  forward-expansion
                  backward-expansion
                  chosen)

              ;; search backward
              (goto-char he-search-loc-backward)
              (setq expansion (he-dabbrev-search he-search-string t))

              (when expansion
                (setq backward-expansion expansion
                      backward-point (point)
                      backward-distance (- he-string-beg backward-point)))

              ;; search forward
              (goto-char he-search-loc-forward)
              (setq expansion (he-dabbrev-search he-search-string nil))

              (when expansion
                (setq forward-expansion expansion
                      forward-point (point)
                      forward-distance (- forward-point he-string-beg)))

              ;; choose depending on distance
              (setq chosen (cond
                            ((and forward-point backward-point)
                             (if (< forward-distance backward-distance)
                                 :forward
                                 :backward))

                            (forward-point :forward)
                            (backward-point :backward)))

              (when (equal chosen :forward)
                (setq expansion forward-expansion)
                (set-marker he-search-loc-forward forward-point))

              (when (equal chosen :backward)
                (setq expansion backward-expansion)
                (set-marker he-search-loc-backward backward-point))))))

    (if (not expansion)
        (progn
          (if old (he-reset-string))
          nil)
        (progn
          (he-substitute-string expansion t)
          t))))

;; Redefine the completion functions and their order to make it feel
;; more fluid and DWIM quicker
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev-closest-first
        try-complete-file-name
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-expand-all-abbrevs
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

(defun hippie-unexpand ()
  (interactive)
  (hippie-expand 0))

(global-set-key (kbd "C-.") 'hippie-expand)
(global-set-key (kbd "C-c .") 'hippie-unexpand)
(global-set-key (kbd "M-/") 'hippie-expand)

;;; Snippets
(setq yas-snippet-dirs `(,(expand-file-name "snippets"
                                            user-emacs-directory))
      yas-prompt-functions '(yas-completing-prompt)
      yas-verbosity 1
      yas-wrap-around-region t)

(defun yas/goto-end-of-active-field ()
  (interactive)
  (let* ((snippet (car (yas--snippets-at-point)))
         (position (yas--field-end (yas--snippet-active-field snippet))))
    (if (= (point) position)
        (move-end-of-line 1)
        (goto-char position))))

(defun yas/goto-start-of-active-field ()
  (interactive)
  (let* ((snippet (car (yas--snippets-at-point)))
         (position (yas--field-start (yas--snippet-active-field snippet))))
    (if (= (point) position)
        (move-beginning-of-line 1)
        (goto-char position))))

(with-eval-after-load 'yasnippet
  (define-key yas-keymap (kbd "<tab>") 'yas-expand)
  (define-key yas-keymap (kbd "<return>") 'yas-exit-all-snippets)
  (define-key yas-keymap (kbd "C-e") 'yas/goto-end-of-active-field)
  (define-key yas-keymap (kbd "C-a") 'yas/goto-start-of-active-field))

(yas-global-mode 1)

;;; Git
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(with-eval-after-load 'magit
  (setq magit-last-seen-setup-instructions "2.1.0"
        magit-stage-all-confirm nil
        magit-unstage-all-confirm nil
        magit-revert-buffers 'silent
        magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1
        magit-completing-read-function 'magit-ido-completing-read))

(global-set-key (kbd "C-c gs") 'magit-status)
(global-set-key (kbd "C-c gc") 'magit-commit)
(global-set-key (kbd "C-c gd") 'magit-diff)
(global-set-key (kbd "C-c gl") 'magit-log-current)
(global-set-key (kbd "C-c gb") 'magit-blame)

(global-diff-hl-mode 1)

(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

(with-eval-after-load 'diff-hl
  (require 'diff-hl-flydiff)

  (setq diff-hl-side 'right
        diff-hl-draw-borders t)
  ;;(diff-hl-margin-mode 1)
  (diff-hl-flydiff-mode 1)

  (add-hook 'dired-mode-hook
            (lambda ()
              (diff-hl-dired-mode t))))

;;; Built-in browser
(setq my-eww-url-regexes
      '("documentation/HyperSpec*"
        "reference/HyperSpec*"))

(cl-defun eww-urlp (url)
  "Returns nil unless the url matches something in my-eww-url-regexes."
  (dolist (url-regex my-eww-url-regexes)
    (when (string-match url-regex url)
      (return-from eww-urlp t))))

(defun my-browse-url-function (url &rest ignore)
  "Browse URL in eww or the default browser depending on where it points."
  (interactive (browse-url-interactive-arg "URL: "))
  (if (eww-urlp url)
      (eww-browse-url url)
      (browse-url-default-browser url)))

(setq browse-url-browser-function 'my-browse-url-function)

;;; Interacting with REST APIs
(add-to-list 'auto-mode-alist '("\\.api\\'" . restclient-mode))
(add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode))

;;; Mode line
(setq rm-whitelist " Flymake\\| Ovwrt")

(defvar mode-line-tweaked nil
  "Did rich-minority-mode already tweak the mode line or not.")

(add-hook 'desktop-after-read-hook
          (lambda ()
            (setq mode-line-tweaked t)))

(unless mode-line-tweaked
  (setq mode-line-tweaked t)
  (rich-minority-mode 1))

;;; IRC
(with-eval-after-load 'rcirc
  (setq rcirc-fill-column 80)

  (rcirc-track-minor-mode 1)

  (add-hook 'rcirc-mode-hook 'flyspell-mode)

  (setq rcirc-omit-threshold 15
        rcirc-omit-responses
        '("JOIN" "KICK" "MODE" "PART"
          "QUIT" "NICK" "AWAY" "324"
          "329" "333" "353"))

  (add-hook 'rcirc-mode-hook 'rcirc-omit-mode)

  (setq rcirc-server-alist
        `((,user-irc-server
           :port 6697 :encryption tls
           :channels ,user-irc-channels
           :nick ,user-nickname))))

;;; Do not display parenthetis around the mode list
(setq mode-line-modes (remove "(" (remove ")" mode-line-modes)))

;;; Show holidays in calendar
(czech-holidays-add)

;;; Editing
(global-set-key (kbd "C-'") 'er/expand-region)
(global-set-key (kbd "M-z") #'zzz-up-to-char)
(global-set-key (kbd "M-u") #'fix-word-upcase)
(global-set-key (kbd "M-l") #'fix-word-downcase)
(global-set-key (kbd "M-c") #'fix-word-capitalize)

;;; Spelling
(setq ispell-program-name "aspell")

(add-hook 'text-mode-hook 'flyspell-mode)

(with-eval-after-load 'flyspell
  (require 'flyspell-lazy)
  (flyspell-lazy-mode 1)

  (add-to-list 'ispell-extra-args "--sug-mode=ultra")

  (setq flyspell-issue-message-flag nil
        flyspell-issue-welcome-flag nil)

  (define-key flyspell-mode-map (kbd "C-;") 'flyspell-correct-wrapper))

;;; Make parens more beautiful by making them fade into the background.
;;; For now I manually adjust the brightness based on color theme
(with-eval-after-load 'paren-face
  (if window-system
      (set-face-foreground 'parenthesis "gray60")
      (set-face-foreground 'parenthesis "gray70")))

(global-paren-face-mode 1)

;;; Enforce paren symmetry
(dolist (hook '(emacs-lisp-mode-hook
                lisp-mode-hook
                scheme-mode-hook
                eval-expression-minibuffer-setup-hook
                ielm-mode-hook
                lisp-interaction-mode-hook))
  (add-hook hook 'enable-paredit-mode))

(with-eval-after-load 'paredit
  (put 'paredit-forward-delete 'delete-selection 'supersede)
  (put 'paredit-backward-delete 'delete-selection 'supersede)
  (put 'paredit-newline 'delete-selection t)

  (define-key paredit-mode-map (kbd "M-C-<backspace>") 'backward-kill-sexp)
  (define-key paredit-mode-map (kbd "{") 'paredit-open-curly )
  (define-key paredit-mode-map (kbd "}") 'paredit-close-curly)
  (define-key paredit-mode-map (kbd "[") 'paredit-open-square )
  (define-key paredit-mode-map (kbd "]") 'paredit-close-square)

  (eldoc-add-command
   'paredit-backward-delete
   'paredit-close-round))

;;; Fix Lisp indentation, I really don't like the Emacs lisp
;;; indentation defaults.
(put 'if 'lisp-indent-function nil)
(put 'when 'lisp-indent-function 1)
(put 'unless 'lisp-indent-function 1)
(put 'do 'lisp-indent-function 2)
(put 'do* 'lisp-indent-function 2)
(put :default-initargs
     'common-lisp-indent-function '(&rest))

;;; Fix loop macro indentation
(setq lisp-simple-loop-indentation 1
      lisp-loop-keyword-indentation 6
      lisp-loop-forms-indentation 6)

;;; Indent using correct function
(add-hook 'lisp-mode-hook
          #'(lambda ()
              (set (make-local-variable 'lisp-indent-function)
                   'common-lisp-indent-function)))

;;; Make Lisp code prettier
(global-prettify-symbols-mode 1)

;;; Emacs Lisp
(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'elisp-slime-nav-mode))

;;; Language Server Protocol client
(add-hook 'python-mode-hook 'eglot-ensure)
(add-hook 'go-mode-hook 'eglot-ensure)

;;; Python
(defun python-shell-send-buffer-switch ()
  "Send buffer content to shell and switch to it in insert mode."
  (interactive)
  (python-shell-send-buffer)
  (python-shell-switch-to-shell))

(defun python-shell-send-defun-switch ()
  "Send function content to shell and switch to it in insert mode."
  (interactive)
  (python-shell-send-defun nil)
  (python-shell-switch-to-shell))

(defun python-shell-send-region-switch (start end)
  "Send region content to shell and switch to it in insert mode."
  (interactive "r")
  (python-shell-send-region start end)
  (python-shell-switch-to-shell))

(defun python-start-or-switch-repl ()
  "Start and/or switch to the REPL."
  (interactive)
  (python-shell-switch-to-shell))

(defun python-setup ()
  (setq ;; auto-indent on colon doesn't work well with if statement
   electric-indent-chars (delq ?: electric-indent-chars))

  (local-set-key (kbd "C-j") 'newline-and-indent)

  (if (executable-find "ipython")
      (setq python-shell-interpreter "ipython")
      (setq python-shell-interpreter "python")))

(add-hook 'python-mode-hook 'python-setup)

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "C-c C-z")   'python-start-or-switch-repl)
  (define-key python-mode-map (kbd "C-c C-M-c") 'python-shell-send-buffer-switch)
  (define-key python-mode-map (kbd "C-c C-M-x") 'python-shell-send-defun-switch)
  (define-key python-mode-map (kbd "C-c C-M-r") 'python-shell-send-region-switch))

;;; Common Lisp
(with-eval-after-load 'slime
  (setq inferior-lisp-program "sbcl")

  (slime-setup '(slime-fancy
                 slime-editing-commands
                 slime-fuzzy
                 slime-sbcl-exts
                 slime-asdf
                 slime-indentation
                 slime-sprof
                 slime-tramp))

  (defun override-slime-repl-bindings-with-paredit ()
    (define-key slime-repl-mode-map
      (read-kbd-macro paredit-backward-delete-key) nil))

  (add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
  (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

  (setq slime-completion-at-point-functions
        (cons 'slime-fuzzy-complete-symbol slime-completion-at-point-functions)
        slime-fuzzy-explanation ""
        slime-when-complete-filename-expand t)

  (setq slime-repl-history-remove-duplicates t
        slime-repl-history-trim-whitespaces t
        slime-repl-history-file
        (expand-file-name "slime-history.eld"
                          user-emacs-directory))

  (setq slime-net-coding-system 'utf-8-unix)

  (setq common-lisp-hyperspec-root
        (concat "file:///Users/chkhd/Documents/HyperSpec/")))

(redshank-setup '(lisp-mode-hook
                  slime-repl-mode-hook) t)

;;; Go
(with-eval-after-load 'go-mode
  (add-hook 'go-mode-hook 'go-eldoc-setup)

  (setq gofmt-command "goimports"
        compile-command "go build  -v && go test -v && go vet && golint")

  (add-hook 'before-save-hook 'gofmt-before-save)
  (define-key go-mode-map (kbd "M-.") 'godef-jump)
  (define-key go-mode-map (kbd "C-c C-c") 'compile)

  (add-to-list 'load-path (concat (getenv "GOPATH")
                                  "src/github.com/golang/lint/misc/emacs")))

;;; CSS
(with-eval-after-load 'css-mode
  (css-eldoc-enable))

;;; I could save these in a separate file, but I like to keep evryting
;;; in one place.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("6c5cd013d19a95327497d4cb12c61cbb3bcb185f8b77fffcd8e92714091de45c" "f718beb08054a2ad605787e6d7716bccca3ba6a1eeeb966b47477d395d5e7411" "0301a26dedfda81ca220ad6169588b5408884e7b4a5363f3e6a0e98d5c65a257" default)))
 '(package-selected-packages
   (quote
    (smex ido-completing-read+ ido-at-point flx-ido flx whitespace-cleanup-mode css-eldoc smartparens realgud eglot flyspell-lazy redshank iflipb persistent-scratch undo-tree restclient go-mode rich-minority anzu czech-holidays exec-path-from-shell which-key smooth-scrolling fix-word zzz-to-char hungry-delete expand-region projectile elisp-slime-nav blacken diff-hl magit paredit paren-face))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
