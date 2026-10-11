import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/note.dart';
import '../../add_note/add_note_screen.dart';

// ข้อ 7, 9-15, 31, 33: แถวแสดงโน้ตแต่ละรายการ
class ItemNote extends StatelessWidget {
  final Note note;
  const ItemNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    // ข้อ 33: แตะที่แถวเพื่อเปิดหน้าแก้ไข
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddNoteScreen(
              note: note,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            // กล่องสีแดงแสดงเดือน/วัน/ปี
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
              child: Column(
                children: [
                  Text(
                    DateFormat(DateFormat.ABBR_MONTH).format(note.createdAt),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    DateFormat(DateFormat.DAY).format(note.createdAt),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    note.createdAt.year.toString(),
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ข้อ 14: ครอบด้วย Expanded + maxLines + ellipsis กันข้อความล้น
                      Expanded(
                        child: Text(
                          note.title,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        DateFormat(DateFormat.HOUR_MINUTE)
                            .format(note.createdAt),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  // ข้อ 15: description แสดงไม่เกิน 3 บรรทัด
                  Text(
                    note.description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}