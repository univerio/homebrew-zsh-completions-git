class ZshCompletionsGit < Formula
  desc "Symlink for zsh's _git completion function"
  homepage "https://github.com/univerio/homebrew-zsh-completions-git"
  url "https://raw.githubusercontent.com/univerio/homebrew-zsh-completions-git/master/zsh-completions-git.tar.gz"
  version "0.0.1"
  sha256 "fb930fdaf2e3125ca23d5e3d706b4c6ceecd88923b936b5234f04e31f7cbd23f"
  license :public_domain

  bottle do
    root_url "https://github.com/univerio/homebrew-zsh-completions-git/releases/download/zsh-completions-git-0.0.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "86e4c5c474be81b272ef5959693de0b939336dd9b779dc422a3659a84ff715a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5131adceb9289e188ccd1770399f78c8d1b9ab9d27bf99f8fd9e785687557ffb"
  end
  depends_on "zsh"

  def share_zsh_completions
    share/"zsh-completions"
  end

  def install
    share_zsh_completions.install_symlink HOMEBREW_PREFIX/"share"/"zsh"/"functions"/"_git"
  end

  test do
    system "zsh", "-c", <<~HEREDOC
      fpath=(#{sh_quote(share_zsh_completions)} $fpath)
      autoload -U compinit
      compinit -D -u
      autoload -Ur _git
      echo $functions_source[_git]
      [[ $functions_source[_git] = #{sh_quote(share_zsh_completions/"_git")} ]]
    HEREDOC
  end
end
