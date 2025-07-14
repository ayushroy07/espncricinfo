class Match {
  final String id;
  final String name;
  final String matchType;
  final String status;
  final String venue;
  final String date;
  final String dateTimeGMT;
  final List<String> teams;
  final Map<String, dynamic> score;
  final String tossWinner;
  final String tossChoice;
  final String matchWinner;
  final String seriesId;
  final String seriesName;
  final String ms; // match status
  final String t1; // team 1
  final String t2; // team 2
  final String t1s; // team 1 score
  final String t2s; // team 2 score
  final String t1img; // team 1 image
  final String t2img; // team 2 image
  final String series; // series name

  Match({
    required this.id,
    required this.name,
    required this.matchType,
    required this.status,
    required this.venue,
    required this.date,
    required this.dateTimeGMT,
    required this.teams,
    required this.score,
    required this.tossWinner,
    required this.tossChoice,
    required this.matchWinner,
    required this.seriesId,
    required this.seriesName,
    required this.ms,
    required this.t1,
    required this.t2,
    required this.t1s,
    required this.t2s,
    required this.t1img,
    required this.t2img,
    required this.series,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'] ?? '',
      name: _buildMatchName(json['t1'] ?? '', json['t2'] ?? ''),
      matchType: json['matchType'] ?? '',
      status: json['status'] ?? '',
      venue: '', // API doesn't provide venue
      date: json['date'] ?? '',
      dateTimeGMT: json['dateTimeGMT'] ?? '',
      teams: [json['t1'] ?? '', json['t2'] ?? ''],
      score: {
        't1': json['t1s'] ?? '',
        't2': json['t2s'] ?? '',
      },
      tossWinner: '', // API doesn't provide toss info
      tossChoice: '',
      matchWinner: '', // API doesn't provide match winner
      seriesId: '', // API doesn't provide series ID
      seriesName: json['series'] ?? '',
      ms: json['ms'] ?? '',
      t1: json['t1'] ?? '',
      t2: json['t2'] ?? '',
      t1s: json['t1s'] ?? '',
      t2s: json['t2s'] ?? '',
      t1img: json['t1img'] ?? '',
      t2img: json['t2img'] ?? '',
      series: json['series'] ?? '',
    );
  }

  static String _buildMatchName(String team1, String team2) {
    if (team1.isNotEmpty && team2.isNotEmpty) {
      return '$team1 vs $team2';
    } else if (team1.isNotEmpty) {
      return team1;
    } else if (team2.isNotEmpty) {
      return team2;
    }
    return 'Match';
  }

  String get matchResult {
    if (status.toLowerCase().contains('won')) {
      return status;
    } else if (status.toLowerCase().contains('drawn')) {
      return 'Match Drawn';
    } else if (status.toLowerCase().contains('tied')) {
      return 'Match Tied';
    } else if (status.toLowerCase().contains('live')) {
      return 'Live';
    } else if (status.toLowerCase().contains('upcoming')) {
      return 'Upcoming';
    } else if (status.toLowerCase().contains('not started')) {
      return 'Not Started';
    } else {
      return status;
    }
  }

  bool get isLive => ms == 'live';
  bool get isUpcoming => ms == 'fixture';
  bool get isFinished => ms == 'result';

  String get formattedDate {
    try {
      final dateTime = DateTime.parse(dateTimeGMT);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return date;
    }
  }

  String get formattedTime {
    try {
      final dateTime = DateTime.parse(dateTimeGMT);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '';
    }
  }

  String get team1Name {
    return t1.replaceAll(RegExp(r'\[.*?\]'), '').trim();
  }

  String get team2Name {
    return t2.replaceAll(RegExp(r'\[.*?\]'), '').trim();
  }

  String get team1Score {
    return t1s.isNotEmpty ? t1s : 'Yet to bat';
  }

  String get team2Score {
    return t2s.isNotEmpty ? t2s : 'Yet to bat';
  }
} 