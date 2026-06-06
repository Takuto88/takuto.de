# WireGuard Server Setup Plan (Debian 12)
## Objective
Deploy a WireGuard server on a Hetzner VM to establish a site-to-site tunnel to the home network (`192.168.179.0/24`). Route only home-bound traffic and DNS. Tunnel subnet: `10.8.0.0/24`. Secrets injected via GitLab CI. No firewall rules required.

## 1. Package & Kernel Preparation
```bash
apt update && apt install -y wireguard
modprobe wireguard
```
Verify kernel module loaded: `lsmod | grep wireguard`

## 2. Key Management & Secret Injection
- Generate server keypair: `wg genkey | tee /tmp/wg_server_privkey | wg pubkey > /tmp/wg_server_pubkey`
- Obtain home router peer public key
- Inject secrets via GitLab CI into Ansible Vault:
  - `wg_server_privkey`
  - `wg_home_peer_pubkey`
- Deploy private key to VM: `/etc/wireguard/wg0.key` (mode `600`)

## 3. WireGuard Configuration (`/etc/wireguard/wg0.conf`)
```ini
[Interface]
Address = 10.8.0.1/24
PrivateKey = {{ wg_server_privkey }}
ListenPort = 51820

[Peer]
PublicKey = {{ wg_home_peer_pubkey }}
AllowedIPs = 192.168.179.0/24
DNS = 192.168.179.1
PersistentKeepalive = 25
```
*Note:* `AllowedIPs` restricts routing to home subnet only. `DNS` forces home DNS resolution for connected peers.

## 4. System & Routing Configuration
Enable IP forwarding:
```bash
echo 'net.ipv4.ip_forward = 1' > /etc/sysctl.d/99-wireguard.conf
sysctl -p /etc/sysctl.d/99-wireguard.conf
```
No `iptables`/`nftables` rules needed per requirements.

## 5. Service Management
```bash
systemctl enable --now wg-quick@wg0
```
Verify: `wg show` (should list peer, handshake count, and traffic stats)

## 6. Ansible Integration Points
- **Tasks:**
  1. `apt` module for `wireguard`
  2. `template` for `/etc/wireguard/wg0.conf` (use vault vars)
  3. `copy` for `/etc/sysctl.d/99-wireguard.conf`
  4. `sysctl` module to apply forwarding
  5. `systemd` module to enable/start `wg-quick@wg0`
- **Variables:** `wg_server_privkey`, `wg_home_peer_pubkey`, `wg_subnet = 10.8.0.0/24`, `home_dns = 192.168.179.1`
- **GitLab CI:** Inject vault secrets as protected/masked variables before Ansible run.

## 7. Validation
- `wg-quick up wg0` → `ip addr show wg0`
- `sysctl net.ipv4.ip_forward` → `1`
- `wg show` → Peer status `UP`, handshake > 0
- Test connectivity: `ping 192.168.179.1` from VM (requires home router to allow ICMP)
