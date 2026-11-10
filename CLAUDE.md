# Raylight video editing workspace

This repo is a workspace for editing motion design videos in Raylight
(raylight.app) through the Raylight connector. Edits happen live in the
user's browser tab; this repo only holds source media, helper scripts and
local renders.

## Every session

1. Call `get_editor_status`.
2. If no editor tab is connected, call `list_projects`, give the user the
   exact `editUrl` of the project they want, and wait for them to confirm
   it is open before making any edit.
3. If saves are not `ok`, tell the user before editing (edits would stay
   on their device only).

## Editing workflow

- Before the first `apply_edits` on a project, read
  `get_design_guide` with topic `craft-rules`.
- Read `get_project_overview`, then `get_shot_details` for any shot before
  changing it. Match the project's `styleDigest` colors and fonts unless
  asked otherwise.
- Batch creation and animation in one `apply_edits` call using `ref` /
  `$name` instead of round-tripping ids.
- After editing, check the result with `render_stills` or
  `render_filmstrip` and fix what reads wrong.
- Never export, share, invite members or spend workspace credits without
  the user asking.

## Local media

- Put source footage, images and audio in `media/`. They are not committed
  (see `.gitignore`); only `.gitkeep` is tracked.
- Prepare a file before `upload_media` with `scripts/prep-media.sh`, which
  makes web-friendly H.264/AAC MP4s and resizes large stills.
- Local renders and ffmpeg output go in `renders/` (also not committed).
- ffmpeg, ffprobe and ImageMagick are preinstalled in the cloud container.
