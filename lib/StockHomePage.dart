import 'package:flutter/material.dart';




class StockHomePage extends StatefulWidget {
  @override
  _StockHomePageState createState() => _StockHomePageState();
}

class _StockHomePageState extends State<StockHomePage> {
  int selectedTabIndex = 0;

  final List<Map<String, dynamic>> stocks = [
    {'name': 'TechCorp', 'gain': 12.5, 'price': 150.25},
    {'name': 'BioMed Inc.', 'gain': 10.8, 'price': 85.75},
    {'name': 'Energy Solutions', 'gain': 9.2, 'price': 220.5},
    {'name': 'Retail Group', 'gain': 8.5, 'price': 75.0},
    {'name': 'Finance Co.', 'gain': 7.9, 'price': 300.0},
    {'name': 'Auto Parts', 'gain': 6.7, 'price': 120.0},
    {'name': 'Food & Bev', 'gain': 5.5, 'price': 90.0},
    {'name': 'Telecom Ltd.', 'gain': 4.8, 'price': 180.0},
  ];

  final List<String> aiPrompts = [
    "What is the PE ratio?",
    "What raw materials does it use?",
    "Who are its competitors?",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stocks', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Row(
            children: [
              _buildTabButton("Top Movers", 0),
              _buildTabButton("News", 1),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: selectedTabIndex == 0
                ? _buildStockList()
                : _buildNewsPlaceholder(),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ask AI", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 10),
                ...aiPrompts.map((prompt) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Call AI
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("AI asked: $prompt"),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Center(child: Text(prompt)),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTabIndex = index),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.black : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStockList() {
    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return ListTile(
          title: Text(stock['name']),
          subtitle: Text('+${stock['gain']}%', style: TextStyle(color: Colors.blueGrey)),
          trailing: Text('\$${stock['price'].toStringAsFixed(2)}'),
        );
      },
    );
  }

  Widget _buildNewsPlaceholder() {
    return Center(
      child: Text("News section coming soon!", style: TextStyle(fontSize: 16, color: Colors.grey)),
    );
  }
}
