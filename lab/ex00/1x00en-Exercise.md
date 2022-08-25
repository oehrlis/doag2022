<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD041 -->

# Introduction to the LAB environment

## Environments {.unlisted .unnumbered}

If not explicitly stated, the exercises are usually performed on the following
environment:

- **Database Server:** db19.trivadislabs.com / 10.0.1.19
- **Database Instance:** TSEC02

Alternatively, the exercise can also be performed on another system e.g.
container database *TSEC01* or 21c container databases *TSEC03* and *TSEC04*. In
this case, the solutions must be adjusted accordingly.

## Exercise 00 - Get known the Environment

### Exercise Goals {.unlisted .unnumbered}

Simple exercise to get to know the environment.

- You can access your compute instances.

### Tasks {.unlisted .unnumbered}

- Login to your individual OCI compute instance eg. *osec-bastionXX*. e.g. via
  SSH/Putty or Login via Apache Guacamole Remote Desktop Server.
- Check what Databases are available on the Database Server.
- Check the lab and exercises in `$ORACLE_BASE/local/osec/lab` by using alias `lab`
- Check check the Tools on the Windows Server/Workstation.
