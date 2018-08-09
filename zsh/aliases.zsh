# aliases concerning ls
alias ls="ls --color=auto --hide='*~' --hide='*.pyc' --hide='*\\~'"
alias ll="ls -lh"
alias la="ls -a"
alias lla="ls -l -a"

# grep should always be colored
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"

# don't show the value of erase when reseting
alias reset="reset -Q"

alias open="xdg-open"

# aliases for several screen modes
resetxmonad=" && killall dzen2 || true && xmonad --restart "
alias dualVGAlm="xrandr --output VGA1 --primary --auto  --left-of LVDS1 --output LVDS1 --auto"$resetxmonad
alias dualVGAls="xrandr --output VGA1 --auto  --left-of LVDS1 --output LVDS1 --primary --auto"$resetxmonad
alias dualVGAlr="xrandr --output VGA1 --rotate left --auto --left-of LVDS1 --output LVDS1 --primary --auto"$resetxmonad
alias dualVGArs="xrandr --output VGA1 --auto --right-of LVDS1 --output LVDS1 --primary --auto"$resetxmonad
alias dualVGArr="xrandr --output VGA1 --rotate left --auto --right-of LVDS1 --output LVDS1 --primary --auto"$resetxmonad
alias dualVGArm="xrandr --output VGA1 --primary --auto --right-of\
		 LVDS1 --output LVDS1 --auto --rotate normal"$resetxmonad
		 alias dualVGAa="xrandr --output VGA1 --auto  --above LVDS1 --output LVDS1 --primary --auto"$resetxmonad
		 alias dualVGA="dualVGArm"

		 alias dual="xrandr --output VGA1 --primary --mode 1920x1200_60.00 --left-of LVDS1 --output LVDS1 --auto"$resetxmonad
		 alias monoLVDS="xrandr --output VGA1 --off --output LVDS1 --primary --auto"$resetxmonad
		 alias monoVGA="xrandr --output VGA1 --primary --auto --output LVDS1 --off"$resetxmonad

# df should always be human readbale with type
		 alias df="df -Th"

# alias for connecting a known network
# alias connect="sudo killall wpa_supplicant dhcpcd || true \
# && sudo wpa_supplicant -Dwext -iwlp3s0 -c/etc/wpa_supplicant/gather.conf -B \
# && sudo dhcpcd"
# alias to restart dhcp client
# alias reip="sudo killall dhcpcd 2>/dev/null || true && sudo ip address flush dev wlp3s0 && sudo ip address flush dev enp12s0 && sudo dhcpcd"

# archey is archey3
#alias archey="clear && archey3"

# make an alias to edit the xmonad config
		 alias vimonad="vim $HOME/.xmonad/xmonad.hs"

# start torrenting with aria2c and download the file "download" containing the magnet links
		 alias startdl="aria2c -c true -i download --seed-ratio=2"

# run X scripts concerning xrdb keyboard layout and all of that
# should try to make this all work seamlessly in the future
		 alias rinit="$HOME.rinit"

# default flags fot mplayer
		 alias mplayer="mplayer -fs -softvol-max 1000"
		 alias vcal="vim +Calendar"

# locate doesn't care about case
		 alias locate="locate -i"

# prepare zip from git to send
		 function archive {
			 ng="/tmp/$@"
				 if [[ -d $@ ]];
			 then
				 cp -r $@ $ng
				 find $ng -name "\.*" -exec rm -rf {} \;
			 find $ng -name "*~" -exec rm -rf {} \;
			 zip -r $@`date +"%b%d"`.zip $ng
				 rm -rf $ng
				 else
					 echo "folder not found: "$@
						 fi
		 }

# function to easily change the names of a whole folder of mp3s with the format "track - title.mp3"
function mp3Rename {
	IFS=$'\n'   # reassign the internal field separator
		for file in $(ls *.mp3); do
			mv $file `mp3info -p "%02n - %t.mp3" $file`
				done
				IFS=$'\ '   # restore IFS to default
}

alias gitwatch="watch --color 'git log --color --oneline --all --graph --decorate'"

# personal calendar command
alias calendar="vim -c:Calendar"

# function vimserver {
#     vim --serverlist | grep VIM 1>& /dev/null
#     if [[ $? == 0 ]]
#     then vim --remote-silent $@
#     else vim --servername VIM $@
#     fi
# }
# alias vim="vimserver"

#start transmission
alias transmission="transmission-daemon -er"

alias pgp="gpg"

alias da="du -a"
alias mps="/opt/mps/mps"
alias pms="/opt/mps/mps"
alias j="jump"
alias xscreensaver="setsid xscreensaver -no-splash"

# alias ghci="ghci-color"
# alias grep="grep --exclude=.cvs --exclude=.hg --exclude=.svn --exclude=.git"

function scrolltree { tree $@ | less}
alias tree="scrolltree"

function startssh { eval "$(keychain --eval github --timeout 60)" }

alias cwd="cd ."
alias zathura="setsid zathura 2>& /dev/null"
alias nbr2mp4="/opt/nbr2_mp4/nbr2mp4"

function mkcd { mkdir $@ 2>& /dev/null || let EXIT_STATUS=$? ; cd $@ ; return $EXIT_STATUS }

# timetrap
alias tt='timetrap'
export fpath=(~/.gem/ruby/2.5.0/gems/timetrap-1.15.1/completions/zsh $fpath)

# todotxt
alias todotxt="todo.sh"
function t { if [ $# = 0 ]; then todotxt ls; else todotxt $@; fi }
compdef t='todo.sh'

alias py="ipython3"
alias mutt=neomutt

alias mps=/opt/mps/mps
alias pms=/opt/mps/mps

# tmuxinator
source ~/.dotfiles/tmux/tmuxinator.zsh
alias mux='tmuxinator'
#alias vim=nvim
alias vim='vim --servername VIM'
compdef mux='tmuxinator'

