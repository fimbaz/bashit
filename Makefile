all:
	cargo build release
	cp target/release/bashit /usr/local/bin/bashit
	cp prompt_command.bash /usr/local/bin/prompt_command.bash
	cp bashit.bash /usr/local/bin/
