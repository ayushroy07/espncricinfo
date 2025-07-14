import 'package:flutter/material.dart';
import 'package:espncricinfo/models/match.dart';

class MatchCard extends StatelessWidget {
  final Match match;
  final VoidCallback onTap;

  const MatchCard({
    super.key,
    required this.match,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: _getCardGradient(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildTeams(),
              const SizedBox(height: 12),
              _buildScores(),
              const SizedBox(height: 12),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getMatchTypeColor(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            match.matchType.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacer(),
        _buildStatusChip(),
      ],
    );
  }

  Widget _buildStatusChip() {
    Color chipColor;
    IconData icon;
    
    if (match.isLive) {
      chipColor = Colors.red;
      icon = Icons.fiber_manual_record;
    } else if (match.isUpcoming) {
      chipColor = Colors.orange;
      icon = Icons.schedule;
    } else {
      chipColor = Colors.grey;
      icon = Icons.check_circle;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: chipColor,
          ),
          const SizedBox(width: 4),
          Text(
            match.isLive ? 'LIVE' : match.isUpcoming ? 'UPCOMING' : 'FINISHED',
            style: TextStyle(
              color: chipColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeams() {
    return Row(
      children: [
        Expanded(
          child: _buildTeamSection(
            match.team1Name,
            Icons.sports_cricket,
            Colors.blue,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'VS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: _buildTeamSection(
            match.team2Name,
            Icons.sports_cricket,
            Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamSection(String teamName, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          teamName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildScores() {
    String scoreText = '${match.team1Score} | ${match.team2Score}';
    
    if (match.team1Score == 'Yet to bat' && match.team2Score == 'Yet to bat') {
      scoreText = 'Match not started';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        scoreText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        Icon(
          Icons.sports_cricket,
          color: Colors.white.withOpacity(0.7),
          size: 16,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            match.seriesName.isNotEmpty ? match.seriesName : 'Cricket Match',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Spacer(),
        Icon(
          Icons.access_time,
          color: Colors.white.withOpacity(0.7),
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          '${match.formattedDate} ${match.formattedTime}',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  LinearGradient _getCardGradient() {
    if (match.isLive) {
      return const LinearGradient(
        colors: [Color(0xFFE53E3E), Color(0xFFC53030)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (match.isUpcoming) {
      return const LinearGradient(
        colors: [Color(0xFFED8936), Color(0xFFDD6B20)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return const LinearGradient(
        colors: [Color(0xFF2D3748), Color(0xFF4A5568)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

  Color _getMatchTypeColor() {
    switch (match.matchType.toLowerCase()) {
      case 't20':
        return const Color(0xFFE53E3E);
      case 'odi':
        return const Color(0xFF3182CE);
      case 'test':
        return const Color(0xFF38A169);
      default:
        return const Color(0xFF805AD5);
    }
  }
} 