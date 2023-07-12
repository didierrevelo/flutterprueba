import 'package:flutter/material.dart';

import '../blocs/bloc.exports.dart';
import '../models/task.model.dart';
import '../services/guid_gen.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        const Text(
          'Agregar Tarea',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: TextField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
              icon: Icon(Icons.title),
              label: Text('Titulo'),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: TextField(
            autofocus: true,
            controller: descriptionController,
            minLines: 1,
            maxLines: 5,
            decoration: const InputDecoration(
              icon: Icon(Icons.description_rounded),
              label: Text('Descripcion'),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: TextFormField(
            // autofocus: true,
            controller: dateController,
            minLines: 1,
            maxLines: 5,
            decoration: const InputDecoration(
              icon: Icon(Icons.calendar_month_rounded),
              label: Text('Fecha limite'),
              border: OutlineInputBorder(),
            ),
            onTap: () async {
              DateTime? pickerDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2101));

              if (pickerDate != null) {
                  dateController.text = DateFormat('yyyy-MM-dd').format(pickerDate);
              }
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                var task = TaskModel(
                  title: titleController.text,
                  description: descriptionController.text,
                  date: dateController.text,
                  date2: DateFormat().add_yMMMd().add_Hms().format(
                            DateTime.parse(DateTime.now().toString())),
                  id: GUIDGen.generate(),
                );
                context.read<TasksBlocBloc>().add(
                      AddTask(taskModel: task),
                    );
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ]),
    );
  }
  
}
