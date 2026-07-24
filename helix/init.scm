;; Steel plugin config — only loaded by the steel build of helix (`hx`).
;; The stable /usr/bin/helix binary ignores this file entirely.
;;
;; Plugins come from https://helix-plugins.com/ and are installed by
;; ./steel-setup.sh via forge.

(require "cogs/keymaps.scm")            ; keymap helpers (vendored by steel-setup.sh)

(require "scooter/scooter.scm")         ; nvim: grug-far.nvim -> :scooter
(require "oil/oil.scm")                 ; nvim: oil.nvim      -> :oil
(require "streal/streal.scm")           ; nvim: arrow.nvim    -> :streal-open
(require "helix-file-watcher/file-watcher.scm")

;; oil.hx: (oil-configure! show-dotfiles? show-git-ignored?)
;; nvim oil kept hidden files hidden -> same here; :oil-toggle-hidden flips it
(oil-configure! #false #false)

;; Auto-reload buffers when files change on disk
;; (nvim: oil watch_for_changes + autoread behaviour)
(spawn-watcher)

;; Plugin keybindings — kept out of config.toml so the stable binary still
;; loads that file (it rejects bindings to commands it doesn't know):
;;   -         -> oil            (nvim: oil.nvim "-")
;;   `         -> streal popup   (nvim: arrow.nvim "`"; s = toggle, 1-9 = jump)
;;   <space>cg -> scooter        (nvim: <leader>cg grug-far)
;; The full <space>c submenu is repeated so this stays correct whether the
;; merge with config.toml is deep or shallow.
(add-global-keybinding
 (hash "normal"
       (hash "-" ":oil"
             "`" ":streal-open"
             "space" (hash "c" (hash "c" "toggle_comments"
                                     "a" "code_action"
                                     "f" ":format"
                                     "g" ":scooter")))))
