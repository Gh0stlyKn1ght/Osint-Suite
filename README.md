# Osint Suite Installer

![Osint Suite Logo](https://github.com/Gh0stlyKn1ght/Osint-Suite/blob/adff93abdc07b103e2c0c9863964f99e88ce80ca/logo-osint.png?raw=true)

**Version:** 1.0
**Author:** Gh0stlyKn1ght
**Date:** 2025-06-15
**License:** MIT
**Inspired by:** Trace Labs install-tools.sh script

## Overview

The **Osint Suite Installer** is a streamlined, automated Bash script designed for Kali Linux. Its purpose is to install and configure a curated set of Open-Source Intelligence (OSINT) tools for investigators, researchers, and cybersecurity enthusiasts. Inspired by the Trace Labs install-tools.sh framework, this script has been updated with modern tools, compatibility checks, and system validation.

This script ensures:

* System prerequisites are installed.
* Tools are not reinstalled if already present.
* Errors are logged.
* A purple progress interface for visual clarity.

## Tools Installed

The following tools will be installed automatically (unless already present):

| Tool             | Link                                                                                         |
| ---------------- | -------------------------------------------------------------------------------------------- |
| Amass            | [https://github.com/OWASP/Amass](https://github.com/OWASP/Amass)                             |
| ReconFTW         | [https://github.com/six2dez/reconftw](https://github.com/six2dez/reconftw)                   |
| Photon           | [https://github.com/s0md3v/Photon](https://github.com/s0md3v/Photon)                         |
| sn0int           | [https://github.com/kpcyrd/sn0int](https://github.com/kpcyrd/sn0int)                         |
| Social Analyzer  | [https://github.com/qeeqbox/social-analyzer](https://github.com/qeeqbox/social-analyzer)     |
| GHunt            | [https://github.com/mxrch/GHunt](https://github.com/mxrch/GHunt)                             |
| Holehe           | [https://github.com/megadose/holehe](https://github.com/megadose/holehe)                     |
| Blackbird        | [https://github.com/p1ngul1n0/blackbird](https://github.com/p1ngul1n0/blackbird)             |
| Osintgram        | [https://github.com/Datalux/Osintgram](https://github.com/Datalux/Osintgram)                 |
| waybackurls      | [https://github.com/tomnomnom/waybackurls](https://github.com/tomnomnom/waybackurls)         |
| gau (GetAllURLs) | [https://github.com/lc/gau](https://github.com/lc/gau)                                       |
| Shodan CLI       | [https://cli.shodan.io](https://cli.shodan.io)                                               |
| youtube-dl       | [https://github.com/ytdl-org/youtube-dl](https://github.com/ytdl-org/youtube-dl)             |
| PhoneInfoga      | [https://github.com/sundowndev/phoneinfoga](https://github.com/sundowndev/phoneinfoga)       |
| TikTok Scraper   | [https://github.com/drawrowfly/tiktok-scraper](https://github.com/drawrowfly/tiktok-scraper) |

> **Note:** Some tools may require elevated permissions. Ensure the script is run with appropriate rights on Kali Linux.

## Troubleshooting weybackurls


 You're seeing command not found: waybackurls because the binary installed by go install is located in $HOME/go/bin, which likely isn't in your $PATH.
🔧 To fix this:
1. Confirm it's installed

Run:

ls $HOME/go/bin/waybackurls

If it exists, that’s good.
2. Temporarily use it:

You can run it like this directly:
```
$HOME/go/bin/waybackurls
```

3. 🔁 Permanently fix by adding to PATH:

Append this to your shell config:
```shell
echo 'export PATH="$PATH:$HOME/go/bin"' >> ~/.bashrc
source ~/.bashrc
```
If you're using Zsh:

```shell
echo 'export PATH="$PATH:$HOME/go/bin"' >> ~/.zshrc
source ~/.zshrc
```
Once done, try:

```shell
waybackurls testphp.vulnweb.com`
```

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT). You are free to use, modify, and distribute it with attribution.

## Disclaimer

Use this script responsibly. The author is not liable for any misuse of the installed tools.

---

Happy hunting. 🕵️‍♂️
