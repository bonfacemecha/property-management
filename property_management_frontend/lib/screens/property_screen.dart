import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../dialogs/add_property_dialog.dart';
import 'package:intl/intl.dart';

class PropertyScreen extends StatefulWidget {
  @override
  _PropertyScreenState createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  List<dynamic> properties = [];
  bool isLoading = true;
  List<dynamic> filteredProperties = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    loadProperties();
  }

  // Fetch properties from the backend
  Future<void> loadProperties() async {
    setState(() {
      isLoading = true;
    });

    try {
      var fetchedProperties = await ApiService.fetchProperties();
      setState(() {
        properties = fetchedProperties;
        filteredProperties = fetchedProperties;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching properties: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load properties")),
      );
    }
  }

  // Handle search functionality
  void searchProperties(String query) {
    setState(() {
      searchQuery = query;
      filteredProperties = properties
          .where((property) =>
              property['name'].toLowerCase().contains(query.toLowerCase()) ||
              property['price'].toLowerCase().contains(query.toLowerCase()) ||
              property['address'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  String capitalize(String text) {
    if (text == null || text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  // Handle delete action
  Future<void> handleDelete(int id) async {
    try {
      await ApiService.deleteProperty(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Property deleted successfully")),
      );
      loadProperties();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete property")),
      );
    }
  }

  // Handle Edit Logic
  Future<void> handleEdit(dynamic property) async {
    showDialog(
      context: context,
      builder: (context) => AddPropertyDialog(
        onSave: loadProperties,
        property: property,
      ),
    );
  }

  // Summary card widget
  Widget summaryCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.grey)),
                  Text(
                    value,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalProperties = properties.length;
    int availableProperties =
        properties.where((property) => property['status'] == 'active').length;

    // Dynamic summary data
    List<Map<String, dynamic>> summaryData = [
      {
        'title': 'Total Properties',
        'value': '$totalProperties',
        'icon': Icons.home,
        'color': Colors.blue,
      },
      {
        'title': 'Available Properties',
        'value': '$availableProperties',
        'icon': Icons.check_circle,
        'color': Colors.green,
      },
      {
        'title': 'Unavailable Properties',
        'value': '${totalProperties - availableProperties}',
        'icon': Icons.block,
        'color': Colors.red,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Property Management"),
        actions: [
          // Wrap the "Add Property" button with a Container and Padding
          Container(
            margin: EdgeInsets.all(8.0), // Add margin around the button
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Add padding inside the container
              child: MouseRegion(
                onEnter: (_) => setState(() {
                  // Trigger hover state change (optional)
                }),
                onExit: (_) => setState(() {
                  // Reset hover state (optional)
                }),
                child: Tooltip(
                  message: 'Add New Property', // Tooltip for the button
                  child: TextButton.icon(
                    icon: Icon(Icons.add, color: Colors.white),
                    label: Text(
                      "Add Property",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue, // Blue background
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            AddPropertyDialog(onSave: loadProperties),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0), // Padding for the body
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(8), // Rounded corners for container
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8.0,
                      offset: Offset(0, 2), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Summary Cards
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: summaryData.map((data) {
                          return summaryCard(
                            data['title'],
                            data['value'],
                            data['icon'],
                            data['color'],
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 8),
                    // Search bar
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search properties...",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onChanged: searchProperties,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Property DataTable
                    Expanded(
                      child: filteredProperties.isEmpty
                          ? Center(child: Text("No properties found"))
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: [
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Address')),
                                  DataColumn(label: Text('Price')),
                                  DataColumn(label: Text('Status')),
                                  DataColumn(label: Text('Actions')),
                                ],
                                rows: filteredProperties.map((property) {
                                  return DataRow(cells: [
                                    DataCell(
                                        Text(property['name'] ?? 'Unknown')),
                                    DataCell(
                                        Text(property['address'] ?? 'Unknown')),
                                    DataCell(
                                      Text(
                                        property['price'] != null
                                            ? NumberFormat.currency(
                                                    locale: 'en_US',
                                                    symbol: '\$')
                                                .format(double.parse(
                                                    property['price']))
                                            : 'Unknown',
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Badge for status
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: property['status'] ==
                                                      'active'
                                                  ? Colors.green
                                                  : Colors
                                                      .red, // Green for active, red for inactive
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              capitalize(property['status'] ??
                                                  'Unknown'), // Capitalize only the first letter
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.blue,
                                            ),
                                            onPressed: () {
                                              handleEdit(property);
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title:
                                                      Text('Delete Property?'),
                                                  content: Text(
                                                      "Are you sure you want to delete this property?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Cancel'),
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        await handleDelete(
                                                          property['id'],
                                                        );
                                                      },
                                                      child: Text('Delete'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]);
                                }).toList(),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
