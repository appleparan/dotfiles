# Zellij Configuration

A [Zellij](https://zellij.dev) setup that starts from
`keybinds clear-defaults=true`, so **none of the upstream default
keybindings apply**. Everything you can press is listed on this page.

The design goal is to stay out of the way of terminal editors: an
autolock plugin drops Zellij into Locked mode whenever a program that
needs raw `Ctrl` keys is focused, and the remaining bindings favour
`Alt` over `Ctrl`.

## Files

```text
config/zellij/
├── config.kdl          # Keybindings, plugin aliases, options
├── layouts/
│   └── default.kdl     # zjstatus status bar (Chadracula colors)
├── plugins/            # Vendored .wasm plugins
│   ├── dj95/zjstatus/
│   ├── fresh2dev/zellij-autolock/
│   └── imsnif/monocle/
└── themes/             # Empty; `theme "dracula"` is a builtin
```

Installed to `~/.config/zellij` by `install.sh`. The plugin paths in
`config.kdl` and `layouts/default.kdl` are absolute
(`file:~/.config/zellij/plugins/...`), so the directory must live
there rather than being symlinked from an arbitrary path.

## Sessions

```bash
zellij                  # Start a new session with a random name
zellij -s work          # Start a named session
zellij ls               # List sessions
zellij a work           # Attach to a session
zellij ka               # Kill all sessions
zellij da               # Delete all exited sessions
```

Detach from inside a session with `Alt b` then `d`. Note that
`on_force_close "quit"` is set: closing the terminal window kills the
session instead of detaching it.

## Modes

Zellij is modal. The current mode is shown on the left of the status
bar. Only these entry points exist:

| From Normal | Goes to      | Notes                             |
| ----------- | ------------ | --------------------------------- |
| `Alt b`     | Tmux         | Gateway to Pane/Tab/Session modes |
| `Ctrl s`    | Scroll       | Scrollback and search             |
| `Ctrl g`    | Locked       | Passthrough; `Ctrl g` to leave    |
| `Alt w`     | Session mgr  | Floating plugin, not a mode       |

`Esc` or `Enter` returns to Normal from any mode except Locked.

Pane mode and Tab mode have **no direct binding** — reach them with
`Alt b p` and `Alt b t`. Direct `Ctrl p` / `Ctrl t` entries exist in
`config.kdl` but are commented out, because both keys are useful
inside editors.

## Global keys

Available in every mode except Locked.

| Key                 | Action                                    |
| ------------------- | ----------------------------------------- |
| `Ctrl h` / `Ctrl l` | Focus pane left/right, else prev/next tab |
| `Ctrl j` / `Ctrl k` | Focus pane down/up                        |
| `Alt n`             | New pane                                  |
| `Alt =` / `Alt -`   | Resize pane larger/smaller                |
| `Alt [` / `Alt ]`   | Previous/next swap layout                 |
| `Alt z`             | Lock (also disables autolock)             |
| `Ctrl g`            | Lock (autolock stays enabled)             |
| `Ctrl q`            | Quit Zellij                               |

Available in every mode **including** Locked:

| Key           | Action                                     |
| ------------- | ------------------------------------------ |
| `Alt f`       | Monocle — fuzzy find files and scrollback  |
| `Alt Shift z` | Re-enable the autolock plugin              |
| `Alt w`       | Session manager (floating)                 |

## Tmux mode (`Alt b`)

Named after tmux because the bindings mirror a tmux prefix. This is
the hub for the other modes.

| Key                 | Action                        |
| ------------------- | ----------------------------- |
| `"` / `%`           | Split down / split right      |
| `c`                 | New tab                       |
| `,`                 | Rename tab                    |
| `z`                 | Toggle fullscreen             |
| `x`                 | Close focused pane            |
| `d`                 | Detach session                |
| `q`                 | Quit Zellij                   |
| `Space`             | Next swap layout              |
| `h` `j` `k` `l`     | Move focus                    |
| `Ctrl h/j/k/l`      | Move the pane itself          |
| `Alt h/j/k/l`       | Resize toward that direction  |
| `p` / `t` / `s`     | Pane / Tab / Scroll mode      |
| `o` / `[`           | Session mode / Scroll mode    |
| `g`                 | Locked mode                   |

## Pane mode (`Alt b p`)

| Key             | Action                              |
| --------------- | ----------------------------------- |
| `n` / `d` / `r` | New pane auto / below / right       |
| `f`             | Toggle fullscreen                   |
| `w`             | Toggle floating panes               |
| `e`             | Toggle embedded or floating         |
| `c`             | Rename pane                         |
| `z`             | Toggle pane frames                  |
| `p`             | Cycle focus                         |
| `x`             | Close focused pane                  |
| `h` `j` `k` `l` | Move focus                          |

## Tab mode (`Alt b t`)

| Key             | Action                          |
| --------------- | ------------------------------- |
| `n` / `r` / `x` | New / rename / close tab        |
| `1`–`9`         | Jump to tab                     |
| `h` `k`         | Previous tab                    |
| `j` `l`         | Next tab                        |
| `Tab`           | Toggle between last two tabs    |
| `b`             | Break pane out into its own tab |
| `[` / `]`       | Break pane to left/right tab    |
| `s`             | Toggle sync input for the tab   |

## Scroll mode (`Ctrl s`)

Vim-style motions over the scrollback buffer.

| Key                 | Action                       |
| ------------------- | ---------------------------- |
| `j` / `k`           | Scroll one line              |
| `d` / `u`           | Half page down/up            |
| `Ctrl f` / `Ctrl b` | Full page down/up            |
| `h` / `l`           | Full page up/down            |
| `e`                 | Open scrollback in `$EDITOR` |
| `s`                 | Start a search               |
| `Ctrl c`            | Jump to bottom and exit      |

In search mode: `n` / `p` next and previous match, `c` toggle case
sensitivity, `o` toggle whole word, `w` toggle wrap.

## Autolock and editor interop

The [zellij-autolock](https://github.com/fresh2dev/zellij-autolock)
plugin watches the focused pane and switches to Locked mode when the
running command matches this regex from `config.kdl`:

```text
vim|git|gitui|zoxide|fzf|less
```

In Locked mode Zellij forwards every key to the program, so `Ctrl b`,
`Ctrl h/j/k/l`, `Ctrl s` and friends behave normally inside vim.
`vim` matches `nvim` and `vimdiff` too. Add your own tools to the
regex if they need raw `Ctrl` keys.

Three things to know when it misbehaves:

- Locking is evaluated on `Enter` and on a short poll interval, so a
  program launched in an unusual way (a wrapper script, `sudo vim`)
  may not be recognised. Press `Ctrl g` to lock manually.
- `Alt z` locks *and disables* autolock, which is what you want when
  the detection keeps fighting you. `Alt Shift z` turns it back on.
- The tmux-mode prefix is `Alt b`, not `Ctrl b`, specifically so that
  a missed autolock does not steal page-up from vim. The trade-off is
  that readline's `backward-word` is shadowed — the same trade-off
  `Alt f` already makes for monocle.

Neovim adds a second layer: `fresh2dev/zellij.vim` maps `Ctrl h/j/k/l`
to `ZellijNavigate*`, so those keys cross the boundary between Neovim
splits and Zellij panes. See `config/nvim/lua/mappings.lua` and
`config/nvim/lua/plugins/zellij.lua`.

## Plugins

| Plugin     | Version   | Purpose                              |
| ---------- | --------- | ------------------------------------ |
| zjstatus   | v0.17.0   | Status bar, themed to NvChad Dracula |
| autolock   | 0.2.2     | Auto Locked mode for editors         |
| monocle    | v0.100.2  | Fuzzy file and scrollback search     |

They are vendored as `.wasm` files under `plugins/` so a fresh machine
works offline. To upgrade, download the new release asset, place it in
a new version directory, and update the paths in `config.kdl` and
`layouts/default.kdl`.

## Options worth knowing

`config.kdl` also sets:

- `simplified_ui true` and `pane_frames false` for a plainer look
- `theme "dracula"`, a Zellij builtin, matching the zjstatus colors
- `on_force_close "quit"` — closing the window ends the session
- `show_startup_tips false`

The status bar clock uses `Asia/Seoul`; change `datetime_timezone` in
`layouts/default.kdl` if you are elsewhere.

## Verifying changes

```bash
zellij setup --check
```

Look for `[CONFIG FILE]: Well defined.` — a KDL syntax error is
reported there. Keybinding changes need a new session to take effect;
plugin alias changes need a full restart.
