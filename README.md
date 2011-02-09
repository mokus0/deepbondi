This is my collection of shell utilities, login scripts, etc., that I've accumulated over the years.  Typically I install this as `/deepbondi` and make my `~/.bashrc` and `~/.bash_profile` source the respective files in `/deepbondi/etc`.  It is also possible to change the directory it will expect to find itself by setting the environment variable `deepbondi`.

Some of the odd and/or useful things included:

 - `excel_sheeter`: a script that takes an excel workbook and uses AppleScript to tell excel to open it up and save each sheet as a separate CSV file.  For obvious reasons, this command is only placed into the `PATH` on Mac OS systems.
 - `hilite`: kind of like a super-lightweight `grep` that simply colors occurrences of a pattern without otherwise altering the stream.
 - `deref`: tracks down the path of the real file on disk referred to by an arbitrarily-long chain of symlinks.
 - `path`: accepts a command as its argument, splits the `PATH` environment variable into its components and feeds them to the command, one on each line.  The resulting lines are re-packed in the same format and printed.  For example:

    export PATH="\`path grep -v foo/bar\`"

 - `join`: packs its arguments into a string in the format expected for a `PATH` or `CLASSPATH` variable, including selecting the right delimiter for the platform (`:` for *NIX, ';' for Windows).

This code is primarily for my own use, but If you like it you're free to use it in any way you wish.  If you have suggestions or improvements I'd also be glad to hear about them.  This code is provided as-is, without any warrantee, express or implied - not even the implied warrantees of merthantability or fitness for a particular purpose.