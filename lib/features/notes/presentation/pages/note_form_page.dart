import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_animations.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../domain/entities/note_entity.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../widgets/animation_picker.dart';

/// Экран создания (note == null) и редактирования заметки.
class NoteFormPage extends StatefulWidget {
  final NoteEntity? note;

  const NoteFormPage({super.key, this.note});

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late int _animationId;

  bool get _isEditing => widget.note != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
    _animationId = widget.note?.animationId ?? AppAnimations.defaultId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trimmed;
    final content = _contentController.text.trimmed;
    final bloc = context.read<NotesBloc>();

    if (_isEditing) {
      bloc.add(UpdateNoteEvent(
        widget.note!.copyWith(
          title: title,
          content: content,
          animationId: _animationId,
        ),
      ));
    } else {
      bloc.add(CreateNoteEvent(
        title: title,
        content: content,
        animationId: _animationId,
      ));
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Редактирование' : 'Новая заметка'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Заголовок',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.isBlank) ? 'Введите заголовок' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                minLines: 5,
                maxLines: 10,
                decoration: const InputDecoration(
                  labelText: 'Текст заметки',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.isBlank) ? 'Введите текст заметки' : null,
              ),
              const SizedBox(height: 20),
              Text('Анимация', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              AnimationPicker(
                selectedId: _animationId,
                onSelected: (id) => setState(() => _animationId = id),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.check),
                label: Text(_isEditing ? 'Сохранить' : 'Создать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
