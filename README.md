# Omnivore

[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/omnivore-app/omnivore/run-tests.yaml?branch=main)](https://github.com/omnivore-app/omnivore/actions/workflows/run-tests.yaml)
[![Discord](https://img.shields.io/discord/844965259462311966?label=Join%20our%20Discord)](https://discord.gg/h2z5rppzz9)
[![Mastodon Follow](https://img.shields.io/mastodon/follow/109458738600914558?domain=https%3A%2F%2Fpkm.social)](https://pkm.social/@omnivore)
[![Twitter Follow](https://img.shields.io/twitter/follow/omnivoreapp)](https://twitter.com/OmnivoreApp)
![GitHub](https://img.shields.io/github/license/omnivore-app/omnivore)

<img align="right" src="https://avatars.githubusercontent.com/u/70113176?s=400&u=506b21d9f019f3160963c010ef363667fb24c7c9&v=4" height="150px" alt="Omnivore Logo">

[Omnivore](https://omnivore.app) is a complete, open source read-it-later solution for people who like text.

We built Omnivore because we love reading and we want it to be more social. Join us!

- Highlighting, notes, search, and sharing
- Full keyboard navigation
- Automatically saves your place in long articles
- Add newsletter articles via email (with substack support!)
- PDF support
- [Web app](https://omnivore.app/) written in Node.js and TypeScript
- [Native iOS app](https://omnivore.app/install/ios) ([source](https://github.com/omnivore-app/omnivore/tree/main/apple))
- [Android app](https://omnivore.app/install/android) ([source](https://github.com/omnivore-app/omnivore/tree/main/android/Omnivore))
- Progressive web app for Android users
- Browser extensions for [Chrome](https://omnivore.app/install/chrome), [Safari](https://omnivore.app/install/safari), [Firefox](https://omnivore.app/install/firefox), and [Edge](https://omnivore.app/install/edge)
- Labels (aka tagging)
- Offline support
- Text to speech (iOS only)
- [Logseq](https://logseq.com/) support via our [Logseq Plugin](https://github.com/omnivore-app/logseq-omnivore)
- [Obsidian](https://obsidian.md/) support via our [Obsidian Plugin](https://github.com/omnivore-app/obsidian-omnivore)

Every single part is fully open source! Fork it, extend it, or deploy it to your own server.

A guide for running a self hosted server can be found [here](./self-hosting/GUIDE.md)

<img width="981" alt="web-screenshot-listview" src="https://github.com/omnivore-app/omnivore/assets/75189/df7c797a-4255-42f4-a686-ad94866cb580">

## Join us on Discord! :speech_balloon:

We're building our community on Discord. [Join us!](https://discord.gg/h2z5rppzz9)

Read more about Omnivore on our blog. <https://blog.omnivore.app/p/getting-started-with-omnivore>

## Shoutouts :tada:

Omnivore takes advantage of some great open source software:

- [TypeScript](https://www.typescriptlang.org/) - Most of our backend and frontend are written in TypeScript.
- [Next.js](https://nextjs.org/) - Our frontend is a Next.JS app and is hosted on [Vercel](https://vercel.com/).
- [SWR](https://swr.vercel.app/) - We do all our data fetching on the web using SWR.
- [Stitches](https://stitches.dev/) - We use Stitches on the frontend to style our components.
- [Mozilla Readability](https://github.com/mozilla/readability) - We use Mozilla's Readability library to make pages easier to read.
- [Swift GraphQL](https://www.swift-graphql.com/) - We generate our GraphQL queries on iOS using Swift GraphQL.
- [Apollo GraphQL](https://www.apollographql.com/) - We generate our GraphQL queries on Android using Apollo GraphQL.
- [Radix](https://www.radix-ui.com/) - We use Radix UI's components on our frontend.
- [PDF.js](https://github.com/mozilla/pdf.js) - PDF.js is used to have open source pdf functionality. 
- And many more awesome libraries, just checkout our package files to see what we are using.

## Importing Libraries

Check out our [docs](https://docs.omnivore.app/using/importing.html) for information on importing your data from other apps.

## How to setup local development :computer:

The easiest way to get started with local development is to use `docker compose up`. This will start a postgres container, our web frontend, an API server, and our content fetching microservice.

### Requirements for development

Omnivore is written in TypeScript and JavaScript.

- [Node.js](https://nodejs.org/) (v18.16) and [Yarn](https://classic.yarnpkg.com/lang/en/) -- Versions are managed by [Volta](https://docs.volta.sh/guide/getting-started).
- [Chromium](https://www.chromium.org/chromium-projects/) -- See below for installation info.

### Running the web and API services

#### 1. Start docker compose

```bash
git clone https://github.com/omnivore-app/omnivore
cd omnivore
docker compose up
```

This will start postgres, initialize the database, and start the web and api services.

#### 2. Open the browser

Open <http://localhost:3000> and confirm Omnivore is running

#### 3. Login with the test account

During database setup docker compose creates an account `demo@omnivore.app`, password: `demo_password`.

Go to <http://localhost:3000/> in your browser and choose `Continue with Email` to login.

### Frontend Development

If you want to work on just the frontend of Omnivore you can run the backend services
with docker compose and the frontend locally:

```bash
docker compose up api content-fetch
cd packages/web
cp .env.template .env.local
yarn dev
```

You will need to configure some values in the new `.env.local` file. These are
the values for running the `web` service directly on your host machine and
running `api` and `content-fetch` within docker:

```sh
NEXT_PUBLIC_BASE_URL=http://localhost:3000
NEXT_PUBLIC_HIGHLIGHTS_BASE_URL=http://localhost:3000
NEXT_PUBLIC_LOCAL_BASE_URL=http://localhost:3000
NEXT_PUBLIC_SERVER_BASE_URL=http://localhost:4000
NEXT_PUBLIC_LOCAL_SERVER_BASE_URL=http://localhost:4000
```

### Running the puppeteer-parse service outside of Docker

To save pages you need to run the `puppeteer-parse` service.

#### 1. Install and configure Chromium

```bash
brew install chromium --no-quarantine
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export CHROMIUM_PATH=`which chromium`
```

#### 2. Navigate to the service directory, setup your env file, and install dependencies

```bash
cd packages/puppeteer-parse
cp .env.example .env
yarn
```

#### 3. Start the service

```bash
yarn start
```

This will start the puppeteer-parse service on port 9090.

In your browser go to <http://localhost:3000/home>, click the `Add Link` button,
and enter a URL such as `https://blog.omnivore.app/p/getting-started-with-omnivore`.

You should see a Chromium window open and navigate to your link. When the service
is done fetching your content you will see it in your library.

## How to deploy to your own server

A guide for running a self hosted server can be found [here](./self-hosting/GUIDE.md)

### Quick Start with Docker Compose

For a quick deployment using Docker Compose, follow these steps:

#### 1. Clone the repository and navigate to the docker-compose directory

```bash
git clone https://github.com/omnivore-app/omnivore
cd omnivore/self-hosting/docker-compose
```

#### 2. Create and configure the environment file

```bash
cp env.example .env
```

Edit the `.env` file and update the following configurations:

```bash
# Update your server IP address (replace 192.168.0.157 with your actual IP)
IMAGE_PROXY_URL=http://YOUR_SERVER_IP:7070
CLIENT_URL=http://YOUR_SERVER_IP:3101
LOCAL_MINIO_URL=http://YOUR_SERVER_IP:1011
BASE_URL=http://YOUR_SERVER_IP:3101
SERVER_BASE_URL=http://YOUR_SERVER_IP:4001
HIGHLIGHTS_BASE_URL=http://YOUR_SERVER_IP:3101

# Database configuration (keep these as default for first deployment)
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=omnivore
PG_HOST=postgres
PG_PASSWORD=postgres
PG_DB=omnivore
PG_USER=app_user
PG_PORT=5432
```

#### 3. Start the services

```bash
sudo docker-compose up -d
```

#### 4. Access Omnivore

Open your browser and navigate to `http://YOUR_SERVER_IP:3101`

**Demo Account**: `demo@omnivore.app` / `demo_password`

### Service Ports

| Service | Port | Description |
|---------|------|-------------|
| Web Interface | 3101 | Main web application |
| API Server | 4001 | Backend API service |
| PostgreSQL | 5432 | Database (internal) |
| Redis | 6478 | Cache (internal) |
| MinIO | 1011 | Object storage |
| Image Proxy | 7070 | Image processing service |
| Content Fetch | 9090 | Content fetching service |
| Mail Watch | 4398 | Email processing service |

### Common Issues and Solutions

#### Database Authentication Failed

If you encounter `password authentication failed for user "app_user"`:

1. **Check if the .env file exists**:
   ```bash
   ls -la .env
   ```

2. **Verify database user creation**:
   ```bash
   sudo docker exec omnivore-postgres psql -U postgres -c "\du"
   ```

3. **Manually create the app_user if missing**:
   ```bash
   sudo docker exec omnivore-postgres psql -U postgres -c "CREATE USER app_user WITH PASSWORD 'postgres';"
   sudo docker exec omnivore-postgres psql -U postgres -c "GRANT omnivore_user TO app_user;"
   sudo docker exec omnivore-postgres psql -U postgres -c "GRANT CONNECT ON DATABASE omnivore TO app_user;"
   ```

#### Services Not Starting

1. **Check service status**:
   ```bash
   sudo docker-compose ps
   ```

2. **View service logs**:
   ```bash
   sudo docker logs omnivore-api
   sudo docker logs omnivore-web
   ```

3. **Restart specific services**:
   ```bash
   sudo docker-compose restart api
   sudo docker-compose restart web
   ```

#### Stopping Services

To properly stop all services:

```bash
# Use the correct project name
sudo docker-compose -p docker-compose down

# Or stop with volumes (this will delete data)
sudo docker-compose -p docker-compose down -v
```

#### Network Configuration Issues

If services can't communicate:

1. **Check network connectivity**:
   ```bash
   sudo docker network ls
   sudo docker network inspect docker-compose_default
   ```

2. **Verify container networking**:
   ```bash
   sudo docker exec omnivore-api ping postgres
   sudo docker exec omnivore-api ping redis
   ```

### Advanced Configuration

#### Custom Domain Setup

To use a custom domain instead of IP address:

1. Update the `.env` file with your domain:
   ```bash
   BASE_URL=https://your-domain.com
   SERVER_BASE_URL=https://your-domain.com/api
   ```

2. Configure reverse proxy (nginx/traefik) to forward requests to the appropriate ports.

#### SSL/HTTPS Configuration

For production deployments, consider using:

- **Traefik** as reverse proxy with Let's Encrypt
- **Nginx** with SSL certificates
- **Cloudflare** for SSL termination

#### Backup and Data Persistence

Important data is stored in Docker volumes:

- `docker-compose_pgdata`: PostgreSQL database
- `docker-compose_redis_data`: Redis cache
- `docker-compose_minio_data`: File storage

To backup your data:

```bash
# Backup database
sudo docker exec omnivore-postgres pg_dump -U postgres omnivore > backup.sql

# Backup volumes
sudo docker run --rm -v docker-compose_pgdata:/data -v $(pwd):/backup alpine tar czf /backup/pgdata-backup.tar.gz -C /data .
```

### Monitoring and Maintenance

#### Health Checks

Monitor service health:

```bash
# Check all services
sudo docker-compose ps

# Check specific service health
sudo docker inspect omnivore-api --format='{{.State.Health.Status}}'
```

#### Log Management

View and manage logs:

```bash
# View all logs
sudo docker-compose logs

# Follow specific service logs
sudo docker-compose logs -f api

# View recent logs
sudo docker logs --tail 100 omnivore-api
```

#### Updates

To update to the latest version:

```bash
# Pull latest images
sudo docker-compose pull

# Restart services
sudo docker-compose up -d
```

### Troubleshooting Checklist

- [ ] `.env` file exists and is properly configured
- [ ] Server IP address is correctly set in `.env`
- [ ] Database port is set to `5432` (not `5532`)
- [ ] `app_user` database user exists with correct permissions
- [ ] All required ports are accessible
- [ ] Docker and Docker Compose are properly installed
- [ ] Sufficient disk space and memory available

For more detailed troubleshooting, check the [self-hosting guide](./self-hosting/GUIDE.md) or join our [Discord community](https://discord.gg/h2z5rppzz9).

## License

Omnivore and our extensions to Readability.js are under the AGPL-3.0 license.

---

## Language Versions

- [English](README.md) - English version (current page)
- [中文](README_CN.md) - Chinese version
