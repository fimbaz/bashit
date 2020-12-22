all:
	cargo build --release
	sudo cp target/release/bashit /usr/local/bin/bashit
	sudo cp prompt_command.bash /usr/local/bin/prompt_command.bash
	sudo cp bashit.bash /usr/local/bin/
	echo 'alias ssh=/usr/local/bin/bashit.bash' >> ~/.bashrc
