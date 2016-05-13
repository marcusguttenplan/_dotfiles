#DOTFILES

These are for syncing across devices and new servers, because life is hard when the keys change.

edit `.bash_profile`

```
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
```

and then add the above `.bashrc` file.




Shamelessly lifted from [Nate Landau](https://natelandau.com/my-mac-osx-bash_profile/) (Thank you).
