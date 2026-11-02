# Finding Linux Commands with `whatis` and `apropos`

## Learning Objectives

By the end of this lesson, students will be able to:

* Explain how `whatis` and `apropos` help locate Linux documentation.
* Use `whatis` to display a command's one-line description.
* Use `apropos` to search manual-page descriptions.
* Explain how these commands differ from `man`.
* Search by keyword and limit results to a manual-page section.

---

## Manual Page Database

Linux manual pages contain descriptions, syntax, options, and examples.
Commands such as `whatis` and `apropos` search an index of those manual
pages.

The index may need to be updated or created with:

```bash
sudo mandb
```

If `whatis` or `apropos` returns no results for recently installed commands,
updating the manual page database may resolve the problem.

---

## Using `whatis`

`whatis` displays a short description of a command or topic found in the
manual page database.

Basic syntax:

```bash
whatis command
```

Examples:

```bash
whatis ls
whatis grep
whatis passwd
```

Example result:

```text
ls (1) - list directory contents
```

The number in parentheses is the manual-page section. In this example,
section 1 contains general user commands.

### Specify a Manual Section

Use `-s` to limit results to a section:

```bash
whatis -s 1 passwd
whatis -s 5 passwd
```

This distinguishes the `passwd` command from the file-format documentation
for `/etc/passwd`.

---

## Using `apropos`

`apropos` searches manual-page names and descriptions for keywords.

Basic syntax:

```bash
apropos keyword
```

For example:

```bash
apropos copy
apropos network
apropos process
apropos password
```

Each result includes a page name, section, and short description.

```text
cp (1) - copy files and directories
```

`apropos` is useful when you know a task but not the command name.

### Search Multiple Keywords

Search for pages containing both words:

```bash
apropos copy files
```

The exact behavior depends on the version and the default regular-expression
mode, but this form searches for the supplied words.

### Search with Regular Expressions

Use `-r` for a regular-expression search:

```bash
apropos -r 'copy|move'
```

This finds descriptions that contain either `copy` or `move`.

### Limit Results by Section

Use `-s` to search only a manual-page section:

```bash
apropos -s 1 copy
apropos -s 5 password
apropos -s 8 service
```

Common manual sections include:

| Section | Purpose |
| --- | --- |
| 1 | User commands |
| 2 | System calls |
| 3 | Library functions |
| 4 | Special files and devices |
| 5 | File formats and configuration |
| 6 | Games |
| 7 | Miscellaneous documentation |
| 8 | System administration commands |

---

## Relationship Between the Commands

`whatis` and `apropos` are closely related to `man` options:

| Command | Purpose |
| --- | --- |
| `whatis ls` | Display the short `ls` description |
| `man -f ls` | Equivalent to `whatis ls` |
| `apropos copy` | Search descriptions for `copy` |
| `man -k copy` | Equivalent to `apropos copy` |

After locating a candidate page, open its full documentation:

```bash
man ls
man cp
man 5 passwd
```

---

## Typical Discovery Workflow

1. Search for a task-related keyword:

   ```bash
   apropos archive
   ```

2. Review the returned command names.
3. Confirm a short description:

   ```bash
   whatis tar
   ```

4. Read the complete manual page:

   ```bash
   man tar
   ```

---

## Practice Exercises

1. Display a short description of `grep`.

   ```bash
   whatis grep
   ```

2. Display the command description and file-format description of `passwd`.

   ```bash
   whatis -s 1 passwd
   whatis -s 5 passwd
   ```

3. Search the manual page database for commands related to compression.

   ```bash
   apropos compression
   ```

4. Search for pages related to network connections.

   ```bash
   apropos network
   ```

5. Search only user commands for copy operations.

   ```bash
   apropos -s 1 copy
   ```

6. Search for DNS-related manual pages.

   ```bash
   apropos dns
   ```

7. Open the manual page for a command found through `apropos`.

   ```bash
   apropos network
   man <command>
   ```

8. Confirm that the equivalent man commands work:

   ```bash
   man -f grep
   man -k network
   ```

---

## Key Takeaways

* `whatis` is for discovering what a known command does.
* `apropos` is for finding commands when you know only a keyword.
* `man` opens the complete documentation after a command is identified.
* Manual-page sections can narrow search results.
* `whatis` is equivalent to `man -f`.
* `apropos` is equivalent to `man -k`.
