// ข้อ 22-23, 26: โมเดลของโน้ต
class Note {
  int? id; // คีย์หลัก ฐานข้อมูลสร้างให้อัตโนมัติ จึงเป็น null ได้
  String title, description;
  DateTime createdAt;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  // แปลง Object เป็น Map เพื่อบันทึกลงตาราง (ไม่ใส่ id เพราะฐานข้อมูลสร้างเอง)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'createdAt': createdAt.toString(),
    };
  }
}