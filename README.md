# Raylight editing workspace

A Claude Code workspace for editing motion design videos in
[Raylight](https://raylight.app) with the Raylight connector.

1. Open your project in Raylight in a browser tab.
2. Start a Claude Code session on this repo and describe the edit.
3. Claude checks the editor connection, edits live, and reviews its work
   with rendered stills.

Drop source files in `media/` and run `scripts/prep-media.sh <file>` to make
upload-ready copies in `renders/`. See `CLAUDE.md` for the full workflow.
