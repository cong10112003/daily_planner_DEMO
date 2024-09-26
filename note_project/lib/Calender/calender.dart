import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  late Map<DateTime, List<Map<String, String>>>
      _tasks; // Lưu trữ nhiệm vụ theo ngày
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = _selectedDay;
    _tasks = {};
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingTasks = prefs.getStringList('tasks');

    // Kiểm tra xem có nhiệm vụ nào hay không
    if (existingTasks == null || existingTasks.isEmpty) {
      print(
          "Không có nhiệm vụ nào được lưu trữ."); // Thông báo không có nhiệm vụ
      return; // Thoát ra nếu không có nhiệm vụ
    }

    // Nếu có nhiệm vụ, tiếp tục xử lý
    for (String task in existingTasks) {
      Map<String, dynamic> taskData = jsonDecode(task);
      DateTime date = DateTime.parse(
          taskData['date']); // Chuyển đổi chuỗi ngày thành DateTime
      DateTime pureDate =
          DateTime(date.year, date.month, date.day); // Chỉ lấy ngày

      // Chuyển đổi taskData từ Map<String, dynamic> sang Map<String, String>
      Map<String, String> taskStringData = {
        'title': taskData['title']?.toString() ?? '',
        'content': taskData['content']?.toString() ?? '',
        'date': taskData['date']?.toString() ?? '',
        'startTime': taskData['startTime']?.toString() ?? '',
        'endTime': taskData['endTime']?.toString() ?? '',
        'location': taskData['location']?.toString() ?? '',
        'moderator': taskData['moderator']?.toString() ?? '',
      };
      print(taskStringData);

      if (_tasks[pureDate] == null) {
        _tasks[pureDate] = [];
      }
      _tasks[pureDate]!
          .add(taskStringData); // Thêm nhiệm vụ vào danh sách nhiệm vụ của ngày
    }
    setState(() {}); // Cập nhật UI
  }

  List<Map<String, String>> _getTasksForSelectedDay(DateTime date) {
    // Dùng `DateTime` chỉ có ngày, không có thời gian
    DateTime pureDate = DateTime(date.year, date.month, date.day);

    return _tasks[pureDate] ?? []; // Lấy nhiệm vụ cho ngày đã chọn
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Calendar'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: (day) =>
                _getTasksForSelectedDay(day), //Hiển thị sự kiện trong lịch
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),
          Expanded(
            child: ListView(
              children: _getTasksForSelectedDay(_selectedDay).map((task) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Container(
                    height: 110,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromRGBO(67, 121, 242, 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            task['title'] ?? 'erro',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset("assets/image/clock.png")),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                task['date'] ?? 'erro',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                          Text(
                            task['content'] ?? 'erro',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
