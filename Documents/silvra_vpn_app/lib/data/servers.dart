// lib/data/servers.dart
class Server {
  final String name;
  final double lat;
  final double lng;
  final bool isPremium;

  const Server({
    required this.name,
    required this.lat,
    required this.lng,
    required this.isPremium,
  });
}

/// All servers used in app (free + premium).
/// These coordinates are approximate country centroids so markers appear roughly correct.
const List<Server> allServers = [
  // Free servers
  Server(name: 'India', lat: 20.5937, lng: 78.9629, isPremium: false),
  Server(name: 'USA', lat: 37.0902, lng: -95.7129, isPremium: false),
  Server(name: 'Singapore', lat: 1.3521, lng: 103.8198, isPremium: false),
  Server(name: 'Netherlands', lat: 52.1326, lng: 5.2913, isPremium: false),
  Server(name: 'Brazil', lat: -14.2350, lng: -51.9253, isPremium: false),
  Server(name: 'UK', lat: 55.3781, lng: -3.4360, isPremium: false),
  Server(name: 'Canada', lat: 56.1304, lng: -106.3468, isPremium: false),

  // Premium servers (examples)
  Server(name: 'Germany', lat: 51.1657, lng: 10.4515, isPremium: true),
  Server(name: 'France', lat: 46.2276, lng: 2.2137, isPremium: true),
  Server(name: 'Japan', lat: 36.2048, lng: 138.2529, isPremium: true),
  Server(name: 'Australia', lat: -25.2744, lng: 133.7751, isPremium: true),
  Server(name: 'Switzerland', lat: 46.8182, lng: 8.2275, isPremium: true),
  Server(name: 'South Korea', lat: 35.9078, lng: 127.7669, isPremium: true),
  Server(name: 'Sweden', lat: 60.1282, lng: 18.6435, isPremium: true),
  Server(name: 'Italy', lat: 41.8719, lng: 12.5674, isPremium: true),
  Server(name: 'Belgium', lat: 50.5039, lng: 4.4699, isPremium: true),
  Server(name: 'Denmark', lat: 56.2639, lng: 9.5018, isPremium: true),
  Server(name: 'Norway', lat: 60.4720, lng: 8.4689, isPremium: true),
  Server(name: 'Finland', lat: 61.9241, lng: 25.7482, isPremium: true),
  Server(name: 'Poland', lat: 51.9194, lng: 19.1451, isPremium: true),
  Server(name: 'Czech Republic', lat: 49.8175, lng: 15.4730, isPremium: true),
  Server(name: 'Austria', lat: 47.5162, lng: 14.5501, isPremium: true),
  Server(name: 'Ireland', lat: 53.4129, lng: -8.2439, isPremium: true),
  Server(name: 'Portugal', lat: 39.3999, lng: -8.2245, isPremium: true),
  Server(name: 'Greece', lat: 39.0742, lng: 21.8243, isPremium: true),
  Server(name: 'Mexico', lat: 23.6345, lng: -102.5528, isPremium: true),
  Server(name: 'Argentina', lat: -38.4161, lng: -63.6167, isPremium: true),
  Server(name: 'Chile', lat: -35.6751, lng: -71.5430, isPremium: true),
  Server(name: 'Colombia', lat: 4.5709, lng: -74.2973, isPremium: true),
  Server(name: 'South Africa', lat: -30.5595, lng: 22.9375, isPremium: true),
  Server(name: 'New Zealand', lat: -40.9006, lng: 174.8860, isPremium: true),
  Server(name: 'Hong Kong', lat: 22.3193, lng: 114.1694, isPremium: true),
  Server(name: 'Taiwan', lat: 23.6978, lng: 120.9605, isPremium: true),
  Server(name: 'UAE', lat: 23.4241, lng: 53.8478, isPremium: true),
  Server(name: 'Russia', lat: 61.5240, lng: 105.3188, isPremium: true),
  Server(name: 'Turkey', lat: 38.9637, lng: 35.2433, isPremium: true),
  Server(name: 'Saudi Arabia', lat: 23.8859, lng: 45.0792, isPremium: true),
  Server(name: 'Egypt', lat: 26.8206, lng: 30.8025, isPremium: true),
  Server(name: 'Indonesia', lat: -0.7893, lng: 113.9213, isPremium: true),
  Server(name: 'Malaysia', lat: 4.2105, lng: 101.9758, isPremium: true),
  Server(name: 'Vietnam', lat: 14.0583, lng: 108.2772, isPremium: true),
  Server(name: 'Philippines', lat: 12.8797, lng: 121.7740, isPremium: true),
  Server(name: 'Thailand', lat: 15.8700, lng: 100.9925, isPremium: true),
  Server(name: 'Bangladesh', lat: 23.6850, lng: 90.3563, isPremium: true),
  Server(name: 'Pakistan', lat: 30.3753, lng: 69.3451, isPremium: true),
  Server(name: 'Morocco', lat: 31.7917, lng: -7.0926, isPremium: true),
  Server(name: 'Kenya', lat: -0.0236, lng: 37.9062, isPremium: true),
  Server(name: 'Ukraine', lat: 48.3794, lng: 31.1656, isPremium: true),
  Server(name: 'Belarus', lat: 53.7098, lng: 27.9534, isPremium: true),
  Server(name: 'Slovakia', lat: 48.6690, lng: 19.6990, isPremium: true),
  Server(name: 'Croatia', lat: 45.1000, lng: 15.2000, isPremium: true),
  Server(name: 'Slovenia', lat: 46.1512, lng: 14.9955, isPremium: true),
  Server(name: 'Lithuania', lat: 55.1694, lng: 23.8813, isPremium: true),
  Server(name: 'Latvia', lat: 56.8796, lng: 24.6032, isPremium: true),
  Server(name: 'Estonia', lat: 58.5953, lng: 25.0136, isPremium: true),
  Server(name: 'Luxembourg', lat: 49.8153, lng: 6.1296, isPremium: true),
];

/// Helper lists derived from `allServers`
final List<Server> freeServers = allServers.where((s) => !s.isPremium).toList();
final List<Server> premiumServers = allServers.where((s) => s.isPremium).toList();
