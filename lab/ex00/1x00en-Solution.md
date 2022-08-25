<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD041 -->
### Solution {.unlisted .unnumbered}

The following steps are performed in this exercise:

- Login to your individual OCI compute instance eg. *osec-bastionXX*. e.g. via
  SSH/Putty or Login via Apache Guacamole Remote Desktop Server.
- Check what Databases are available on the Database Server.
- Check check the Tools on the Windows Server/Workstation.

### Detailed Solution {.unlisted .unnumbered}

The following steps have been performed on the *osec-bastion00* host. If necessary,
adjust the commands, filenames or the host name according to your environment.

- Start a Putty session from command line.

```bash
putty -ssh opc@osec-bastion00.trivadislabs.com -i keys/id_rsa_o-sec.ppk
```

- Alternatively start a SSH session from command line

```bash
ssh opc@osec-bastion00.trivadislabs.com -i id_rsa_o-sec
```

- Login as user *oracle* to the database server

```bash
ssh oracle@db19
ssh oracle@db21
```

Login to the Apache Guacamole Remote Desktop Server using your favorite browser.

- Open the URL <http://osec-bastionXX.trivadislabs.com/guacamole>
- Login as user *guacadmin* with the password provided by the trainer.
- Try to access the Linux Server as well the Windows Server / Workstation
- Try the different Tools on the Windows Server / Workstation
