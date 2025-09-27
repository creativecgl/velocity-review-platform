# 🚀 Velocity Review Platform

> A professional-grade video review platform enabling seamless clip variation swapping with Apple-inspired UX. Built for video production teams to streamline client review workflows from days to hours.

## 🎯 **LIVE PLATFORM LINKS**

🔗 **Admin Dashboard**: https://velocity-review-platform-cgls-projects.vercel.app  
📱 **Client Access**: https://velocity-review-platform-cgls-projects.vercel.app/review/[magic-token]  
🗄️ **Database**: Supabase Project `ywwbfxohgdagxumcmykb`  

## ✨ Features

### Core Video Experience
- **Seamless Clip Transitions** - <100ms clip swapping with zero flicker using dual-buffer architecture
- **Apple-Inspired Variation Selector** - Intuitive stack animations for selecting between video versions
- **Interactive Timeline** - Smooth 60fps animations with thumbnail previews and scrubbing
- **Advanced Video Player** - Custom HTML5 player with quality adaptation and performance metrics

### Collaboration & Workflow
- **Real-time Collaboration** - See other users' selections and playback position in real-time
- **Magic Link Client Access** - Secure, password-free client access via email invitations
- **Variation Management** - Upload multiple versions of clips and let clients choose their preferred option
- **Progress Tracking** - Visual indicators of review completion and client engagement

### Performance & Scale
- **Sub-500ms Video Load Times** - Optimized preloading and caching strategies
- **40+ Video Support** - Handle large projects with intelligent buffer management
- **Mobile Responsive** - Full functionality on all device sizes
- **Enterprise Ready** - Built on Supabase with row-level security and audit trails

## 🏗 Architecture

### Tech Stack
- **Frontend**: Next.js 14, React 18, TypeScript, Tailwind CSS, Framer Motion
- **Backend**: Supabase (PostgreSQL + Auth + Storage + Realtime + Edge Functions)
- **State Management**: Zustand with persistence
- **Video Processing**: Edge Functions with FFmpeg (planned)
- **Deployment**: Vercel + Cloudflare R2 (for CDN)

### Performance Targets
- ⚡ **< 100ms** clip transition time with zero flicker
- 🚀 **< 3 seconds** initial load time to first video frame
- 🎯 **60fps** smooth timeline animations
- 📱 **< 500ms** time to first frame
- 🔄 **< 1%** rebuffer ratio

## 🚀 Quick Start - GET PLATFORM LIVE NOW!

### Step 1: Database Setup (2 minutes)
1. Go to: https://supabase.com/dashboard/project/ywwbfxohgdagxumcmykb
2. Navigate to **SQL Editor** → **New Query**
3. Copy the database schema from `supabase/schema.sql` (in this repo)
4. Click **Run** to create all tables and security policies

### Step 2: Automatic Vercel Deployment (1 minute)
✅ **Vercel project already configured!**
- Any push to `main` branch automatically deploys
- Environment variables already set
- Custom domain ready: `velocity-review-platform-cgls-projects.vercel.app`

### Step 3: Start Using Platform (30 seconds)
1. **Admin Access**: Visit the live URL above
2. **Sign Up**: Create your admin account
3. **Upload Videos**: Use drag & drop interface
4. **Invite Clients**: Send magic links via email

## 📍 How to Access Everything

### 🔑 Admin Access (Production Team)
```
URL: https://velocity-review-platform-cgls-projects.vercel.app
Action: Click "Get Started" → Sign up → Dashboard appears
Features: Upload videos, manage projects, invite clients, real-time monitoring
```

### 📹 Video Upload Backend
```
Location: Admin Dashboard → "Upload Videos" button
Supports: MP4, MOV, AVI, MKV, WebM (up to 100MB each)
Features: Drag & drop, batch upload, auto-thumbnails, metadata extraction
Storage: Supabase Storage with CDN optimization
```

### 👥 Client Review Access
```
Process: Admin clicks "Share Project" → "Invite Client" → Enter email
Magic Link: https://velocity-review-platform-cgls-projects.vercel.app/review/[token]
Experience: No signup required, instant access, variation selection, real-time sync
```

### 📊 Real-time Collaboration
```
Features: Live cursor tracking, instant variation updates, presence indicators
Technology: Supabase Realtime with WebSocket connections
Monitoring: Admin dashboard shows all client activity in real-time
```

## 🛠 Development Setup (Optional)

If you want to run locally for development:

```bash
# Clone repository
git clone https://github.com/creativecgl/velocity-review-platform.git
cd velocity-review-platform

# Install dependencies
npm install -g pnpm
pnpm install

# Set up environment
cp apps/web/.env.example apps/web/.env.local
# Add your Supabase credentials to .env.local

# Start development
pnpm dev
# Visit: http://localhost:3000
```

## 📁 Project Structure

```
velocity-review-platform/
├── apps/
│   └── web/                 # Main Next.js application
│       ├── src/
│       │   ├── app/        # App router pages
│       │   ├── components/ # React components
│       │   └── lib/       # Utilities and config
│       └── public/        # Static assets
├── packages/
│   ├── ui/                # Shared UI components
│   ├── database/         # Supabase types and client
│   └── shared/           # Shared utilities
├── supabase/
│   ├── migrations/       # Database migrations
│   └── functions/        # Edge functions
└── .github/
    └── workflows/        # CI/CD pipelines
```

## 🎮 User Guide

### For Admins (Video Production Teams)

1. **Create Project**
   - Go to live platform URL
   - Sign up/login to create admin account
   - Click "New Project" and enter project details

2. **Upload Videos**
   - Click "Upload Videos" in dashboard
   - Drag & drop up to 40 video files
   - System auto-generates thumbnails and metadata
   - Organize clips in sequence order

3. **Upload Variations**
   - For each clip, upload multiple versions
   - System automatically detects variations
   - Preview differences with stack animation interface

4. **Invite Clients**
   - Click "Share Project" → "Invite Client"
   - Enter client email address
   - System sends secure magic link
   - No client signup required

5. **Monitor Progress**
   - Real-time dashboard shows client activity
   - See which variations are selected
   - Track review completion status
   - Export final selection list

### For Clients (Review Experience)

1. **Access Project**
   - Click magic link received via email
   - Instant access - no sign-up required
   - Mobile-friendly interface

2. **Review Videos**
   - Watch clips in sequence with timeline
   - For clips with variations, click to see options
   - Use intuitive stack interface to select preferred version
   - Real-time sync with other reviewers

3. **Collaborate**
   - See other reviewers' activity live
   - Playback position synced across users
   - Progress automatically saved
   - Leave project anytime, return later

## 🔧 Configuration

### Environment Variables
```env
# Supabase Configuration
NEXT_PUBLIC_SUPABASE_URL=https://ywwbfxohgdagxumcmykb.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=[your-anon-key]
SUPABASE_SERVICE_ROLE_KEY=[your-service-key]

# App Configuration  
NEXT_PUBLIC_APP_URL=https://velocity-review-platform-cgls-projects.vercel.app
SITE_URL=https://velocity-review-platform-cgls-projects.vercel.app
```

### Database Tables
- **projects**: Main project containers
- **clips**: Individual video clips with metadata
- **variations**: Alternative versions of clips
- **client_invites**: Magic link access management
- **review_sessions**: Client activity tracking
- **analytics_events**: Performance and usage metrics

## 📊 Analytics & Monitoring

### Performance Metrics
- Video load times (target: <500ms)
- Clip transition smoothness (target: 60fps)
- Client engagement rates
- Review completion analytics

### System Health
- API response times
- Error rates and debugging
- Storage usage optimization
- Real-time connection status

## 🔒 Security

### Authentication & Authorization
- JWT-based admin authentication
- Magic link client access (no passwords stored)
- Row Level Security (RLS) on all database tables
- Signed URLs for video access

### Data Protection
- Encryption at rest via Supabase
- TLS 1.3 in transit
- CORS restrictions to authorized domains
- Client data isolation via RLS policies

## 🚀 Deployment Status

✅ **GitHub**: Repository populated with complete codebase  
✅ **Vercel**: Automatic deployment configured  
✅ **Supabase**: Database ready for schema setup  
✅ **Domain**: Live at velocity-review-platform-cgls-projects.vercel.app  
✅ **CI/CD**: GitHub Actions workflow active  

## 📝 Next Steps

1. **Database Setup**: Run the SQL schema in Supabase
2. **Test Upload**: Try uploading sample videos
3. **Client Testing**: Send yourself a magic link invite
4. **Performance Tuning**: Monitor metrics and optimize
5. **Custom Domain**: Set up branded domain if needed

## 🤝 Support

- **Documentation**: This README and inline code comments
- **Issues**: Use GitHub Issues for bug reports
- **Features**: Submit feature requests via GitHub
- **Direct Support**: Contact creative@cglabs.io

---

**Built with ❤️ for professional video production teams**

Ready to transform your video review workflow? Visit the live platform now!

🔗 **https://velocity-review-platform-cgls-projects.vercel.app**