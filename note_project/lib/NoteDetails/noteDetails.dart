import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Notedetails extends StatefulWidget {
  final Map<String, String> task; // Nhiệm vụ được truyền vào từ màn hình chính
  final Function(Map<String, String>)
      onTaskUpdated; // Hàm callback để cập nhật nhiệm vụ

  const Notedetails({Key? key, required this.task, required this.onTaskUpdated})
      : super(key: key);

  @override
  _NoteDetailsState createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<Notedetails> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  late TextEditingController dateController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late TextEditingController locationController;
  late TextEditingController moderatorController;

  @override
  void initState() {
    super.initState();
    // Khởi tạo các controller với dữ liệu từ task
    titleController = TextEditingController(text: widget.task['title']);
    contentController = TextEditingController(text: widget.task['content']);
    dateController = TextEditingController(text: widget.task['date']);
    startTimeController = TextEditingController(text: widget.task['startTime']);
    endTimeController = TextEditingController(text: widget.task['endTime']);
    locationController = TextEditingController(text: widget.task['location']);
    moderatorController = TextEditingController(text: widget.task['moderator']);
  }

  @override
  void dispose() {
    // Giải phóng các controller khi không sử dụng
    titleController.dispose();
    contentController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    locationController.dispose();
    moderatorController.dispose();
    super.dispose();
  }

  // Hàm để lưu lại nhiệm vụ đã chỉnh sửa vào SharedPreferences
  Future<void> _saveTask() async {
    // Cập nhật lại nhiệm vụ với thông tin từ các controller
    Map<String, String> updatedTask = {
      'title': titleController.text,
      'content': contentController.text,
      'date': dateController.text,
      'startTime': startTimeController.text,
      'endTime': endTimeController.text,
      'location': locationController.text,
      'moderator': moderatorController.text,
    };

    // Lưu lại nhiệm vụ đã chỉnh sửa vào SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingTasks = prefs.getStringList('tasks');

    if (existingTasks != null) {
      // Tìm vị trí nhiệm vụ cần cập nhật
      int index = existingTasks.indexWhere((task) {
        Map<String, dynamic> taskData = jsonDecode(task);
        return taskData['date'] == widget.task['date'] &&
            taskData['title'] ==
                widget.task['title']; // So sánh dựa trên ngày và tiêu đề
      });

      if (index != -1) {
        existingTasks[index] =
            jsonEncode(updatedTask); // Cập nhật nhiệm vụ đã chỉnh sửa
        await prefs.setStringList('tasks', existingTasks); // Lưu lại danh sách
      }
    }

    widget.onTaskUpdated(
        updatedTask); // Gọi callback để cập nhật dữ liệu trên màn hình chính
    Navigator.pop(context); // Quay lại màn hình trước đó
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              cursorColor: const Color.fromRGBO(67, 121, 242, 1),
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(
                        67, 121, 242, 1), // Màu underline khi focus
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey), // Màu underline khi không focus
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(
                        67, 121, 242, 1), // Màu underline khi focus và có lỗi
                  ),
                ),
              ),
              onSubmitted: (_) => _saveTask(), // Lưu lại khi nhấn Enter
            ),
            TextField(
              controller: contentController,
              cursorColor: const Color.fromRGBO(67, 121, 242, 1),
              decoration: const InputDecoration(
                labelText: 'Content',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(
                        67, 121, 242, 1), // Màu underline khi focus
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey), // Màu underline khi không focus
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(
                        67, 121, 242, 1), // Màu underline khi focus và có lỗi
                  ),
                ),
              ),
              onSubmitted: (_) => _saveTask(),
            ),
            TextField(
              controller: dateController,
              cursorColor: const Color.fromRGBO(67, 121, 242, 1),
              decoration: const InputDecoration(
                labelText: 'Date',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(
                        67, 121, 242, 1), // Màu underline khi focus
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey), // Màu underline khi không focus
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(
                        67, 121, 242, 1), // Màu underline khi focus và có lỗi
                  ),
                ),
              ),
              onSubmitted: (_) => _saveTask(),
            ),
            TextField(
              controller: startTimeController,
              cursorColor: const Color.fromRGBO(67, 121, 242, 1),
              decoration: const InputDecoration(
                labelText: 'Start Time',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(
                        67, 121, 242, 1), // Màu underline khi focus
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey), // Màu underline khi không focus
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(
                        67, 121, 242, 1), // Màu underline khi focus và có lỗi
                  ),
                ),
              ),
              onSubmitted: (_) => _saveTask(),
            ),
            TextField(
              controller: endTimeController,
              cursorColor: const Color.fromRGBO(67, 121, 242, 1),
              decoration: const InputDecoration(
                labelText: 'End Time',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(
                        67, 121, 242, 1), // Màu underline khi focus
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey), // Màu underline khi không focus
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(
                        67, 121, 242, 1), // Màu underline khi focus và có lỗi
                  ),
                ),
              ),
              onSubmitted: (_) => _saveTask(),
            ),
            TextField(
              controller: locationController,
              cursorColor: const Color.fromRGBO(67, 121, 242, 1),
              decoration: const InputDecoration(
                labelText: 'Location',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(
                        67, 121, 242, 1), // Màu underline khi focus
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey), // Màu underline khi không focus
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(
                        67, 121, 242, 1), // Màu underline khi focus và có lỗi
                  ),
                ),
              ),
              onSubmitted: (_) => _saveTask(),
            ),
            TextField(
              controller: moderatorController,
              cursorColor: const Color.fromRGBO(67, 121, 242, 1),
              decoration: const InputDecoration(
                labelText: 'Moderator',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(
                        67, 121, 242, 1), // Màu underline khi focus
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey), // Màu underline khi không focus
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(
                        67, 121, 242, 1), // Màu underline khi focus và có lỗi
                  ),
                ),
              ),
              onSubmitted: (_) => _saveTask(),
            ),
          ],
        ),
      ),
    );
  }
}
