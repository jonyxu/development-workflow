# Deployment Guide: {{PROJECT_NAME}}

This guide explains how to deploy the application to production using Cloudflare Tunnel.

## Prerequisites
- [ ] Server with Node.js 18+
- [ ] `cloudflared` installed
- [ ] Domain added to Cloudflare

## Steps

### 1. Local Build & Test
```bash
cd /path/to/project
npm ci --only=production
npm test
npm start  # verify runs
```

### 2. Install cloudflared (if missing)
```bash
# Ubuntu/Debian
sudo apt install cloudflared

# Or download from https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/installation
```

### 3. Create Cloudflare Tunnel (once)
```bash
cloudflared tunnel login
cloudflared tunnel create {{PROJECT_NAME}}
```
Save the tunnel credentials file (`~/.cloudflared/<UUID>.json`).

### 4. Configure Tunnel
Create `config/tunnel-config.yml`:
```yaml
tunnel: <TUNNEL_UUID>
credentials-file: /root/.cloudflared/<UUID>.json

ingress:
  - hostname: todo.yourdomain.com
    service: http://localhost:3000
  - service: http_status:404
```

### 5. Create Systemd Service (optional)
```bash
sudo cp config/cloudflared-todo.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable cloudflared-todo
sudo systemctl start cloudflared-todo
```

Or use the quick start script:
```bash
./scripts/start-tunnel.sh <TUNNEL_UUID> <HOSTNAME>
```

### 6. Configure DNS
In Cloudflare dashboard, add a CNAME record:
- Name: `todo` (or your subdomain)
- Target: `<TUNNEL_UUID>.cfargotunnel.com`
- Proxy status: Proxied (orange cloud)

### 7. Verify
Visit `https://todo.yourdomain.com`. Should show the application.

### 8. Health Check
The app exposes `/health`? (if implemented) or you can test CRUD operations.

---

## Troubleshooting

| Issue | Likely Cause | Fix |
|-------|--------------|-----|
| 502 Bad Gateway | App not running on port 3000 | Start the Node server |
| Tunnel disconnects | Credentials file missing | Check path and permissions |
| DNS not routing | CNAME not created or not proxied | Create/verify in Cloudflare |
| ... | ... | ... |

---

## Maintenance

- To update: pull new code, restart Node server (`systemctl restart todo-app` if managed)
- To rotate credentials: `cloudflared tunnel delete <UUID>` and recreate
- Logs: `journalctl -u cloudflared-todo -f` and app logs

## Security Notes
- Tunnel authenticates outbound only; no inbound ports open.
- Credentials file should be readable only by cloudflared process (0600).
- Consider running tunnel and app under a dedicated non-root user.

## Support
See project README for application-specific help.
