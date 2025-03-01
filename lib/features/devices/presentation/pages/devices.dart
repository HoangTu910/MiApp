import 'package:flutter/material.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  final _formKey = GlobalKey<FormState>();
  final _deviceIdController = TextEditingController();

  void _handleAddDevice() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement device addition logic
      String deviceId = _deviceIdController.text;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Adding device: $deviceId')),
      );
    }
  }

  @override
  void dispose() {
    _deviceIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _deviceIdController,
                decoration: const InputDecoration(
                  labelText: 'Device ID',
                  hintText: 'Enter device ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a device ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _handleAddDevice,
                child: const Text('Add Device'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}