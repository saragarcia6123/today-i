# Today I...

- Launched my SaaS' MVP

- Fixed an issue where cart wasn't updating correctly

- Merged login feature branch into main

### Your personal coding diary. Tracked.

## Pre-requisites

### [JQ](https://jqlang.org/)
(for parsing `defaults.json`)

```sh
# Ubuntu/Debian
sudo apt install jq
```

*Tip: The name is `jq` on all systems.*

### [Cron](https://en.wikipedia.org/wiki/Cron)
(for triggering daily push)

```sh
# Ubuntu/Debian
sudo apt install cron

sudo systemctl start cron
sudo systemctl status cron
```

Tip: Arch, Fedora, Red Hat & CentOS use `cronie`

## Installation

```sh
git clone https://github.com/saragarcia/today-i.git "$HOME/today-i"
echo 'export PATH="$HOME/today-i:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## Usage

```sh
today-i did -m "Launched my SaaS MVP"
```

The script will auto-add the cron job for you.

See extra options in `/help/main.txt`

## Configuration

You can freely customise the default configuration in `defaults.json`

- config:
  - `path`: The location to save logs to
- did:
  - `commit` (true/false): Whether to trigger commit on log
  - `push` (true/false): Whether to trigger push on log
- history:
  - `window` (int): The oldest time to filter logs by
  - `units` (d=days, h=hours): Units for window
- cron:
  - `schedule`: The cron schedule (See [Crontab Guru](https://crontab.guru/))