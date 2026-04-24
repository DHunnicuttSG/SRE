# Vim Commands

Vim commands are categorized by the mode you are in: Normal, Insert, Visual, and Command-Line (Ex) mode. 
Normal Mode (Default mode for navigation and manipulation): 

### Movement: 
	• h, j, k, l: Move cursor left, down, up, right.  
	• w, b: Move forward/backward by a word.  
	• 0, ^, $: Move to the beginning of the line, first non-blank character, end of the line.  
	• gg, G: Move to the first/last line of the file.  
	• Ctrl+f, Ctrl+b: Move forward/backward one full screen.  

### Editing:  
	• x: Delete character under the cursor.  
	• dd: Delete the current line.  
	• dw: Delete a word.  
	• u: Undo the last change.  
	• Ctrl+r: Redo the last change.  
	• yy: Yank (copy) the current line.  
	• p: Put (paste) after the cursor.  

### Searching:  
	• /pattern: Search forward for pattern.  
	• ?pattern: Search backward for pattern.  
	• n, N: Repeat search forward/backward. [1]   

## Insert Mode (For typing text):  

	• i: Insert before the cursor.  
	• a: Append after the cursor.  
	• o: Open a new line below and enter insert mode.  
	• A: Append at the end of the line.  
	• Esc: Exit Insert mode and return to Normal mode.  

## Visual Mode (For selecting text):  
	v: Enter character-wise visual mode,  
	V: Enter line-wise visual mode,  
	Ctrl+v: Enter block-wise visual mode,  
	y: Yank (copy) selected text, and  
	d: Delete selected text. 

## Command-Line (Ex) Mode (For executing commands): 
	• :w: Write (save) the current file.  
	• :q: Quit Vim.  
	• :wq or ZZ: Save and quit.  
	• :q!: Quit without saving.  
	• :e filename: Open filename.  
	• :%s/old/new/g: Replace all occurrences of old with new in the entire file.  

This is a selection of commonly used commands; Vim offers a vast array of functionalities and commands for efficient text editing. 


Ref: https://vimtricks.com/p/50-useful-vim-commands/  

