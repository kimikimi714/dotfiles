# rbenvの設定
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# scala path
export PATH="$HOME/Downloads/scala-2.11.6/bin:$PATH"

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
