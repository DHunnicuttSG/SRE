### ✅ **1. Connect to your EC2 instance**

From your local machine:

```bash
ssh -i /path/to/your-key.pem ec2-user@<EC2_PUBLIC_IP>
```

Replace:

*   `/path/to/your-key.pem` with your private key file
*   `<EC2_PUBLIC_IP>` with your instance’s public IP address

***

### ✅ **2. Upload the file using `scp`**

On your local machine, run:

```bash
scp -i /path/to/your-key.pem grep_practice.zip ec2-user@<EC2_PUBLIC_IP>:/home/ec2-user/
```

This copies `grep_practice.zip` to the EC2 instance’s home directory.

***

### ✅ **3. SSH into the instance and unzip**

Once connected:

```bash
cd /home/ec2-user
unzip grep_practice.zip
```

If `unzip` is not installed:

```bash
sudo yum install unzip -y    # For Amazon Linux
# or
sudo apt-get install unzip -y  # For Ubuntu/Debian
```

***

### ✅ **4. Verify**

```bash
ls grep_practice
```

You should see all the files and directories we created earlier.

***

### ✅ **5. Start practicing**

Navigate into the directory:

```bash
cd grep_practice
```

Run any of the `grep`, `sed`, or `awk` exercises from the worksheets.

***
