import 'package:flutter/material.dart';
import 'package:espncricinfo/models/match.dart';
import 'package:espncricinfo/services/api_service.dart';
import 'package:espncricinfo/widgets/match_card.dart';
import 'package:espncricinfo/widgets/match_detail_page.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  List<Match> _matches = [];
  List<Match> _filteredMatches = [];
  bool _isLoading = true;
  String _error = '';
  
  // Filter and sort variables
  String _selectedMatchType = 'All';
  String _selectedResult = 'All';
  String _sortBy = 'Recent';

  final List<String> _matchTypes = ['All', 'T20', 'ODI', 'Test'];
  final List<String> _resultTypes = ['All', 'Live', 'Upcoming', 'Finished'];
  final List<String> _sortOptions = ['Recent', 'Oldest'];

  @override
  void initState() {
    super.initState();
    _loadMatches();
  }

  Future<void> _loadMatches() async {
    try {
      setState(() {
        _isLoading = true;
        _error = '';
      });

      final matches = await ApiService.getMatches();
      
      setState(() {
        _matches = matches;
        _filteredMatches = matches;
        _isLoading = false;
      });
      
      _applyFilters();
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    List<Match> filtered = _matches;

    // Filter by match type
    if (_selectedMatchType != 'All') {
      filtered = filtered.where((match) => 
        match.matchType.toLowerCase().contains(_selectedMatchType.toLowerCase())
      ).toList();
    }

    // Filter by result
    if (_selectedResult != 'All') {
      switch (_selectedResult) {
        case 'Live':
          filtered = filtered.where((match) => match.isLive).toList();
          break;
        case 'Upcoming':
          filtered = filtered.where((match) => match.isUpcoming).toList();
          break;
        case 'Finished':
          filtered = filtered.where((match) => match.isFinished).toList();
          break;
      }
    }

    // Sort matches
    if (_sortBy == 'Recent') {
      filtered.sort((a, b) => b.dateTimeGMT.compareTo(a.dateTimeGMT));
    } else {
      filtered.sort((a, b) => a.dateTimeGMT.compareTo(b.dateTimeGMT));
    }

    setState(() {
      _filteredMatches = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'MatchInfo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadMatches,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error.isNotEmpty
                    ? _buildErrorWidget()
                    : _buildMatchesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildFilterDropdown(
                  'Match Type',
                  _selectedMatchType,
                  _matchTypes,
                  (value) {
                    setState(() {
                      _selectedMatchType = value!;
                    });
                    _applyFilters();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFilterDropdown(
                  'Result',
                  _selectedResult,
                  _resultTypes,
                  (value) {
                    setState(() {
                      _selectedResult = value!;
                    });
                    _applyFilters();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildFilterDropdown(
                  'Sort By',
                  _sortBy,
                  _sortOptions,
                  (value) {
                    setState(() {
                      _sortBy = value!;
                    });
                    _applyFilters();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${_filteredMatches.length} matches',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(
    String label,
    String value,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(
                  option,
                  style: const TextStyle(fontSize: 14),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading matches',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _error,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadMatches,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchesList() {
    if (_filteredMatches.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sports_cricket,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No matches found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadMatches,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _filteredMatches.length,
        itemBuilder: (context, index) {
          final match = _filteredMatches[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: MatchCard(
              match: match,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MatchDetailPage(match: match),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
} 