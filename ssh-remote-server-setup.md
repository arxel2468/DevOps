# SSH Remote Server Setup Guide

This guide demonstrates how to set up SSH access to a remote Linux server with multiple SSH keys.

## Prerequisites

- A Linux server (this guide uses LinuxZoo.net)
- Basic understanding of terminal/command line
- SSH client (built into Linux/macOS, or use PuTTY/Windows Terminal on Windows)

## Step 1: Generate SSH Key Pairs

Generate two different SSH key pairs on your local machine:

### First Key Pair (RSA)

```bash
mkdir -p ~/.ssh
ssh-keygen -t rsa -b 4096 -f ~/.ssh/linuxzoo_key1 -C "linuxzoo_key1"
```

### Second Key Pair (ED25519)

```bash
ssh-keygen -t ed25519 -f ~/.ssh/linuxzoo_key2 -C "linuxzoo_key2"
```

This will create:
- Private keys: `~/.ssh/linuxzoo_key1` and `~/.ssh/linuxzoo_key2`
- Public keys: `~/.ssh/linuxzoo_key1.pub` and `~/.ssh/linuxzoo_key2.pub`

## Step 2: Connect to LinuxZoo Server

1. Register at [LinuxZoo.net](https://linuxzoo.net)
2. Select a Linux image (e.g., CentOS 7)
3. Join the queue for the selected image
4. Switch on the server (in Control tab)
5. Wait for successful boot
6. Connect using the credentials provided (e.g., username: root, password: secure)

```bash
ssh root@linuxzoo.net
```

## Step 3: Set Up SSH Keys on the Server

### 1. Create SSH Directory and Set Permissions

On the LinuxZoo server:

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

### 2. Add Public Keys to Authorized Keys

On your local machine, display your public keys:

```bash
cat ~/.ssh/linuxzoo_key1.pub
cat ~/.ssh/linuxzoo_key2.pub
```

Copy each public key and add it to the `~/.ssh/authorized_keys` file on the LinuxZoo server:

```bash
echo "ssh-rsa AAAA..." >> ~/.ssh/authorized_keys
echo "ssh-ed25519 AAAA..." >> ~/.ssh/authorized_keys
```

### 3. Configure SSH Settings (Optional but Recommended)

Edit `/etc/ssh/sshd_config` on the LinuxZoo server:

```bash
sudo nano /etc/ssh/sshd_config
```

Ensure these settings are set:

```
PasswordAuthentication yes  # Keep this yes for LinuxZoo
PubkeyAuthentication yes
PermitRootLogin yes  # You might want to change this to 'no' in a production environment
```

Restart SSH service:

```bash
sudo systemctl restart sshd
```

## Step 4: Configure SSH Config on Local Machine

Create or edit the SSH config file on your local machine:

```bash
nano ~/.ssh/config
```

Add these entries:

```
Host linuxzoo1
    HostName linuxzoo.net
    User root
    IdentityFile ~/.ssh/linuxzoo_key1
    Port 22

Host linuxzoo2
    HostName linuxzoo.net
    User root
    IdentityFile ~/.ssh/linuxzoo_key2
    Port 22
```

Save and close the file.

## Step 5: Test SSH Connections

### Test First Key:

```bash
ssh -i ~/.ssh/linuxzoo_key1 root@linuxzoo.net
```

Or using the alias:

```bash
ssh linuxzoo1
```

### Test Second Key:

```bash
ssh -i ~/.ssh/linuxzoo_key2 root@linuxzoo.net
```

Or using the alias:

```bash
ssh linuxzoo2
```

## Troubleshooting

1. **Permission Issues**: Ensure proper permissions on SSH files.
   ```bash
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/authorized_keys
   chmod 600 ~/.ssh/linuxzoo_key1
   chmod 600 ~/.ssh/linuxzoo_key2
   ```

2. **Connection Issues**: Debug connections with:
   ```bash
   ssh -v -i ~/.ssh/linuxzoo_key1 root@linuxzoo.net
   ```

3. **Key Format Issues**: Make sure the public keys are properly formatted in authorized_keys.

## Security Considerations (Stretch Goal)

### Install and Configure Fail2Ban

While not possible on LinuxZoo due to resource limitations, here's how to set up Fail2Ban on a production server:

1. Install Fail2Ban:
   ```bash
   sudo apt-get update
   sudo apt-get install fail2ban
   ```

2. Create a configuration file:
   ```bash
   sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
   sudo nano /etc/fail2ban/jail.local
   ```

3. Configure SSH protection:
   ```
   [sshd]
   enabled = true
   port = ssh
   filter = sshd
   logpath = /var/log/auth.log
   maxretry = 3
   bantime = 3600
   ```

4. Restart Fail2Ban:
   ```bash
   sudo systemctl restart fail2ban
   ```

5. Check status:
   ```bash
   sudo fail2ban-client status sshd
   ```

## Conclusion

You have successfully:
1. Generated two different SSH key pairs
2. Configured a Linux server to accept SSH connections
3. Set up both keys for authentication
4. Configured SSH client for convenient connections

This approach provides a more secure authentication method than password-based login and demonstrates how to manage multiple keys for the same server.

## References

- [OpenSSH Documentation](https://www.openssh.com/manual.html)
- [LinuxZoo Documentation](https://linuxzoo.net/page/documentation.html)
- [Fail2Ban Documentation](https://www.fail2ban.org/wiki/index.php/Main_Page) 