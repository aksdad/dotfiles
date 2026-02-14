# GitHub SSH Setup (macOS)

## 1. Generate a new SSH key
`ssh-keygen -t ed25519 -C "your_email@example.com"`

- Press **Enter** to accept the default file location.
- Enter a **passphrase** when prompted.

## 2. Start the SSH agent
`eval "$(ssh-agent -s)"`

## 3. Configure SSH to use the key and Keychain
Create or edit `~/.ssh/config`:
```
    Host github.com
      AddKeysToAgent yes
      UseKeychain yes
      IdentityFile ~/.ssh/id_ed25519
```
## 4. Add the key to the SSH agent
`ssh-add --apple-use-keychain ~/.ssh/id_ed25519`

## 5. Add the public key to GitHub
Copy the public key:
`pbcopy < ~/.ssh/id_ed25519.pub`

Then go to **GitHub → Settings → SSH and GPG keys → New SSH key** and paste it.
