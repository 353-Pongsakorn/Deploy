# Nginx Setup & Configuration Guide

## 🛠 Configuration Structure

- `nginx/nginx.conf`: Global Nginx settings (workers, logs, gzip).
- `nginx/conf.d/app.conf`: Main application routing.
- `nginx/conf.d/ssl.conf.template`: Template for HTTPS.
- `nginx/ssl/`: Directory for certificates.

## 🔒 SSL/TLS Setup

To enable HTTPS:

1. Obtain your SSL certificates (`cert.pem` and `key.pem`).
2. Place them in the `nginx/ssl/` directory.
3. Rename `nginx/conf.d/ssl.conf.template` to `nginx/conf.d/ssl.conf`.
4. Uncomment the configuration in the new `ssl.conf`.
5. Run `deploy-prod.bat`.

## 🚀 Performance Optimizations

### Gzip Compression
Gzip is enabled for common text-based formats (HTML, JS, CSS, JSON, SVG). This typically reduces transfer size by 60-80%.

### Caching
Static assets (JS, CSS, Images) are cached for 1 year in the browser using the `Expires` header.

## 🛡 Security

The configuration includes:
- **X-Frame-Options**: Prevents clickjacking.
- **X-XSS-Protection**: Blocks cross-site scripting attacks.
- **X-Content-Type-Options**: Prevents MIME sniffing.
- **Referrer-Policy**: Controls how much referrer information is sent.
- **Max Upload Size**: Limited to 10MB to prevent DOS.

## 🔍 Troubleshooting

- **Check Config**: `docker-compose exec nginx nginx -t`
- **Reload Config**: `docker-compose exec nginx nginx -s reload`
- **View Logs**: `docker-compose logs -f nginx`
