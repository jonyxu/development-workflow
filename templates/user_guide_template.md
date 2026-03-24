# User Guide: {{PROJECT_NAME}}

Welcome to {{PROJECT_NAME}}! This guide helps you get started quickly.

## Features
- ✅ Feature 1
- ✅ Feature 2
- ✅ Feature 3

## Quick Start

### Local Development
```bash
git clone <repo>
cd {{PROJECT_NAME}}
npm install
npm start
```
Open http://localhost:3000

### Remote Access (Cloudflare Tunnel)
Your admin should provide a public URL like:
```
https://todo.yourdomain.com
```
No VPN required; works anywhere.

## Using the Application

### 1. Getting Around
- **Dashboard**: main landing page
- **Settings**: configure preferences
- **Help**: this documentation

### 2. Common Tasks
- **Create item**: click "+" button, fill form, save
- **Edit**: click item, modify, save
- **Delete**: click trash icon, confirm

### 3. Keyboard Shortcuts
| Shortcut | Action |
|----------|--------|
| Ctrl+N | New item |
| Ctrl+S | Save |
| ... | ... |

## Troubleshooting

### Can't access the site?
- Check your internet connection
- Verify the URL with your admin
- If using corporate network, Cloudflare Tunnel may be blocked; try mobile hotspot

### Data not saving?
- Ensure browser cookies/local storage enabled
- Check server logs if self-hosting

### Performance issues?
- Clear browser cache
- Reduce number of items on screen (use pagination if available)

## FAQ
**Q: Is my data private?**  
A: Yes, data stays on the server; Cloudflare only proxies encrypted traffic.

**Q: Can I use my phone?**  
A: Absolutely! The UI is fully responsive.

**Q: How do I backup my data?**  
A: If self-hosting, copy the database file (`data/todos.db`). If using hosted service, contact admin.

## Support
- Open an issue in the project repository
- Email: support@example.com
- Discord: [link]

Thank you for using {{PROJECT_NAME}}! 🚀
