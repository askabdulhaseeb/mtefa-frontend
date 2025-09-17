import 'package:flutter/material.dart';

class AddDropdownItemDialog extends StatefulWidget {
  const AddDropdownItemDialog({
    super.key,
    required this.title,
    required this.itemType,
    this.hasCodeField = true,
    this.parentEntity,
  });

  final String title;
  final String itemType;
  final bool hasCodeField;
  final String? parentEntity; // For entities that depend on parent selection

  @override
  State<AddDropdownItemDialog> createState() => _AddDropdownItemDialogState();
}

class _AddDropdownItemDialogState extends State<AddDropdownItemDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  String _codePlacement = 'pre'; // 'pre' or 'post'
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return AlertDialog(
      title: Text('Add New ${widget.title}'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Name field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: '${widget.title} Name *',
                  hintText: 'Enter ${widget.title.toLowerCase()} name',
                  border: const OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter ${widget.title.toLowerCase()} name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
              ),
              
              if (widget.hasCodeField) ...<Widget>[
                const SizedBox(height: 16),
                
                // Code field
                TextFormField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    labelText: '${widget.title} Code',
                    hintText: 'Enter code (optional)',
                    border: const OutlineInputBorder(),
                    suffixText: _generatePreview(),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  onChanged: (String value) => setState(() {}),
                ),
                
                const SizedBox(height: 16),
                
                // Code placement radio buttons
                Text(
                  'Code Placement:',
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Prefix'),
                        subtitle: Text(_generatePreview(isPrefix: true)),
                        value: 'pre',
                        groupValue: _codePlacement,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _codePlacement = value;
                            });
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Suffix'),
                        subtitle: Text(_generatePreview(isPrefix: false)),
                        value: 'post',
                        groupValue: _codePlacement,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _codePlacement = value;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],

              if (widget.parentEntity != null) ...<Widget>[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.info_outline,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'This will be linked to: ${widget.parentEntity}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleSave,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }

  String _generatePreview({bool? isPrefix}) {
    final String name = _nameController.text.trim();
    final String code = _codeController.text.trim();
    
    if (name.isEmpty) return '';
    if (code.isEmpty) return name;
    
    final bool usePrefix = isPrefix ?? (_codePlacement == 'pre');
    return usePrefix ? '$code-$name' : '$name-$code';
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final Map<String, dynamic> result = <String, dynamic>{
        'name': _nameController.text.trim(),
        'code': _codeController.text.trim(),
        'codePlacement': _codePlacement,
        'itemType': widget.itemType,
        'parentEntity': widget.parentEntity,
      };

      Navigator.of(context).pop(result);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}