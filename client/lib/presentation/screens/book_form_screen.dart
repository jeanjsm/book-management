import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/book.dart';
import '../../domain/book_actions_provider.dart';
import '../../domain/book_detail_provider.dart';
import '../../domain/book_list_provider.dart';

class BookFormScreen extends ConsumerStatefulWidget {
  final int? id;

  const BookFormScreen({super.key, this.id});

  @override
  ConsumerState<BookFormScreen> createState() => _BookFormScreenState();
}

class _BookFormScreenState extends ConsumerState<BookFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeCtrl = TextEditingController();
  final _titleCtrl = TextEditingController();
  final _authorCtrl = TextEditingController();
  final _numberCtrl = TextEditingController(text: '1');
  final _paidCtrl = TextEditingController(text: '0.0');
  final _labelCtrl = TextEditingController(text: '0.0');
  final _barcodeCtrl = TextEditingController();
  final _coverCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      Future.microtask(() async {
        final book = await ref.read(bookDetailProvider(widget.id!).future);
        if (!mounted) return;
        setState(() {
          _codeCtrl.text = book.code;
          _titleCtrl.text = book.title;
          _authorCtrl.text = book.author;
          _numberCtrl.text = book.number.toString();
          _paidCtrl.text = book.paidPrice;
          _labelCtrl.text = book.labelPrice;
          _barcodeCtrl.text = book.barcode ?? '';
          _coverCtrl.text = book.coverUrl ?? '';
        });
      });
    }
  }

  @override
  void dispose() {
    _codeCtrl.dispose();
    _titleCtrl.dispose();
    _authorCtrl.dispose();
    _numberCtrl.dispose();
    _paidCtrl.dispose();
    _labelCtrl.dispose();
    _barcodeCtrl.dispose();
    _coverCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final book = Book(
      code: _codeCtrl.text,
      title: _titleCtrl.text,
      author: _authorCtrl.text,
      number: int.parse(_numberCtrl.text),
      paidPrice: _paidCtrl.text,
      labelPrice: _labelCtrl.text,
      barcode: _barcodeCtrl.text.isEmpty ? null : _barcodeCtrl.text,
      coverUrl: _coverCtrl.text.isEmpty ? null : _coverCtrl.text,
    );

    if (widget.id != null) {
      await ref.read(updateBookProvider(UpdateParams(
        id: widget.id!,
        title: _titleCtrl.text,
        author: _authorCtrl.text,
        number: int.parse(_numberCtrl.text),
      )).future);
    } else {
      await ref.read(createBookProvider(book).future);
    }

    ref.invalidate(bookListProvider(BookListParams()));
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.id != null ? 'Edit Book' : 'New Book')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _codeCtrl,
              decoration: const InputDecoration(labelText: 'Code'),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              enabled: widget.id == null,
            ),
            TextFormField(
              controller: _titleCtrl,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              controller: _authorCtrl,
              decoration: const InputDecoration(labelText: 'Author'),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              controller: _numberCtrl,
              decoration: const InputDecoration(labelText: 'Number'),
              keyboardType: TextInputType.number,
              validator: (v) => v == null || int.tryParse(v) == null ? 'Invalid' : null,
            ),
            TextFormField(
              controller: _paidCtrl,
              decoration: const InputDecoration(labelText: 'Paid Price'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            TextFormField(
              controller: _labelCtrl,
              decoration: const InputDecoration(labelText: 'Label Price'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            TextFormField(
              controller: _barcodeCtrl,
              decoration: const InputDecoration(labelText: 'Barcode'),
            ),
            TextFormField(
              controller: _coverCtrl,
              decoration: const InputDecoration(labelText: 'Cover URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _save, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
