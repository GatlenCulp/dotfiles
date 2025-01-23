# Common Chezmoi Commands

Here are some common commands I use:

For [editing](https://www.chezmoi.io/user-guide/frequently-asked-questions/usage/):
(Note: `target state` means your home directory while `source state` means chezmoi setup directory)

- `chezmoi re-add` -- Re-add modified files in the target state, preserving any encrypted\_ attributes. chezmoi will not overwrite templates, and all entries that are not files are ignored. Directories are recursed into by default.
- `chezmoi apply` -- Reverse of chezmoi re-add if you edit the files within the source directory
