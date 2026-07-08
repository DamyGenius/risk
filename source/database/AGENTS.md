# Database Folder Instructions

- Treat SQL and PL/SQL files under this folder as Windows-1252 / ANSI by default.
- Preserve the existing encoding of any file being edited. Do not silently convert legacy ANSI files to UTF-8.
- For new database scripts and migrations, prefer Windows-1252 / ANSI. ASCII-only content is acceptable because it is compatible with Windows-1252.
- Avoid accented characters in new migration text unless they are needed; if used, save them as Windows-1252.
- When editing with automation, read and write legacy database files as bytes or Windows-1252-compatible text to avoid mojibake.
