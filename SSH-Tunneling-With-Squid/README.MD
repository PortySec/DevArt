# SSH Tunneling and Squid Proxy Tutorial

## Overview
This tutorial provides a comprehensive guide on setting up SSH tunneling with a Squid proxy to enable internet access for servers without direct internet connectivity.

## Topics Covered
- Setting up a Squid proxy
- Establishing an SSH tunnel
- Configuring the server and host system
- Ensuring secure and efficient internet access

## How to Use This Tutorial
Follow the steps outlined in each section. Code snippets and diagrams are provided for clarity.

## Diagrams
Include your network diagrams here. If they are image files, you can add them like so:
![SSH Tunneling Diagram](./SSH%20Tunneling%20and%20Squid%20Proxy%20Network%20Setup.png)

## Code Examples
```bash
# Example of SSH command for tunneling
ssh -R 3128:localhost:3128 user@host_system
```

## Step-by-Step Guide

### Setting up a Squid Proxy

1. **Install Squid Proxy on Host System**:
   - On the host system (the one with internet access), install Squid Proxy. Use the package manager suitable for your operating system.

2. **Configure Squid Proxy**:
   - Edit Squid's configuration file (usually located at `/etc/squid/squid.conf`) to specify access control rules, allowed networks, and other settings as needed.

3. **Start Squid Service**:
   - Start the Squid service using the following command:
     ```bash
     systemctl start squid
     ```

### Establishing an SSH Tunnel

4. **SSH Tunnel Setup**:
   - On the server without internet access, establish an SSH tunnel to the host system with the following command:
     ```bash
     ssh -R 3128:localhost:3128 user@host_system
     ```
     Replace `3128` with the Squid proxy port if you've configured a different port.

5. **Keep SSH Connection Alive (Optional)**:
   - To ensure the SSH tunnel remains active, consider using tools like `autossh` or configuring SSH options like `ServerAliveInterval`.

### Configuring the Server and Host System

6. **Configure the Internetless Server**:
   - SSH into the internetless server and open a terminal.

7. **Set HTTP Proxy**:
   - To configure the server to use the Squid proxy for HTTP connections, execute the following command:
     ```bash
     export http_proxy=http://localhost:3128
     ```

8. **Set HTTPS Proxy (Optional)**:
   - If you want to route HTTPS traffic through the Squid proxy, execute the following command:
     ```bash
     export https_proxy=http://localhost:3128
    
     ```

9. **Verify Proxy Configuration**:
   - Verify the proxy settings by running:
     ```bash
     echo $http_proxy
     echo $https_proxy
     ```

10. **Test Proxy Configuration**:
    - Test the proxy configuration by accessing a website or making an HTTP request:
      ```bash
      curl http://example.com
      ```

11. **Configure Host System (Optional)**:
    - If needed, configure the host system to allow SSH tunneling and firewall rules to permit traffic on the tunnel port.

### Ensuring Secure and Efficient Internet Access

12. **Access the Internet**:
    - Your internetless server should now have secure internet access through the Squid proxy via the established SSH tunnel.

13. **Monitoring and Troubleshooting**:
    - Regularly monitor the Squid proxy logs and SSH tunnel for any issues. Troubleshoot and adjust configurations as necessary.

By following these steps, you can successfully set up SSH tunneling with a Squid proxy, allowing your server without direct internet connectivity to access the internet securely 