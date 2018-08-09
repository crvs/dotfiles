export PATH=$PATH:/opt/ghci-color
export PATH=$PATH:$HOME/crvs/.cabal/bin

for build in `ls $HOME/.cabal-sandbox`;
    do if [[ -d $HOME/.cabal-sandbox/$build/bin ]];
        then export PATH=$PATH:$HOME/.cabal-sandbox/$build/bin ;
        fi;
    done
