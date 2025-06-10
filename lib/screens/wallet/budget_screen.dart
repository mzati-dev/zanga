import 'package:flutter/material.dart';
import 'package:zanga/models/budget_category.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final List<BudgetCategory> _categories = [
    BudgetCategory(
      name: 'Food & Dining',
      icon: Icons.restaurant,
      color: Colors.red,
      budget: 5000.00,
      spent: 3200.00,
    ),
    BudgetCategory(
      name: 'Transport',
      icon: Icons.directions_car,
      color: Colors.blue,
      budget: 3000.00,
      spent: 1500.00,
    ),
    BudgetCategory(
      name: 'Utilities',
      icon: Icons.bolt,
      color: Colors.orange,
      budget: 4000.00,
      spent: 3800.00,
    ),
    BudgetCategory(
      name: 'Shopping',
      icon: Icons.shopping_bag,
      color: Colors.purple,
      budget: 2000.00,
      spent: 2500.00,
    ),
    BudgetCategory(
      name: 'Entertainment',
      icon: Icons.movie,
      color: Colors.green,
      budget: 1500.00,
      spent: 800.00,
    ),
  ];

  double get _totalBudget =>
      _categories.fold(0, (sum, category) => sum + category.budget);
  double get _totalSpent =>
      _categories.fold(0, (sum, category) => sum + category.spent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _addNewCategory),
        ],
      ),
      body: Column(
        children: [
          _buildBudgetSummary(),
          Expanded(
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryCard(_categories[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetSummary() {
    final double percentage =
        _totalBudget > 0 ? (_totalSpent / _totalBudget) : 0;

    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Monthly Budget Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[300],
              color:
                  percentage > 0.9
                      ? Colors.red
                      : percentage > 0.7
                      ? Colors.orange
                      : Colors.green,
              minHeight: 12,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Spent: MK ${_totalSpent.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Remaining: MK ${(_totalBudget - _totalSpent).toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${(percentage * 100).toStringAsFixed(1)}% of budget'),
                Text('Total: MK ${_totalBudget.toStringAsFixed(2)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BudgetCategory category) {
    final double percentage =
        category.budget > 0 ? (category.spent / category.budget) : 0;
    final bool isOverBudget = category.spent > category.budget;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: category.color.withOpacity(0.2),
          child: Icon(category.icon, color: category.color),
        ),
        title: Text(category.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: percentage > 1 ? 1 : percentage,
              backgroundColor: Colors.grey[200],
              color: isOverBudget ? Colors.red : Colors.green,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'MK ${category.spent.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: isOverBudget ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'MK ${category.budget.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => _editCategory(category),
        ),
      ),
    );
  }

  void _addNewCategory() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController budgetController = TextEditingController();
    IconData selectedIcon = Icons.category;
    Color selectedColor = Colors.blue;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add New Budget Category'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Category Name',
                        hintText: 'e.g. Rent, Groceries',
                      ),
                    ),
                    TextField(
                      controller: budgetController,
                      decoration: const InputDecoration(
                        labelText: 'Budget Amount (MK)',
                        hintText: 'Enter monthly budget',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    const Text('Select Icon:'),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildIconOption(Icons.fastfood, selectedIcon, () {
                          setState(() => selectedIcon = Icons.fastfood);
                        }),
                        _buildIconOption(
                          Icons.directions_bus,
                          selectedIcon,
                          () {
                            setState(() => selectedIcon = Icons.directions_bus);
                          },
                        ),
                        _buildIconOption(Icons.home, selectedIcon, () {
                          setState(() => selectedIcon = Icons.home);
                        }),
                        _buildIconOption(Icons.shopping_cart, selectedIcon, () {
                          setState(() => selectedIcon = Icons.shopping_cart);
                        }),
                        _buildIconOption(
                          Icons.health_and_safety,
                          selectedIcon,
                          () {
                            setState(
                              () => selectedIcon = Icons.health_and_safety,
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Select Color:'),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildColorOption(Colors.red, selectedColor, () {
                          setState(() => selectedColor = Colors.red);
                        }),
                        _buildColorOption(Colors.blue, selectedColor, () {
                          setState(() => selectedColor = Colors.blue);
                        }),
                        _buildColorOption(Colors.green, selectedColor, () {
                          setState(() => selectedColor = Colors.green);
                        }),
                        _buildColorOption(Colors.orange, selectedColor, () {
                          setState(() => selectedColor = Colors.orange);
                        }),
                        _buildColorOption(Colors.purple, selectedColor, () {
                          setState(() => selectedColor = Colors.purple);
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        budgetController.text.isNotEmpty) {
                      setState(() {
                        _categories.add(
                          BudgetCategory(
                            name: nameController.text,
                            icon: selectedIcon,
                            color: selectedColor,
                            budget: double.tryParse(budgetController.text) ?? 0,
                            spent: 0,
                          ),
                        );
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildIconOption(
    IconData icon,
    IconData selectedIcon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor:
            icon == selectedIcon ? Colors.blue[100] : Colors.grey[200],
        child: Icon(icon),
      ),
    );
  }

  Widget _buildColorOption(
    Color color,
    Color selectedColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        child: Icon(color == selectedColor ? Icons.check : null, color: color),
      ),
    );
  }

  void _editCategory(BudgetCategory category) {
    final TextEditingController budgetController = TextEditingController(
      text: category.budget.toStringAsFixed(2),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit ${category.name} Budget'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Current Spending: MK ${category.spent.toStringAsFixed(2)}'),
              const SizedBox(height: 16),
              TextField(
                controller: budgetController,
                decoration: const InputDecoration(
                  labelText: 'New Budget Amount (MK)',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newBudget = double.tryParse(budgetController.text);
                if (newBudget != null) {
                  setState(() {
                    category.budget = newBudget;
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
