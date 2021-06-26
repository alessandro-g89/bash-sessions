prefix=/usr/local

all:
	@echo "Please run 'make install'"

install:
	mkdir -p $(DESTDIR)$(prefix)/bin
	install -m 755 bash_sessions $(DESTDIR)$(prefix)/bin/bash_sessions
	@echo ""
	@echo "Installation completed. Please add 'source $(DESTDIR)$(prefix)/bin/bash_sessions' to your .bashrc file"
	@echo ""
	@echo "You may also want to add \$$(__bs_ps1) in the PS1 environment variable defined in .bashrc, e.g."
	@echo ""
	@echo "    PS1='\u@\h\$$(__bs_ps1):\w\$$ '"
	@echo ''
	@echo 'USAGE:'
	@echo '------'
	@echo 'n <session_name>          create a new empty session'
	@echo 'o <session_name>          open an existing session'
	@echo 'c                         close currently active session'
	@echo 'f <session_name>          delete an existing session'
	@echo 'r <old_name> <new_name>   rename an existing session'
	@echo 'b <old_name> <new_name>   duplicate an existing session'
	@echo 'e                         list existing sessions'
	@echo 'S <option> <on|off>       enable or disable options (output, pwd, env, history)'
	@echo 'L                         list settings for current session'
	@echo 'h                         show command reference'

.PHONY: all install

