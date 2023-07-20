# Installation
Requires `bash >= 4.0` which pretty much comes standard on all modern Unix-based systems. Also requires `python3` for the `shyaml` module.

### Ubuntu/Debian
```bash
$ sudo apt install python3-pip
$ python3 -m pip install shyaml
```

### Red Hat
```bash
$ sudo dnf install python3-pip
$ python3 -m pip install shyaml
```

### Arch Linux
```bash
$ sudo pacman -S python-pipx
$ pipx install shyaml
```

# Usage (Part 1: Demo)
1. Clone a copy of this repository.
   ```bash
   $ git clone https://github.com/johnhuynh0/nebula-gen.git`
   ```
2. Change your current working directory and run the script.
   ```bash
   $ cd nebula-gen
   $ ./build.sh "Dunder Mifflin, Inc."
   ```
3. Observe the metadata that got embedded in the certificates. As an example:
   ```bash
   $ nebula-cert print -path desktop/desktop.crt

   NebulaCertificate {
	   Details {
		   Name: desktop
		   Ips: [
			   172.16.1.2/16
		   ]
		   Subnets: []
		   Groups: [
			   "kdeconnect"
			   "admin"
		   ]
		   Not before: 2023-07-18 05:44:25 -0400 EDT
		   Not After: 2024-07-17 05:44:24 -0400 EDT
		   Is CA: false
		   Issuer: 8540cd7d01a2f6530dba5c8e645970d77dcb885d5cf1633ca37d4bc17c8bb9dd
		   Public key: c62703350a64e86fb6824f0cbeddf7be3cc85c9cca80faccc56b278f163b8306
	   }
	   Fingerprint: 162c38cf4d84b9ff61c4007267f989e23a141b695b93644ffada165b56e66fdc
	   Signature: 529fb737ba29636119f4ff40c4ca186cbf8cc9916d0981a39d2bd9ae27a2f783f6882ac5965b27cdc1d058e45d3b852970105fd9516663679aac7eb855d1dc00
   }
   ```

# Usage (Part 2: Customizing it for your use)
1. Delete all of the output that was generated from part 1.
   ```
   $ ./clean.sh
   ```
2. Edit the `build.yml` file to fit your requirements.
3. Run the script
   ```
   ./build.sh
   ```
4. If you didn't see any error messages, then it worked!

5. Now you have to distribute the contents of the directories to each host somehow. An automation tool such as Ansible or an appropriate utility such as `scp` would be appropriate here.

6. Don't forget to write the `config.yml` file for each host. Read the [official docs](https://nebula.defined.net/docs/) for more information.
