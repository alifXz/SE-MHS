import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/services/event_service.dart';
import 'package:flutter_final_project_kintkin/widgets/filter_sheet.dart';
import '../widgets/app_drawer.dart';
import '../widgets/explore_card.dart';
import '../widgets/search_bar.dart';

class ExploreScreen extends StatefulWidget {

  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  bool isEventsSelected = true;

  List<dynamic> _events = [];
  bool _loading = true;

  Set<String> _selectedFilters = {}; 

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final events = await EventService().getUpcomingEvents();

    if(!mounted) return;

    setState(() {
      _events = events;
      _loading = false;
    });
  }

  void dispose(){
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      await _loadEvents();
      return;


    }


    setState(() {
      _loading = true;
    });

    final results = await EventService().searchEvents(query);

    if (!mounted) return;

    setState(() {
      _events = results;
      _loading = false;
    });
  }
  
    //FILTER buat yg category
    Future<void> _openFilter() async {
    final result = await showFilterSheet(
      context,
      initialSelected: _selectedFilters,
    );
    //Nanti backendnya send ke _selectedFilters
    if (result != null) {
      setState(() => _selectedFilters = result);
    }
  }
  
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 15),
              child: Row(
                children: [
                  const Text(
                    "Find Your Event/Community!",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none, color: Colors.black),
                  ),
                 Builder(
                    builder: (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: ExploreSearchBar(
                    controller: _searchController,
                    onSearch: _performSearch,
                    onClear: () {
                      setState(() {
                        _searchController.clear();
                        _performSearch('');
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _openFilter,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _selectedFilters.isEmpty
                          ? Colors.grey[100]
                          : const Color(0xFF003049),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.tune,
                      size: 20,
                      color: _selectedFilters.isEmpty
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // --- DYNAMIC LIST SECTION ---
          Expanded(
            child: _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  final event = _events[index];

                  return ExploreCard(isCommunity: !isEventsSelected, event: event);
                }, 
            ),
          ),
        ],
      ),
      
    );
  }

}