# zsh-completions-git

This homebrew formula installs a `_git` symlink to the original
zsh-provided `_git` completion into `$(brew --prefix)/share/zsh-completions`,
which you can put at the front of your `$fpath` to override the `_git`
completion that the `git` formula oh-so-helpfully installs for you.

## Usage

Install with

    brew install univerio/zsh-completions-git/zsh-completions-git

Add it to your `$fpath` (same as [zsh-completions][1]):

    fpath=("$(brew --prefix)/share/zsh-completions" $fpath)

Remove `compinit` cache (and force it to regenerate it next time):

    rm ~/.zcompdump

[1]: https://github.com/zsh-users/zsh-completions

## Background

There are two git completion functions available. One is [provided by
git][2], and the other comes [built-in with zsh][3]. Homebrew "helpfully"
installs git's functions ahead of zsh's functions ([PR][4]), but added a
`--without-completions` flag ([PR][5]) after complaints ([issue][6]). This
option was then removed amid controversy ([issue][7]) as part of efforts to
remove *all* flags ([issue][8]).

This is the cleanest and most unintrusive way to fix it.

Some unsolicited commentary follows.

*Removing all flags is uncontroversial.*

The reason given is sound. Plus you can't (AFAIK) and don't need to use flags
in other package managers either.

*Preferring git-provided `_git` over zsh-provided `_git` is understandable.*

It's simply a matter of opinion.

*Installing git-provided `_git` ahead of zsh-provided `_git` is unforunate, and
should be remedied.*

git-provided `_git` is a contrib script; contrib files are in general not
loaded or activated in the default configuration. Just because it's part of the
tree does not mean it can or should be used. Allowing the user to easily elect
to use it is enough.

Even if it weren't a contrib script, it should *still* not be symlinked,
because this is a conflict, and conflicts need to be resolved by making a
choice. To say "go talk to upstream; we just package things" is irresponsible,
because one way or the other homebrew is making a choice: to symlink is to
choose git-provided `_git` over zsh-provided `_git`, and to do nothing is to
choose zsh-provided `_git` over git-provided `_git`. Here, the choice is
simple. Not symlinking it means users who want to use git-provided `_git` needs
to add the symlink, either manually or through a formula, and be done; however,
symlinking it means users who want to use zsh-provided `_git` need to either
manually *remove* the symlink (which is unclean, since the symlink is managed
by homebrew), or add it to somewhere else and then add the path ahead of the
default `$fpath` directories (which is what this formula does). The simpler
option should prevail.

*Locking the issue creates a hostile community and discourages discourse.*

Encountering rude or hostile users is unpleasant, to be sure, but the response
should be against the user, not the issue. Locking the issue *does* mildly
inconvenience the offender, but at the expense of the innocent. Users who
encounter this same problem in the future won't even be able to thumbs-up the
issue, let alone respond with better reasoning than offered so far -- it's the
same as saying "I know I'm right and I don't care what you think; please go
away". In that case, why not close down the project, or, better yet, GitHub
itself? That way nobody can *ever* be rude anymore.

[2]: https://github.com/git/git/blob/ecbdaf0899161c067986e9d9d564586d4b045d62/contrib/completion/git-completion.zsh
[3]: https://github.com/zsh-users/zsh/blob/325fceab3b4ffa871777bacc420e0e8efcb0afb9/Completion/Unix/Command/_git
[4]: https://github.com/Homebrew/legacy-homebrew/pull/16961
[5]: https://github.com/Homebrew/legacy-homebrew/pull/18180
[6]: https://github.com/Homebrew/legacy-homebrew/issues/16992
[7]: https://github.com/Homebrew/homebrew-core/issues/33275
[8]: https://github.com/Homebrew/homebrew-core/issues/31510
