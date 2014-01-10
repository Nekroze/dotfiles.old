# EturnilNetwork theme by Nekroze
# Designed for an oh-my-zsh enhanced zsh shell

# Color shortcuts
RED=$fg[red]
YELLOW=$fg[yellow]
GREEN=$fg[green]
WHITE=$fg[white]
BLUE=$fg[blue]
RED_BOLD=$fg_bold[red]
YELLOW_BOLD=$fg_bold[yellow]
GREEN_BOLD=$fg_bold[green]
WHITE_BOLD=$fg_bold[white]
BLUE_BOLD=$fg_bold[blue]
RESET_COLOR=$reset_color

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""

# Format for parse_git_dirty()
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$RED%}unmerged"
ZSH_THEME_GIT_PROMPT_DELETED=" %{$RED%}deleted"
ZSH_THEME_GIT_PROMPT_RENAMED=" %{$YELLOW%}renamed"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$GREEN%}modified"
ZSH_THEME_GIT_PROMPT_ADDED=" %{$GREEN%}added"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$WHITE%}untracked"

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$YELLOW%}(!)"

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$YELLOW%}[%{$RED%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$YELLOW%}]"

# Remove virtualenv brackets
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX=""
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="%{$RESET_COLOR%}%{$GREEN%}><"

# Prompt format
PROMPT=$'%{$GREEN%}┌<%{$YELLOW%}%n@%m%{$GREEN%}> %{$BLUE_BOLD%}%~%u %{$RESET_COLOR%}
%{$GREEN%}└<%{$BLUE_BOLD%}$(virtualenv_prompt_info)%{$BLUE_BOLD%}$(current_branch)%{$RESET_COLOR%}%{$GREEN%}>%{$RESET_COLOR%}'
RPROMPT=$'$(parse_git_dirty)$(git_prompt_ahead)$(git_prompt_status)%{$RESET_COLOR%}$(git_prompt_short_sha)%{$BLUE%}%{$RESET_COLOR%}'
