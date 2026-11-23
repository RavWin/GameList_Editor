# Changelog

All notable changes to this project are documented in this file.

## [Unreleased]

### Added
- **Progress bar while loading a system folder.**
  - New two-pass loading in `BuildSystemsList`: a first pass (`CountGamesInFile`) counts all games to size the progress bar accurately before loading.
  - `BuildGamesList` now accepts an optional `aProgress` flag to advance the progress bar and pump messages during the long synchronous load.
  - Folder auto-load on startup is now deferred with `PostMessage(Handle, WM_APP+1, 0, 0)` to a new `WMAutoLoad` handler, so the form window and progress bar are visible during the load.
- **Build script `build.cmd`** for building the project from the command line.
  - Resolves `rsvars.bat` from the `RSVARS` variable or `PATH` (Delphi 12 / Studio 23.0).
  - `BUILD_CONFIG` / `BUILD_PLATFORM` are set after `rsvars.bat` so they are not overwritten by the Delphi environment.
  - Builds `GameListEditor.dproj` for the requested platform; builds the Win32-only `pkg_windowsmediaplayer.dproj` separately and only on non-Win64 targets.
- **Context menu on the Picture tab** (`Tbs_Picture` → `pmPicture`): Change Picture, Change Picture to default, Delete Picture.
- **Context menu on the Video tab** (`Tbs_Video` → `pmVideo`): Change Video, Delete Video.
- **"Change all missing pictures to default"** command added to the game list context menu (`pmGameList`).
- **Selected game system is now remembered.** The last selected system (by folder name) is saved alongside the root folder in `Resources\Settings.ini` and restored after the systems list is built.

### Changed
- Moved the media context-menu commands off the Controls tab (`tsControls`) onto the Picture and Video tabs. `tsControls` no longer has a popup menu.
- `pmControls` / `pmControlsPopup` replaced with `pmPicture` / `pmPicturePopup` and `pmVideo` / `pmVideoPopup`.
- `pkg_windowsmediaplayer.dpk` / `.dproj`: replaced obsolete `..\..\22.0\Imports\WMPLib_TLB.*` paths (Delphi 22.0) with the local `WMPLib_TLB.pas`.

### Fixed
- Windows Media Player package no longer references the non-existent `..\..\22.0\Imports\WMPLib_TLB.dcr` resource, allowing the Win32 build to succeed on Delphi 23.0.