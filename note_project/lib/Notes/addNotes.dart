import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Addnotes extends StatefulWidget {
  const Addnotes({super.key});

  @override
  State<Addnotes> createState() => _AddnotesState();
}

class _AddnotesState extends State<Addnotes> {
  // Controllers cho các TextField
  TextEditingController dateController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  //cursor
  final FocusNode _focusTittle = FocusNode();
  final FocusNode _focusContent = FocusNode();
  final FocusNode _focusDate = FocusNode();
  final FocusNode _focusStartTime = FocusNode();
  final FocusNode _focusEndTime = FocusNode();
  final FocusNode _focusAddress = FocusNode();

  String? selectedModerator;
  String taskStatus = 'Tạo mới';
  List<String> moderators = ['Thanh Ngân', 'Hữu Nghĩa'];
  List<String> statusList = ['Tạo mới', 'Thực hiện', 'Thành công', 'Kết thúc'];

  // Hàm hiển thị DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(9999),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromRGBO(
                67, 121, 242, 1), // Màu tiêu đề và viền ngày được chọn
            colorScheme: const ColorScheme.light(
              primary:
                  Color.fromRGBO(67, 121, 242, 1), // Màu nền của ngày được chọn
              onPrimary: Colors.white, // Màu chữ trên nền ngày được chọn
              onSurface: Colors.black, // Màu chữ của các ngày
            ),
            dialogBackgroundColor: Colors.white, // Màu nền của DatePicker
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color.fromRGBO(
                    67, 121, 242, 1), // Màu của nút "OK" và "CANCEL"
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        dateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  // Hàm chọn thời gian
  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Chọn thời gian',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromRGBO(67, 121, 242, 1), // Màu chủ đạo
              onPrimary: Colors.white, // Màu chữ trên nút chủ đạo
              onSurface: Colors.black, // Màu chữ trên nền
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        final now = DateTime.now();
        final selectedTime =
            DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
        final formattedTime = DateFormat('HH:mm').format(selectedTime);
        controller.text = formattedTime;
      });
    }
  }

  //convert date time
  String _convertDateFormat(String date) {
    try {
      // Chuyển đổi từ định dạng `dd/MM/yyyy` sang `DateTime`
      DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);

      // Sau đó chuyển sang định dạng `yyyy-MM-dd`
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      print('Lỗi định dạng ngày: $e');
      return date;
    }
  }

  //Lưu vào Shared Preference
  Future<void> _saveTaskData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Tạo một chuỗi JSON để lưu trữ nhiều nhiệm vụ
    List<String>? existingTasks = prefs.getStringList('tasks');
    List<String> updatedTasks = existingTasks ?? [];

    Map<String, String> task = {
      'title': contentController.text,
      'content': noteController.text,
      'date': _convertDateFormat(dateController.text),
      'startTime': startTimeController.text,
      'endTime': endTimeController.text,
      'location': locationController.text,
      'moderator': selectedModerator ?? '',
    };
    updatedTasks.add(jsonEncode(task)); // Thêm nhiệm vụ mới vào danh sách
    await prefs.setStringList('tasks', updatedTasks); // Lưu trữ lại danh sách

    print(task);
  }

  //Xóa dữ liệu khỏi Shared Preference
  Future<void> clearSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _focusTittle.dispose();
    _focusContent.dispose();
    _focusDate.dispose();
    _focusStartTime.dispose();
    _focusEndTime.dispose();
    _focusAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(children: [
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                        size: 25,
                        Icons.arrow_back,
                        color: Color.fromRGBO(67, 121, 242, 1))),
                const SizedBox(width: 295),
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: const NetworkImage(
                        "https://i.ytimg.com/vi/bD-VM10PWdw/maxresdefault.jpg"),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color.fromRGBO(67, 121, 242, 1),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: contentController,
                focusNode: _focusTittle,
                cursorColor: Color.fromRGBO(67, 121, 242, 1),
                decoration: const InputDecoration(
                  labelText: 'Tittle',
                  labelStyle: TextStyle(color: Colors.black),
                  floatingLabelStyle:
                      TextStyle(color: Color.fromRGBO(67, 121, 242, 1)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(67, 121, 242, 1)),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              SizedBox(height: 16.0),

              TextField(
                controller: noteController,
                focusNode: _focusContent,
                cursorColor: Color.fromRGBO(67, 121, 242, 1),
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  labelStyle: TextStyle(color: Colors.black),
                  floatingLabelStyle:
                      TextStyle(color: Color.fromRGBO(67, 121, 242, 1)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(67, 121, 242, 1)),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              SizedBox(height: 16.0),

              TextField(
                controller: dateController,
                focusNode: _focusDate,
                cursorColor: Color.fromRGBO(67, 121, 242, 1),
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  suffixIcon: Icon(Icons.calendar_today),
                  labelStyle: TextStyle(color: Colors.black),
                  floatingLabelStyle:
                      TextStyle(color: Color.fromRGBO(67, 121, 242, 1)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(67, 121, 242, 1)),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onTap: () => _selectDate(context),
              ),
              SizedBox(height: 16.0),

              TextField(
                controller: startTimeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Pickup Time Start',
                  labelStyle: const TextStyle(color: Colors.black),
                  floatingLabelStyle:
                      const TextStyle(color: Color.fromRGBO(67, 121, 242, 1)),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(67, 121, 242, 1)),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () {
                      _selectTime(context, startTimeController);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // TextField cho Pickup Time End
              TextField(
                controller: endTimeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Pickup Time End',
                  labelStyle: TextStyle(color: Colors.black),
                  floatingLabelStyle:
                      TextStyle(color: Color.fromRGBO(67, 121, 242, 1)),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(67, 121, 242, 1)),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () {
                      _selectTime(context, endTimeController);
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.0),

              // Trường Địa Điểm
              TextField(
                controller: locationController,
                focusNode: _focusAddress,
                cursorColor: Color.fromRGBO(67, 121, 242, 1),
                decoration: const InputDecoration(
                  labelText: 'Address',
                  labelStyle: TextStyle(color: Colors.black),
                  floatingLabelStyle:
                      TextStyle(color: Color.fromRGBO(67, 121, 242, 1)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(67, 121, 242, 1)),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              SizedBox(height: 16.0),

              // Dropdown Chủ Trì
              DropdownButtonFormField<String>(
                value: selectedModerator,
                decoration: const InputDecoration(
                  labelText: 'Chủ trì',
                  labelStyle: TextStyle(color: Colors.black),
                  floatingLabelStyle:
                      TextStyle(color: Color.fromRGBO(67, 121, 242, 1)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(67, 121, 242, 1)),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                items: moderators.map((String moderator) {
                  return DropdownMenuItem<String>(
                    value: moderator,
                    child: Text(moderator),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedModerator = newValue;
                  });
                },
                isExpanded: true,
              ),
              SizedBox(height: 16.0),

              // Button Tạo Công Việc
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      _saveTaskData();
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(67, 121, 242, 1)),
                      child: const Center(
                        child: Text(
                          "Create task",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
