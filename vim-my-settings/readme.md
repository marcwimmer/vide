VIM My Settings
===============

Hier sind alle Customizations an Vim enthalten. Die Struktur ist uebersichtlich
(sehr schlanke .vimrc < 30 Zeilen!). Die meisten Einstellungen befinden sich
in plugin/settings/*.vim. Diese Dateien werden beim Start von vim automatisch
geladen.

Mit Hilfe von vundle werden alle Pakete gemanaged. Es lassen sich damit
problemlos Pakete installieren, deinstallieren und updaten.

Initial-Setup
=================
<b style="color: red">CAUTION: backup your .vimrc and .vim before!</b>
<pre>
rm ~/.vimrc
rm -Rf ~/.vim ~/.vim-mysettings
mkdir ~/.vim-mysettings
cd ~/.vim-mysettings
mkdir .vim plugins
cd plugins
git clone https://github.com/marcwimmer/vim-my-settings.git
cd 
echo Setting the initial .vimrc
ln -s .vim-mysettings/plugins/vim-my-settings/.vimrc
ln -s .vim-mysettings/.vim

echo "setting up vundle, see: https://github.com/gmarik/Vundle.vim"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# two times: first round install settings, then install plugins self
echo | echo | vim +PluginInstall +qall &>/dev/null
echo | echo | vim +PluginInstall +qall &>/dev/null

echo In future do updates with :PluginUpdate
echo List your Plugins with :PluginList
</pre>

<h2>
Then Run again:
</h2>
<pre>
vim +PluginInstall +qall now
</pre>

<h1>Install vim with lua for neocomplete</h1>
<pre>
sudo su
brew unlink vim
brew unlink macvim
brew uninstall vim 
brew uninstall macvim
brew install macvim --with-lua --with-cscope
brew install vim --with-lua
</pre>


<h1>Add a new bundle</h1>
Please edit .vim/bundles/vim-my-settings/plugin/settings/bundles.list
