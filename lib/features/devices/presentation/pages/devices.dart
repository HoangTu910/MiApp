import 'package:flutter/material.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  final _formKey = GlobalKey<FormState>();
  final _deviceIdController = TextEditingController();
  final List<String> _connectedDevices = [];
  bool _showDeviceField = false;

  void _handleAddDevice() {
    if (_showDeviceField) {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _connectedDevices.add(_deviceIdController.text);
          _deviceIdController.clear();
          _showDeviceField = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Device connected successfully!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      setState(() {
        _showDeviceField = true;
      });
    }
  }

  void _showDeviceOptions(String deviceId, int index) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text('Device ID: $deviceId'),
                subtitle: const Text('Status: Connected'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.watch),
                title: const Text('Device Type'),
                subtitle: const Text('STM32'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text('Remove Device', 
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  setState(() {
                    _connectedDevices.removeAt(index);
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Device removed')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _deviceIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Devices'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_showDeviceField) ...[
                    TextFormField(
                    cursorColor: Colors.blue,
                    controller: _deviceIdController,
                    decoration: const InputDecoration(
                      labelText: 'Device ID',
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Enter device ID',
                      border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                      return 'Please enter a device ID';
                      }
                      return null;
                    },
                    ),
                  const SizedBox(height: 8),
                  ],
                  ElevatedButton.icon(
                  onPressed: _handleAddDevice,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: Text(
                    _showDeviceField ? 'Connect' : 'Add Device',
                    style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: _connectedDevices.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.watch, size: 32), // Changed to watch icon
                      title: Text(_connectedDevices[index]),
                      subtitle: const Text('Connected'),
                      trailing: const Icon(Icons.check_circle, color: Colors.green),
                      onLongPress: () => _showDeviceOptions(_connectedDevices[index], index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}