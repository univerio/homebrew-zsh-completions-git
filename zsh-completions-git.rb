class ZshCompletionsGit < Formula
  desc "Symlink for zsh's _git completion function"
  homepage "https://github.com/univerio/homebrew-zsh-completions-git"
  url "https://raw.githubusercontent.com/univerio/homebrew-zsh-completions-git/master/zsh-completions-git.tar.gz"
  version "0.0.1"
  sha256 "fb930fdaf2e3125ca23d5e3d706b4c6ceecd88923b936b5234f04e31f7cbd23f"
  depends_on "zsh"

  bottle :unneeded

  def completion
    share/"zsh-completions"
  end

  def install
    mkdir completion
    ln_sf HOMEBREW_PREFIX/"share"/"zsh"/"functions"/"_git", completion
  end

  test do
    system "zsh", "-c", <<~HEREDOC
      fpath=(#{sh_quote(completion)} $fpath)
      autoload -U compinit
      compinit -D -u
      autoload -Ur _git
      echo $functions_source[_git]
      [[ $functions_source[_git] = #{sh_quote(completion/"_git")} ]]
    HEREDOC
  end
end
