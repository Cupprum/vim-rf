# vim-rf [![GitHub Actions Status](https://github.com/Cupprum/vim-rf/workflows/vim_robotframework/badge.svg)](https://github.com/Cupprum/vim-rf/actions)

## Features

This plugin adds Robot Framework language support for Vim, with the following main features:

* Syntax highlighting.
* Run current Robot Framework Test Case with `:RFTestCase`.
* Run all Test Cases inside current file `:RFTestFile`.
* Run all Test Cases inside current Test Suite / Directore `:RFTestDir`.
* Don not run Test Cases but only print names of TestCases which would be run by
  specifying flag `-l` after the command.
* Comment lines or blocks of Robot Framework code.
* Uncomment lines or blocks of Robot Framework code.

## Install

The [**latest stable release**](https://github.com/Cupprum/vim-go/releases/latest) is the
recommended version to use. If you choose to use the master branch instead,
please do so with caution; it is a _development_ branch.


vim-rf follows the standard runtime path structure. Below are some helper lines
for popular package managers:

* [Vim 8 packages](http://vimhelp.appspot.com/repeat.txt.html#packages)
  * `git clone https://github.com/Cupprum/vim-rf.git ~/.vim/pack/plugins/start/vim-rf`
* [Pathogen](https://github.com/tpope/vim-pathogen)
  * `git clone https://github.com/Cupprum/vim-rf.git ~/.vim/bundle/vim-rf`
* [vim-plug](https://github.com/junegunn/vim-plug)
  * `Plug 'Cupprum/vim-rf'`
* [Vundle](https://github.com/VundleVim/Vundle.vim)
  * `Plugin 'Cupprum/vim-rf'`

## Usage

The full documentation can be found at [doc/vim-rf.txt](doc/vim-rf.txt). You can
display it from within Vim with `:help vim-rf`.

Depending on your installation method, you may have to generate the plugin's
[`help tags`](http://vimhelp.appspot.com/helphelp.txt.html#%3Ahelptags)
manually (e.g. `:helptags ALL`).

Would you like to try this plugin before installation inside Vim environment? Now you can thanks to Docker. Just run `docker run --rm -it vimrobotframework/vim_rf:0.1.0 bash` and try it out. If you would like to edit Robot Framework Test Suite with this Contanier, just specify flag `-v $(pwd)/rf_project_directory:/rf_project_directory` to mount specific directory.

## Contributing

All PRs are welcome. If you are planning to contribute a large patch or to
integrate a new tool, please create an issue first to get any upfront questions
or design decisions out of the way first.

## License

The BSD 3-Clause License - see [`LICENSE`](LICENSE) for more details
