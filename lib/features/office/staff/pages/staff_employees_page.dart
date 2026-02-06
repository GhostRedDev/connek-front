import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StaffEmployeesPage extends StatefulWidget {
  final int businessId;

  const StaffEmployeesPage({super.key, required this.businessId});

  @override
  State<StaffEmployeesPage> createState() => _StaffEmployeesPageState();
}

class _StaffEmployeesPageState extends State<StaffEmployeesPage> {
  List<Map<String, dynamic>> _employees = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await Supabase.instance.client
          .from('employees')
          .select()
          .eq('business_id', widget.businessId)
          .order('created_at', ascending: false);

      if (!mounted) return;
      setState(() {
        _employees = List<Map<String, dynamic>>.from(response);
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadEmployees,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_employees.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No employees yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first employee to get started',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _employees.length,
        itemBuilder: (context, index) {
          final employee = _employees[index];
          return _EmployeeCard(
            employee: employee,
            onEdit: () => _showEditDialog(employee),
            onDelete: () => _confirmDelete(employee),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateDialog,
        icon: const Icon(Icons.person_add),
        label: const Text('Add Employee'),
      ),
    );
  }

  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) => _EmployeeDialog(
        businessId: widget.businessId,
        onSaved: _loadEmployees,
      ),
    );
  }

  void _showEditDialog(Map<String, dynamic> employee) {
    showDialog(
      context: context,
      builder: (context) => _EmployeeDialog(
        businessId: widget.businessId,
        employee: employee,
        onSaved: _loadEmployees,
      ),
    );
  }

  void _confirmDelete(Map<String, dynamic> employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Employee'),
        content: Text('Are you sure you want to delete "${employee['name']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _deleteEmployee(employee['id']);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteEmployee(int id) async {
    try {
      await Supabase.instance.client.from('employees').delete().eq('id', id);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Employee deleted successfully')),
      );
      _loadEmployees();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting employee: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class _EmployeeCard extends StatelessWidget {
  final Map<String, dynamic> employee;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _EmployeeCard({
    required this.employee,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = employee['status'] == 'Activo';
    final isBot = employee['type'] == 'bot';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: employee['image'] != null
              ? NetworkImage(employee['image'])
              : null,
          child: employee['image'] == null
              ? Icon(isBot ? Icons.smart_toy : Icons.person)
              : null,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                employee['name'] ?? 'Unknown',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (isBot)
              const Chip(
                label: Text('Bot', style: TextStyle(fontSize: 11)),
                padding: EdgeInsets.symmetric(horizontal: 4),
                visualDensity: VisualDensity.compact,
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(employee['role'] ?? 'No role'),
            if (employee['description'] != null)
              Text(
                employee['description'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isActive ? Colors.green[100] : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                employee['status'] ?? 'Unknown',
                style: TextStyle(
                  color: isActive ? Colors.green[900] : Colors.grey[700],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: onDelete,
              color: Colors.red[300],
            ),
          ],
        ),
        isThreeLine: employee['description'] != null,
      ),
    );
  }
}

class _EmployeeDialog extends StatefulWidget {
  final int businessId;
  final Map<String, dynamic>? employee;
  final VoidCallback onSaved;

  const _EmployeeDialog({
    required this.businessId,
    this.employee,
    required this.onSaved,
  });

  @override
  State<_EmployeeDialog> createState() => _EmployeeDialogState();
}

class _EmployeeDialogState extends State<_EmployeeDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _roleController;
  late TextEditingController _descriptionController;
  late TextEditingController _purposeController;
  String _status = 'Activo';
  String _type = 'human';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final emp = widget.employee;
    _nameController = TextEditingController(text: emp?['name'] ?? '');
    _roleController = TextEditingController(text: emp?['role'] ?? '');
    _descriptionController = TextEditingController(
      text: emp?['description'] ?? '',
    );
    _purposeController = TextEditingController(text: emp?['purpose'] ?? '');
    _status = emp?['status'] ?? 'Activo';
    _type = emp?['type'] ?? 'human';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _descriptionController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.employee != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Employee' : 'Add Employee'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name *',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v?.trim().isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _roleController,
                  decoration: const InputDecoration(
                    labelText: 'Role *',
                    hintText: 'e.g., Manager, Developer',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v?.trim().isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description *',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                  validator: (v) =>
                      v?.trim().isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _purposeController,
                  decoration: const InputDecoration(
                    labelText: 'Purpose *',
                    hintText: 'e.g., Sales, Support',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v?.trim().isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _type,
                  decoration: const InputDecoration(
                    labelText: 'Type',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'human', child: Text('Human')),
                    DropdownMenuItem(value: 'bot', child: Text('Bot')),
                  ],
                  onChanged: (v) => setState(() => _type = v!),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _status,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Activo', child: Text('Active')),
                    DropdownMenuItem(
                      value: 'Inactivo',
                      child: Text('Inactive'),
                    ),
                  ],
                  onChanged: (v) => setState(() => _status = v!),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleSubmit,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(isEditing ? 'Update' : 'Create'),
        ),
      ],
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final data = {
        'business_id': widget.businessId,
        'name': _nameController.text.trim(),
        'role': _roleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'purpose': _purposeController.text.trim(),
        'type': _type,
        'status': _status,
        // Add required NOT NULL fields with defaults
        'skills': '',
        'price': 0,
        'currency': 'USD',
        'frequency': 'monthly',
      };

      if (widget.employee != null) {
        await Supabase.instance.client
            .from('employees')
            .update(data)
            .eq('id', widget.employee!['id']);
      } else {
        await Supabase.instance.client.from('employees').insert(data);
      }

      if (mounted) {
        Navigator.pop(context);
        widget.onSaved();
        // Show success message using a callback instead of ScaffoldMessenger
      }
    } catch (e) {
      if (mounted) {
        // Show error in the dialog itself
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to save employee: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
