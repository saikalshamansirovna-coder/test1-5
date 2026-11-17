import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/date_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../domain/entities/note_entity.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../bloc/notes_state.dart';
import '../widgets/note_animation.dart';
import 'note_form_page.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesBloc>(
      create: (_) => getIt<NotesBloc>()..add(LoadNotesEvent()),
      child: const _NotesView(),
    );
  }
}

class _NotesView extends StatelessWidget {
  const _NotesView();

  void _openForm(BuildContext context, {NoteEntity? note}) {
    final bloc = context.read<NotesBloc>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: bloc,
          child: NoteFormPage(note: note),
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, NoteEntity note) async {
    final bloc = context.read<NotesBloc>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить заметку?'),
        content: Text('«${note.title.ellipsize(40)}» будет удалена.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (ok == true) bloc.add(DeleteNoteEvent(note.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Заметки')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(context),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state is NotesError) context.showMessage(state.message);
        },
        // Во время перезагрузки списка не показываем спиннер поверх данных
        buildWhen: (prev, curr) =>
            !(curr is NotesLoading && prev is NotesLoaded),
        builder: (context, state) {
          if (state is NotesLoaded) {
            if (state.notes.isEmpty) {
              return const Center(child: Text('Заметок пока нет. Нажмите «+»'));
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 88),
              itemCount: state.notes.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return _NoteCard(
                  note: note,
                  onTap: () => _openForm(context, note: note),
                  onDelete: () => _confirmDelete(context, note),
                );
              },
            );
          }
          if (state is NotesError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final NoteEntity note;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _NoteCard({
    required this.note,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.only(left: 16, right: 4),
        title: Text(note.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.content, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(
              note.updatedAt.toFormattedDate(),
              style: context.theme.textTheme.labelSmall,
            ),
          ],
        ),
        // Справа: анимация рядом с кнопкой удаления
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NoteAnimation(animationId: note.animationId, size: 44),
            IconButton(
              tooltip: 'Удалить',
              icon: const Icon(Icons.delete_outline),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
