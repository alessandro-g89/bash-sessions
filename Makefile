INSTALL_DIR=~/bin

all:
	@echo "Please run 'make install'"

install:
	install -m 755 bash_sessions $(INSTALL_DIR)
	@echo ""
	@echo "Installation completed. Please add 'source $(INSTALL_DIR)/bash_sessions' to your .bashrc file"
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
	@echo 'f <session_name>          delete (forget) a session'
	@echo 'r <old_name> <new_name>   rename a session'
	@echo 'a                         re-open all previously loaded sessions in separate windows'
	@echo 'e                         list existing sessions'

.PHONY: all install
