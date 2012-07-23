This is my collection of shell utilities, login scripts, etc., that I've accumulated over the years.  Typically I install this as `/deepbondi` and make my `~/.bashrc` and `~/.bash_profile` source the respective files in `/deepbondi/etc`.  It is also possible to change the directory it will expect to find itself by setting the environment variable `deepbondi`.

Some of the odd and/or useful things included:

 - `gitignore`: a script that generates a .gitignore file based on a list of templates from github's `gitignore` repo.
 - `excel_sheeter`: a script that takes an excel workbook and uses AppleScript to tell excel to open it up and save each sheet as a separate CSV file.  For obvious reasons, this command is only placed into the `PATH` on Mac OS systems.
 - `hilite`: kind of like a super-lightweight `grep` that simply colors occurrences of a pattern without otherwise altering the stream.
 - `deref`: tracks down the path of the real file on disk referred to by an arbitrarily-long chain of symlinks.
 - `path`: accepts a command as its argument, splits the `PATH` environment variable into its components and feeds them to the command, one on each line.  The resulting lines are re-packed in the same format and printed.  For example:

    export PATH="$(path grep -v foo/bar)"

 - `join`: packs its arguments into a string in the format expected for a `PATH` or `CLASSPATH` variable, including selecting the right delimiter for the platform (`:` for *NIX, ';' for Windows).
 - `await`: just waits until the named file/files exists/exist.  Mostly useful for throwing together big ugly shell one-liners which need to wait for a file to exist or a filesystem to mount, etc..
 - `gitignore`: prints a .gitignore file to stdout containing the contents of all files from [this repo](https://github.com/github/gitignore.git) listed on the command line.  For example, I often set up my Haskell repos with:

    gitignore Global/OSX Haskell > .gitignore

 - `remote`: a wrapper around `ssh` that sets up DISPLAY on the remote system to point back to the current one, transferring `xauth` settings as well (assuming `get-local-xauth` is working... that one's a little flaky).  If run via a symlink, uses the link's name as the hostname.
 - `guess`: a silly little number guessing game that cheats.
 - `sortHsImports`: does what its name suggests.  Pipe your haskell imports through it and it'll make a big mess if they're not in the format it expects.
 - `wrap`: reads stdin, word-wraps it, and puts it on stdout.

This code is primarily for my own use, but If you like it you're free to use it in any way you wish.  If you have suggestions or improvements I'd also be glad to hear about them.  This code is provided as-is, without any warrantee, express or implied - not even the implied warrantees of merthantability or fitness for a particular purpose.
