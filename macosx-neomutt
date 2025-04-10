# Setup Neomutt on macOS

## Install packages

```sh
brew install neomutt isync msmtp notmuch khard vdirsyncer fzf terminal-notifier
```

## Required directories

```sh
mkdir -p \
  ~/.config/mutt \
  ~/.config/khard \
  ~/.config/vdirsyncer \
  ~/.local/bin \
  ~/.local/var \
  ~/.mail/icloud \
  ~/.contacts/icloud/card
```

## Configuration files

- `~/.config/mutt/muttrc`
- `~/.mbsyncrc`
- `~/.msmtprc`
- `~/.notmuch-config`
- `~/.config/khard/khard.conf`
- `~/.local/bin/mail-sync-notify.sh`
- `~/.config/vdirsyncer/config`

## Features

- Offline-first email client
- IMAP sync via `mbsync`
- SMTP sending via `msmtp`
- Powerful search with `notmuch`
- Autocomplete contacts with `khard` and iCloud CardDAV
- macOS native notifications for new mail via `terminal-notifier`

## Configuration examples

### `~/.mbsyncrc`

```ini
IMAPAccount icloud
Host imap.mail.me.com
User your_email@icloud.com
PassCmd "pass your_pass_db/apple-icloud-generated-app-specific-passwords-for-neomutt"
TLSType IMAPS
AuthMechs LOGIN

IMAPStore icloud-remote
Account icloud

MaildirStore icloud-local
Path ~/.mail/icloud/
Inbox ~/.mail/icloud/INBOX
SubFolders Verbatim

Channel icloud
Master :icloud-remote:
Slave :icloud-local:
Patterns *
Create Both
Sync All
Expunge Both
```

### `~/.msmtprc`

```ini
defaults
auth           on
tls            on
tls_trust_file /etc/ssl/cert.pem
logfile        ~/.msmtp.log

account        icloud
host           smtp.mail.me.com
port           587
from           your_email@icloud.com
user           your_email@icloud.com
passwordeval   pass your_pass_db/apple-icloud-generated-app-specific-passwords-for-neomutt

account default : icloud
```

### `~/.notmuch-config`

```ini
[database]
path=~/.mail/icloud

[user]
primary_email=your_email@icloud.com

[search]
exclude_tags=spam;junk;

[maildir]
synchronize_flags=true
```

### `~/.config/khard/khard.conf`

```ini
[general]
default_action = list
editor = vim
merge_editor = vimdiff

[addressbooks]
[[icloud]]
path = ~/.contacts/icloud/card/

[contacttable]
display = first_name

[search]
include_source_files = no
```

### `~/.local/bin/mail-sync-notify.sh`

```bash
#!/bin/bash

LOGFILE="$HOME/.local/var/mail-notify.log"
MAILDIR="$HOME/.mail/icloud/INBOX/cur"
NOTMUCH_DB="$HOME/.mail/icloud"

mkdir -p "$(dirname "$LOGFILE")"

echo "[$(date)] Running mbsync -a" >> "$LOGFILE"
mbsync -a >> "$LOGFILE" 2>&1

echo "[$(date)] Running notmuch new" >> "$LOGFILE"
notmuch new >> "$LOGFILE" 2>&1

# grab last 5 newest messages
echo "[$(date)] Adding messages to notmuch (pokud nejsou indexované)" >> "$LOGFILE"

for file in $(ls -t "$MAILDIR" | head -5); do
  fullpath="$MAILDIR/$file"
  if ! notmuch search --output=files "filename:$fullpath" | grep -q "$file"; then
    echo "[$(date)] Adding $file to notmuch manually" >> "$LOGFILE"
    notmuch insert --folder=INBOX --create-folder --keep < "$fullpath"
  else
    echo "[$(date)] $file it is indexed" >> "$LOGFILE"
  fi
done

notmuch new >> "$LOGFILE" 2>&1

NEW=$(notmuch count tag:unread and folder:INBOX)
echo "[$(date)] Nalezeno $NEW new messages" >> "$LOGFILE"

if [ "$NEW" -gt 0 ]; then
  if command -v terminal-notifier &> /dev/null; then
    terminal-notifier -title "neomutt" -message "You have $NEW new mail" -sound default
  else
    osascript -e "display notification \"You have $NEW new mails\" with title \"neomutt\" sound name \"Ping\""
  fi
  echo "[$(date)] notified" >> "$LOGFILE"
else
  echo "[$(date)] No new messages – no notification" >> "$LOGFILE"
fi
```

### `~/.config/vdirsyncer/config`

```ini
[pair icloud_contacts]
a = icloud_local
b = icloud_remote
collections = ["from a", "from b"]
sync = two-way

[storage icloud_local]
type = filesystem
path = ~/.contacts/icloud/
fileext = .vcf

[storage icloud_remote]
type = caldav
url = https://contacts.icloud.com/
username = your_email@icloud.com
password.fetch = ["command", "pass", "your_pass_db/apple-icloud-generated-app-specific-passwords-for-neomutt"]
```

## Coming up

- Launchd job for periodic sync & notify
- Multi-account (Gmail, Proton, etc.)
- PGP signing/encryption via `gpgme`
- Tagging rules for `notmuch`
- Optional: switch from `khard` to `abook` for unicode-tolerant autocomplete


