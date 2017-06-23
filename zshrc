# Any process running as $USER can theoretically modify my zshrc
# to insert malicious code. Consider the following example:
# sudo() { # Do something malicious here to get my password... }
# To prevent this I check the sha256sum of my real zshrc before
# sourcing it. This file should be owned by root and the read-only
# attribute (chattr +i .zshrc) set so that it CANNOT be modified
# by my own user, only read.
SHA256SUM=$(sha256sum "$HOME/.real_zshrc" | sed 's/ .*//g')
if [[ "$SHA256SUM" == "d3d8a905052706b184de0788a8efc2bc0dd46c2a730029f8877ae013af7ddbe7" ]]
then
  source "$HOME/.real_zshrc"
else
  printf "\033[31mERROR: \033[0mThe sha256sum doesn't match. Has something modified your zshrc?\n"
fi
