#! /usr/bin/env bash
main_dir()
{
	dirname "$(readlink -f ${BASH_SOURCE})"
}

backup_dir()
{
	echo "$(main_dir)/.backup"
}

templates_dir()
{
	echo "$(main_dir)/templates"
}

usage()
{
	cat <<USAGE
./install.sh [OPTIONS]

Options:
	-h			display this help
	-t			globally configure git to use all templates
	-u			uninstall

By default, if the -t flag is not used, globally configure git to use ./templates/hooks
USAGE
}

GIT_BACKUP_FILE="$(backup_dir)/gitconfig"
INSTALL_TEMPLATES=1
INSTALLED_FILE="$(main_dir)/.installed"

declare -A GIT_CURRENT_CONFIGS=(
	["core.hooksPath"]="$(git config --global --get core.hooksPath)"
	["init.templateDir"]="$(git config --global --get init.templateDir)"
)

declare -A GIT_CONFIG_VALUES=(
	["core.hooksPath"]="$(templates_dir)/hooks"
	["init.templateDir"]="$(templates_dir)"
)

backup()
{
	mkdir -p "$(backup_dir)"

	backup_git_config
}

backup_git_config()
{
	[ -e "${GIT_BACKUP_FILE}" ] || touch "${GIT_BACKUP_FILE}"

	for key in "${!GIT_CURRENT_CONFIGS[@]}"; do
		local value="${GIT_CURRENT_CONFIGS["${key}"]}"
		if [ -n "${value}" ] && [[ "${value}" != "${GIT_CONFIG_VALUES["${key}"]}" ]]; then		
			if grep "${key}" "${GIT_BACKUP_FILE}" &>/dev/null; then
				sed -i -re "s/^${key/./\\.}[^\n]+/${key} ${value//\//\\\/}/" "${GIT_BACKUP_FILE}"
			else
				echo "${key} ${value}" >> "${GIT_BACKUP_FILE}"
			fi
		fi
	done
}

_detect_package_manager()
{
	if [ -n "${TERMUX_VERSION:-}" ] || [ -d "/data/data/com.termux" ]; then
		echo "termux"
	elif command -v apt-get &>/dev/null; then
		echo "apt"
	else
		echo "unknown"
	fi
}

_try_install()
{
	local -a cmd=("$@")
	printf "  Run: %s\n  Install now? [y/N] " "${cmd[*]}" >&2
	local answer
	read -r answer </dev/tty
	if [[ "${answer,,}" == "y" ]]; then
		"${cmd[@]}" || {
			echo "Error: installation failed — install libgit2 manually and re-run." >&2
			return 1
		}
	else
		echo "  Skipped. The commit-msg hook will not validate messages until libgit2 is installed." >&2
	fi
}

check_cog_dependency()
{
	"$(main_dir)"/bin/cog --version &>/dev/null 2>&1 && return 0

	echo "" >&2
	echo "Warning: cog cannot run — libgit2 is missing." >&2
	echo "  The commit-msg hook requires libgit2 to validate commit messages." >&2

	case "$(_detect_package_manager)" in
		termux)
			_try_install pkg install libgit2
			;;
		apt)
			_try_install sudo apt-get install -y libgit2-dev
			;;
		*)
			echo "  Install libgit2 for your system then re-run this installer." >&2
			echo "  See: https://libgit2.org/" >&2
			;;
	esac
	echo "" >&2
}

link_hooks()
{
	for hook in "$(main_dir)"/src/git/hooks/*; do
		ln -sf "${hook}" "$(templates_dir)"/hooks
	done
}

check_git_config()
{
	[ "$(git config --global "$1")" == "$2" ]
}

set_git_config()
{
	git config --global "$1" "$2"
}

unset_git_config()
{
	git config --global --unset "$1"
}

restore()
{
	restore_git_config 	
}

restore_git_config()
{
	if [ -f "${GIT_BACKUP_FILE}" ]; then
		cat "${GIT_BACKUP_FILE}" | while read -r conf; do
			[ -n "${conf}" ] && set_git_config "${conf% *}" "${conf#* }"
		done

		echo > "${GIT_BACKUP_FILE}"
	fi
}

is_installed()
{
	[ -f "${INSTALLED_FILE}" ]
}

install()
{
	is_installed && uninstall

	backup
	link_hooks
	check_cog_dependency
	install_git
	touch "${INSTALLED_FILE}"
}

install_git()
{
	if [[ "${INSTALL_TEMPLATES}" -eq 0 ]]; then
		check_git_config "core.hooksPath" "${GIT_CONFIG_VALUES[core.hooksPath]}" && unset_git_config "core.hooksPath"
	 	set_git_config "init.templateDir" "$(templates_dir)"
	else
		check_git_config "init.templateDir" "${GIT_CONFIG_VALUES[init.templateDir]}" && unset_git_config "init.templateDir"
		set_git_config "core.hooksPath" "$(templates_dir)/hooks"
	fi
}

uninstall()
{
	uninstall_git

	restore
	unlink "${INSTALLED_FILE}"
}

uninstall_git()
{
	for key in "${!GIT_CURRENT_CONFIGS[@]}"; do
		unset_git_config "${key}"
	done
}

while getopts ":htu" option
do
	case $option in
		t)
			INSTALL_TEMPLATES=0
			;;
		u)
			is_installed && uninstall
			exit $?
			;;
		h) 
			usage
			exit 0
			;;
		\?) usage
			exit 1
			;;
	esac
done

install
