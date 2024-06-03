# .dotfiles

![Terminal](./assets/terminal.png)
![Desktop](./assets/desktop.png)

## 📘 Overview

This `.dotfiles` repository contains my macOS and Windows system configurations.

Features include:

- [chezmoi](https://chezmoi.io/) to manage dotfiles across systems
- [Yabai](https://github.com/koekeishiya/yabai), [skhd](https://github.com/koekeishiya/skhd), [SketchyBar](https://github.com/FelixKratz/SketchyBar) and [JankyBorders](https://github.com/FelixKratz/JankyBorders) on MacOS
- [WezTerm](https://wezfurlong.org/wezterm/) a cross-platform terminal emulator
- [Neovim](https://neovim.io/) a cross-platform editor
- [Catppuccin](https://github.com/catppuccin) theme
- [Starship](https://starship.rs/) prompt
- Package management with [Homebrew](https://brew.sh/) on macOS and [Scoop](https://scoop.sh/) on Windows
- A configured `zsh` shell on macOS and `PowerShell` on Windows with autocompletion, history, and syntax highlighting
- Fuzzy finding with [fzf](https://github.com/junegunn/fzf)

> [!WARNING]
> Change the git username, email, and ssh keygen email in `setup_mac.sh` and `setup_win.ps1` to your own.
> Change `banner.zsh` and the banner in `setup_win.ps1` to your own banner image.
> If you have existing ssh keys, ensure to copy them to the $HOME/.ssh directory.

> [!IMPORTANT]
> Move `key.txt` encryption key to the `$HOME/.config` directory to decrypt encrypted files.

### 🍎 MacOS

1. Disable system integrity protection. [Yabai instructions](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection)

    - Turn off system. Hold power button until "Loading startup options" appears. Click "Options" then click "Continue"
    - In the menu bar, choose `Utilities`, then `Terminal`

    ```bash
    # If you're on Apple Silicon macOS 13.x.x
    # Requires Filesystem Protections, Debugging Restrictions and NVRAM Protection to be disabled
    # (printed warning can be safely ignored)
    csrutil enable --without fs --without debug --without nvram
    ```

    - Reboot. For Apple Silicon, need to enable non-Apple-signed arm64e binaries.

    ```bash
    # Open a terminal and run the below command, then reboot
    sudo nvram boot-args=-arm64e_preview_abi
    ```

2. Create 5 workspaces. Open `System Settings` -> `Keyboard` -> `Keyboard Shortcuts`. Enable the `Mission Control` shortcuts, including `⌘` + `#` and `⌃` + `<-` / `->` to to switch between workspaces.

3. Open `System Settings` -> `Privacy & Security` -> `Accessibility`. Click the + button at the bottom left of the list view and enter your password to allow changes to the list.

4. Give `Terminal` full disk access through `Security & Privacy` -> `Privacy` -> `Full Disk Access`.

5. Download and run the [setup_mac.sh](https://github.com/joncrangle/.dotfiles/raw/main/setup_mac.sh) shell script.

```bash
curl -L https://raw.githubusercontent.com/joncrangle/.dotfiles/main/setup_mac.sh | sh
```

> [!TIP]
> If needed, make the script executable with
>
> ```bash
> chmod +x setup_mac.sh
> ```

6. The macOS setup process will begin by installing [Homebrew](https://brew.sh/), [chezmoi](https://chezmoi.io/), and Git.

7. Setup will walk you through authenticating with Github. It will then install the dotfiles and apps.

8. Give `WezTerm` full disk access through `Security & Privacy` -> `Privacy` -> `Full Disk Access`. Hide the menu bar in `System Settings` -> `Control Center` -> Automatically hide and show the menu bar -> Always.

9. Give `Yabai`, `Wezterm`, `skhd` accessibility permissions in `System Preferences` -> `Security & Privacy` -> `Accessibility`.

## 🪟 Windows

1. Download and run the [setup_win.ps1](https://github.com/joncrangle/.dotfiles/raw/main/setup_win.ps1) PowerShell script.

```powershell
iwr -useb https://raw.githubusercontent.com/joncrangle/.dotfiles/main/setup_win.ps1 | iex
```

> [!TIP]
> You might need to change the execution policy to `RemoteSigned` before running the script.
>
> ```powershell
> Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
> ```

2. The Windows setup process will begin by trying to install [PowerShell](https://apps.microsoft.com/detail/9mz1snwt0n5d?hl=en-US&gl=US), [Windows Terminal](https://apps.microsoft.com/detail/9n0dx20hk701?hl=en-US&gl=US) and [PowerToys](https://apps.microsoft.com/detail/xp89dcgq3k6vld?hl=en-US&gl=US).

3. Setup will then proceed to install [Scoop](https://scoop.sh/), [chezmoi](https://chezmoi.io/), Git and terminal apps.

4. After you authenticate with GitHub, it will install the dotfiles, configure PowerShell, and install apps.

> [!TIP]
> Some useful PowerToys settings that can be configured:
> 1. Enable FancyZones
> 2. File Explorer add-ons for previews
> 3. Enable Keyboard Manager and remap `Ctrl` + `F` to `F4` within `outlook`
>    Remap `Ctrl` + `Shift` + `O` and `Ctrl` + `Shift` + `M` to camera and microphone toggle buttons in `ms-teams`
> 4. Enable Paste as Plain Text
> 5. Enable PowerToys Run (adds Spotlight capability for Windows)
> 6. Enable Quick Accent for a desired language (e.g. French or Spanish)
>
> Within Taskbar Settings, automatically hide the taskbar in Desktop mode.

## 🧭 Keymapping

See [Keymapping](KEYMAPPING.md).
