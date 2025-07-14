import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:espncricinfo/models/match.dart';
class ApiService {
  static const String baseUrl = 'https://api.cricapi.com/v1';
  static const String apiKey = '476f56b5-b4cc-405b-af52-7467bbaab2f1';

  static Future<List<Match>> getMatches() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cricScore?apikey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['status'] == 'success' && data['data'] != null) {
          final List<dynamic> matchesData = data['data'];
          return matchesData.map((json) => Match.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load matches: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Failed to load matches: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load matches: $e');
    }
  }

  static Future<Match?> getMatchDetails(String matchId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cricScore?apikey=$apiKey&id=$matchId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['status'] == 'success' && data['data'] != null) {
          return Match.fromJson(data['data']);
        } else {
          throw Exception('Failed to load match details: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Failed to load match details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load match details: $e');
    }
  }
} 