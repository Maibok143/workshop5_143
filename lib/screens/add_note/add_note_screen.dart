import 'package:flutter/material.dart';
import '../../models/note.dart';
import '../../repository/note_repository.dart';

// ข้อ 16-20, 28, 33-34: หน้าเพิ่ม / แก้ไข / ลบโน้ต
class AddNoteScreen extends StatefulWidget {
  final Note? note; // มีค่าเมื่อเป็นการแก้ไข, เป็น null เมื่อเพิ่มใหม่
  const AddNoteScreen({super.key, this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();

  // ข้อ 33: ถ้าเป็นการแก้ไข ให้ใส่ค่าเดิมลงในช่องกรอก
  @override
  void initState() {
    if (widget.note != null) {
      _title.text = widget.note!.title;
      _description.text = widget.note!.description;
    }
    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  // ข้อ 28: บันทึกโน้ตใหม่
  Future<void> _insertNote() async {
    if (_title.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("กรุณาใส่ Title")),
      );
      return;
    }
    final note = Note(
      title: _title.text,
      description: _description.text,
      createdAt: DateTime.now(),
    );
    await NoteRepository.insert(note: note);
    if (!mounted) return;
    Navigator.pop(context);
  }

  // ข้อ 33: อัปเดตโน้ตเดิม (คงวันเวลาที่สร้างไว้เหมือนเดิม)
  Future<void> _updateNote() async {
    final note = Note(
      id: widget.note!.id!,
      title: _title.text,
      description: _description.text,
      createdAt: widget.note!.createdAt,
    );
    await NoteRepository.update(note: note);
    if (!mounted) return;
    Navigator.pop(context);
  }

  // ข้อ 34: ลบโน้ต
  Future<void> _deleteNote() async {
    await NoteRepository.delete(note: widget.note!);
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Note",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orangeAccent.shade200,
        actions: [
          // ข้อ 34: ปุ่มลบ แสดงเฉพาะตอนแก้ไข (มีข้อมูลอยู่แล้ว)
          widget.note != null
              ? IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: const Text("คุณต้องการจะลบข้อมูลใช่หรือไม่"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _deleteNote();
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: (const Icon(Icons.delete_outline)),
                )
              : const SizedBox(),
          // ข้อ 19, 33: ปุ่ม Done (ไม่มีข้อมูลเดิม = เพิ่มใหม่, มี = อัปเดต)
          IconButton(
            onPressed: widget.note == null ? _insertNote : _updateNote,
            icon: const Icon(Icons.done_outline_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: _title,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: TextField(
                controller: _description,
                decoration: InputDecoration(
                  hintText: "Start typing here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}