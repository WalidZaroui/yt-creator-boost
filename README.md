# YT Creator Boost 🚀

**A Flutter mobile app that helps YouTube creators discover, connect, and grow their channels through niche-based community engagement and gamified subscriptions.**

## 📱 App Overview

YT Creator Boost is a mobile platform where YouTube creators can:
- **Discover channels** in their specific content niches (Islamic, Gaming, Tech, etc.)
- **Earn points** by subscribing to other creators' channels  
- **Compete weekly** in category-specific leaderboards
- **Build genuine subscriber base** through mutual support
- **Connect with like-minded creators** in their content area

## 🎯 Key Features

### 🔍 **Niche-Based Discovery**
- Filter creators by content type (Islamic, Gaming, Education, Tech, etc.)
- Category-specific leaderboards (Islamic creators compete with Islamic creators)
- Smart recommendations based on user interests
- Search and advanced filtering options

### 🏆 **Weekly Competition System**
- **Weekly leaderboards** that reset every Monday
- **Global Hall of Fame** showcasing top 10 all-time legends
- **Fair competition** - everyone starts fresh each week
- Points earned through verified YouTube subscriptions

### 🎮 **Gamification & Points**
- **+100 points** for subscribing to a channel (verified via YouTube API)
- **+50 points** to channel owner when they gain a subscriber
- **+20 points** for daily login
- **+300 points** for weekly challenges
- Badges, achievements, and profile levels

### 🔐 **YouTube Integration**
- **OAuth authentication** with YouTube
- **Subscription verification** through YouTube API
- **Real subscriber growth** - no bots or fake engagement
- **Policy compliant** with YouTube's terms of service

### 💰 **Monetization Strategy**
- **Google AdMob integration** with rewarded video ads
- **Bonus points for watching ads** (+50 points per ad)
- **Free tier** supported by ad revenue
- **Premium features** unlocked with points

## 🏗️ Technical Architecture

### **Frontend: Flutter**
- **Cross-platform** mobile app (iOS & Android)
- **Material Design** with custom UI components
- **State management** using cubits (Bloc pattern)
- **Responsive design** for all screen sizes

### **Backend: Firebase**
- **Authentication:** Firebase Auth + Google Sign-In
- **Database:** Cloud Firestore (real-time updates)
- **Storage:** Firebase Storage (profile pics, thumbnails)
- **Functions:** Cloud Functions (YouTube API calls, point calculations)
- **Analytics:** Firebase Analytics
- **Messaging:** Firebase Cloud Messaging (notifications)

### **Third-Party Integrations**
- **YouTube Data API v3** - Channel verification and subscription checking
- **Google AdMob** - Rewarded video ads and banner ads
- **Google Sign-In** - OAuth authentication flow

## 📊 Database Schema

### Users Collection
```javascript
/users/{userId} {
  username: "@IslamicGamer",
  email: "user@example.com", 
  points: 1250,
  weeklyPoints: 234,
  contentInterests: ["islamic", "gaming"],
  youtubeChannelId: "UC_abc123",
  youtubeChannelUrl: "https://youtube.com/c/IslamicGaming",
  channelContentTypes: ["islamic", "gaming"],
  subscriberCount: 1500,
  profilePicUrl: "https://...",
  createdAt: timestamp,
  lastActive: timestamp,
  verified: true
}
```

### Weekly Leaderboard Collection
```javascript
/weeklyLeaderboard2025W36/{userId} {
  username: "@NewUser",
  weeklyPoints: 456,
  contentTypes: ["islamic", "gaming"],
  rank: 1,
  subscriptionsThisWeek: 4
}
```

### Subscriptions Collection
```javascript
/subscriptions/{subscriptionId} {
  subscriberId: "user456",
  subscribedToChannelId: "UC_abc123", 
  subscribedToUserId: "user123",
  subscribedAt: timestamp,
  pointsAwarded: 100,
  verified: true
}
```

### Global Top 10 Collection
```javascript
/globalTop10/{userId} {
  username: "@LegendaryCreator",
  totalPoints: 15847,
  weeksWon: 12,
  contentTypes: ["islamic", "gaming"],
  lastActive: timestamp
}
```

## 📱 App Modules

### 🔐 **Authentication Module**
- Email/password registration
- Google Sign-In integration
- YouTube OAuth flow
- Profile setup and verification

### 🏠 **Dashboard Module**
- Weekly leaderboard display
- Daily challenges
- Quick stats and notifications
- Category selection

### 🔍 **Discovery Module**
- Browse channels by category
- Search and filter functionality
- Channel detail pages
- Subscription action with verification

### 🏆 **Leaderboard Module**
- Weekly category leaderboards
- Global Hall of Fame (top 10)
- User ranking and stats
- Competition timers

### 👤 **Profile Module**
- User profile management
- YouTube channel linking
- Statistics and achievements
- Settings and preferences

### 📊 **Analytics Module**
- Personal growth tracking
- Subscription history
- Points breakdown
- Weekly/monthly reports

### 💰 **Monetization Module**
- AdMob rewarded video ads
- Banner ad integration
- Premium feature unlocks
- Point purchase options

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK** (3.0+)
- **Firebase Project** setup
- **YouTube Data API** key
- **AdMob Account** for ads

### Installation
```bash
# Clone the repository
git clone https://github.com/WalidZaroui/yt-creator-boost.git

# Navigate to project directory
cd yt-creator-boost

# Install dependencies
flutter pub get

# Configure Firebase
flutterfire configure

# Run the app
flutter run
```

### Environment Setup
1. **Create Firebase project** and add your app
2. **Enable Authentication** (Google Sign-In)
3. **Set up Firestore** with security rules
4. **Configure YouTube Data API v3**
5. **Set up AdMob** and add your app
6. **Add environment variables** in `.env` file

## 📈 Business Model

### **Revenue Streams**
- **AdMob ads** - Primary revenue source
- **Premium subscriptions** - Advanced features
- **Sponsored challenges** - Brand partnerships
- **YouTube channel promotions** - Featured listings

### **Target Market**
- **YouTube creators** with 100-50K subscribers
- **Niche content creators** (Islamic, Gaming, Education, etc.)
- **Creators seeking organic growth**
- **Community-focused content makers**

### **Growth Strategy**
- **Start with Islamic content creators** (underserved niche)
- **Expand to gaming community**
- **Add more categories based on demand**
- **Influencer partnerships** and referral programs

## 🔮 Future Features

### **Phase 2 Features**
- **Collaboration matching** - Connect creators for collabs
- **Analytics dashboard** - Detailed growth insights
- **Community forums** - Discussion boards by category
- **Live events** - Virtual meetups and challenges

### **Phase 3 Features**
- **Monetization tools** - Revenue sharing insights
- **Brand partnership platform** - Connect with sponsors
- **Educational content** - Creator growth courses
- **International expansion** - Multi-language support

## 🤝 Contributing

We welcome contributions! Please read our [Contributing Guidelines](CONTRIBUTING.md) before submitting PRs.

### **Development Guidelines**
- Follow Flutter best practices
- Write unit tests for new features  
- Update documentation for API changes
- Follow our code style guidelines

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Contact

- **Developer:** [Your Name]
- **Email:** your.email@example.com
- **Project Link:** https://github.com/yourusername/yt-creator-boost

## 🙏 Acknowledgments

- **Flutter Team** - Amazing cross-platform framework
- **Firebase** - Reliable backend infrastructure  
- **YouTube API** - Essential integration
- **AdMob** - Monetization platform
- **Open Source Community** - Inspiration and packages

---

**Ready to boost your YouTube growth? 🚀 Download YT Creator Boost and join the creator community!**