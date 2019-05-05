# bash_sessions - Session manager for the Bash shell

## Installation

From the source directory run:

    $ make install

Then edit your .bashrc file to include ~/bin/bash_sessions by adding the following line:

    source ~/bin/bash_sessions

It is also recommended that you add $(__bs_ps1) in your prompt, so you can easily see when a session is active and which session it is.

For example, if your PS1 is defined like this:

    PS1='\u@\h:\w\$ '

you can change it to:

    PS1='\u@\h$(__bs_ps1):\w\$ '

For this to work, the "source ~/bin/bash_sessions" line must appear before the definition of PS1 in .bashrc.


## Features

bash_sessions lets you save and restore multiple shell "sessions". A session is identified by an arbitrary alphanumeric name, and it includes the following data:

* working directory
* command history
* environment variables
* output of the commands printed on the screen (up to the last 1000 lines)

Each one can be enabled or disabled individually for each session, but they are all active by default when a new session is created.

You will find this useful if you tipycally work with multiple terminal windows which have different usage patterns (e.g. for software compilation/installation, for navigating/searching files, for network troubleshooting...). If you use different sessions, you can close a terminal window, re-open it later and restore it to exactly the same state as when you closed it.

The main purpose of bash_sessions is to avoid confusion from multiple command histories when you work with multiple terminal windows in parallel. Depending on your settings, one of these two things can typically happen:

* when the last terminal window is closed, it overwrites the history of all the other terminal windows which were concurrently open.
* every command you execute (from any terminal window) is immediately appended to the history file, thus the commands from all the terminal windows will be interleaved seemingly randomly.

Instead, if you use different sessions for different activities, their command histories remain well separated, and additionally the working directory and the screen contents (up to 1000 lines) are retained. Basically, you can resume your work exactly from where you left it.

Another usage scenario is to easily restore your working environment after a power outage or a desktop crash. When a session is interrupted without being explicitly unloaded first, this can be detected and all the "pending" sessions can be resumed with a single command.



## Example

The first thing to do is to create a new session:

    me@localhost:~ $ n new_session
    me@localhost[new_session]:~ $

The new session is automatically loaded. From now on, the working directory, the command history, the environment variables and the output of the commands are saved to a dedicated directory.
Now we run some commands:

    me@localhost[new_session]:~ $ echo hello
    hello
    me@localhost[new_session]:~ $ cd /etc
    me@localhost[new_session]:/etc $ cat issue
    Debian GNU/Linux stretch/sid \n \l

    me@localhost[new_session]:/etc $ export FOO="BAR"
    me@localhost[new_session]:~ $ echo $FOO
    BAR
    me@localhost[new_session]:/etc $

Everything works as usual. The history contains "echo hello", "cd /etc" and "cat issue", and $FOO is expanded as BAR.
Now we close the session.

    me@localhost[new_session]:~ $ echo hello
    hello
    me@localhost[new_session]:~ $ cd /etc
    me@localhost[new_session]:/etc $ cat /etc/issue
    Debian GNU/Linux stretch/sid \n \l

    me@localhost[new_session]:/etc $ c
    me@localhost:~ $ echo $FOO

    me@localhost:~ $

Now the working directory is back to ~, the history does not contain any of "echo hello", "cd /etc" or "cat issue", and $FOO is empty.
Close the terminal window and open it again:

    me@localhost:~ $

Now re-open the session:

    me@localhost:~ $ o new_session
    me@localhost[new_session]:~ $ echo hello
    hello
    me@localhost[new_session]:~ $ cd /etc
    me@localhost[new_session]:/etc $ cat /etc/issue
    Debian GNU/Linux stretch/sid \n \l

    me@localhost[new_session]:/etc $ echo $FOO
    BAR
    me@localhost[new_session]:/etc $ c
    me@localhost[new_session]:/etc $

The working directory changed to /etc, and the output of the previous session appeared again. If you browse the history, you will find "echo hello", "cd /etc" and "cat issue" again. The shell is in the same state as it was before you closed the session!
You can repeat all of this for as many sessions as you like.
Now the most useful feature (IMHO). Close and re-open the terminal emulator without closing the session first, then type "a":

    me@localhost:~ $ a
    me@localhost:~ $

A separate terminal window should appear, where new_session has been automatically loaded.
If have more than one session saved, all the sessions which were not explicitly closed with "c" can be reloaded in dedicated terminal windows by just saying "a". That is, after a power outage or a crash in X.org, your terminal windows can be quicky restored as they were before.



## Command reference

bash_sessions defines the following commands that you can use:

    n <session_name>                create a new empty session
    o <session_name>                open an existing session
    c                               close currently active session
    f <session_name>                delete (forget) a session
    r <old_name> <new_name>         rename a session
    b <old_session> <new_session>   duplicate a session
    a                               re-open all previously loaded sessions in separate windows (requires the gtk-launch command, from the libgtk-3-bin package)
    e                               list existing sessions
    S <option> <on|off>             enable or disable options (output, pwd, env, history)

o, f, r, and S support automatic completion with the TAB key.

When using the "e" command, currently active sessions are marked with a \* sign. Also, sessions which are not active but have not been explicitly closed with "c" are marked with a + sign. Those can be restored using the "a" command.




## Contacts

Send comments, suggestions or bug reports to Alessandro Grassi <alessandro.g89@gmail.com>. Keep in mind that I do this on a best-effort basis, so don't expect frequent updates.
