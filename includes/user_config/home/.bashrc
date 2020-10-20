# SSH setup
cp /mnt/ssh/* ~/.ssh/
chmod -R 700 ~/.ssh/config

# Inject the personal SSH username so it would be the same as on host
export SSH_PERSONAL_USERNAME=$(cat /mnt/ssh/username)
if [ -z "$SSH_PERSONAL_USERNAME" ]; then
  echo "'em-provisioning/includes/user_config/ssh/username' file must be created container personal username"
fi
sed -i "s/username-placeholder/$SSH_PERSONAL_USERNAME/g" ~/.ssh/config
