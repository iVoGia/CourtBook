/// Court image resolver — asset by sport_type, then network URL, then placeholder.
class CourtImages {
  static const placeholder = 'assets/images/placeholder.png';

  static const _bySport = {
    'badminton': 'assets/images/badminton.jpg',
    'mini_football': 'assets/images/mini_football.jpg',
    'tennis': 'assets/images/tennis.jpg',
  };

  static String assetForSport(String? sportType) {
    if (sportType == null) return placeholder;
    return _bySport[sportType] ?? placeholder;
  }

  static String? networkUrl(Map<String, dynamic> court) {
    final url = court['image_url']?.toString();
    if (url == null || url.isEmpty) return null;
    return url;
  }
}
