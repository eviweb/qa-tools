# Quality Tools

This package provides a set of tools to ensure a level of quality and productivity adapted to the current state of the art in development.

## Install

Run the `./install.sh` command.  
By default it configures globally `Git` to use the [Git Hooks](#git-hooks) feature.  
By using the `-t` flag, it configures globally `Git` to use the [Git Templates](#git-templates) feature.  

> Please note that:
>
> * both [Git Hooks](#git-hooks) and [Git Templates](#git-templates) features are mutually exclusive.
> * already existing `Git` configuration are saved in order to be restored during uninstallation.

## Uninstall

Run `./install.sh -u`.

## Features

### Git Hooks

By default the hooks are the same as the ones provided by `Git` except for the following ones:

* `commit-msg`: this hook:  
  
  * ensures that the committed message follows the [Conventional Commits][conventional-commits] specification.
  * ensures that the commited message is enhanced by an icon corresponding to its type.  
    > Please refer to the `[commit_type_icons]` section of the [config.toml][config.toml] file to see or change icons.
  * allows a bunch of additional types.
    > Please refer to the `[commit_types]` section of the [cog.toml][cog.toml] file to see or change these additional types.

  The integration of this feature relies on the git configuration setting [core.hooksPath][core.hooksPath], set globally.

  > Additional types and icons were grandly inspired by the work of [Danny FRITZ (@dannyfritz)][danny-fritz] and [Danny (@its-danny)][danny].

### Git Templates

For now the templates are the same as the ones provided by `Git` except for the hooks which are symlinks to this package hooks.  
This is a convenient way to keep them in an up to date state.

The integration of this feature relies on the git configuration setting [init.templateDir][init.templateDir], set globally.

## Third party tools and libraries

Please refer to [thirdpartylibs.md][thirdpartylibs].

## Licence

This project is licensed under the terms of the [MIT License][license].

[cog.toml]: ./cog.toml
[config.toml]: ./config.toml
[conventional-commits]: https://www.conventionalcommits.org/en/v1.0.0/
[core.hooksPath]: https://git-scm.com/docs/githooks
[danny]: https://github.com/dannyfritz/commit-message-emoji/blob/master/README.md
[danny-fritz]: https://github.com/dannyfritz/commit-message-emoji/blob/master/README.md
[init.templateDir]: https://git-scm.com/docs/git-init#_template_directory
[license]: ./LICENSE
[thirdpartylibs]: ./thirdpartylibs.md
