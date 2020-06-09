### Aliases and Functions are usually in:
    bashrc
    function
    scripts
    zshrc

![alt text](http://i.imgur.com/EcQoF8a.gif)

### Fresh Install Info
    sudo pacman -S git stow
    mkdir -p ~/Public/gitrepo
    cd ~/Public/gitrepo
    git clone https://github.com/gotbletu/dotfiles_v2.git

    ## symlink all folders (trailing slash */) in dotfiles dir to home dir
    cd ~/Public/gitrepo/dotfiles_v2/normal_user
    stow -v -t ~ */

    # change to zsh shell
    sudo pacman -S zsh zsh-completions
    chsh -s /usr/bin/zsh

    ## if new folder is added then:
    # redo link (-R)
    cd ~/Public/gitrepo/dotfiles_v2/normal_user
    stow -v -R -t ~ */
    stow -v -R -t ~ tmux
    
    ## if folder was deleted then:
    # delete (-D flag then -R to relink)
    cd ~/Public/gitrepo/dotfiles_v2/normal_user
    stow -v -D -t ~ */
    stow -v -R -t ~ */

----

                 _   _     _      _
      __ _  ___ | |_| |__ | | ___| |_ _   _
     / _` |/ _ \| __| '_ \| |/ _ \ __| | | |
    | (_| | (_) | |_| |_) | |  __/ |_| |_| |
     \__, |\___/ \__|_.__/|_|\___|\__|\__,_|
     |___/

- http://www.youtube.com/user/gotbletu
- https://lbry.tv/@gotbletu
- https://twitter.com/gotbletu
- https://github.com/gotbletu
