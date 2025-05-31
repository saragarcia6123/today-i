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

etc.

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
See extra options in `/help/main.txt`

## Configuration

You can freely customise the default configuration in `defaults.json`