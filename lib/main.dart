import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Modificado para usar super.key

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TaskManager(),
    );
  }
}

class TaskManager extends StatefulWidget {
  const TaskManager({super.key}); // Modificado para usar super.key

  @override
  TaskManagerState createState() => TaskManagerState(); // Alterado para usar a classe pública
}

// Tornando a classe TaskManagerState pública
class TaskManagerState extends State<TaskManager> {
  List<Map<String, dynamic>> tasks = []; // Lista de tarefas

  final TextEditingController taskController = TextEditingController();

  void addTask(String task) {
    setState(() {
      tasks.insert(0, {"title": task, "isChecked": false});
    });
    taskController.clear(); // Limpar o campo de texto após adicionar a tarefa
  }

  void toggleCheckbox(int index) {
    setState(() {
      tasks[index]["isChecked"] = !tasks[index]["isChecked"];
      if (tasks[index]["isChecked"]) {
        // Se a tarefa for marcada, mova-a para o final da lista
        tasks.add(tasks.removeAt(index));
      } else {
        // Se a tarefa for desmarcada, mova-a para o início da lista
        tasks.insert(0, tasks.removeAt(index));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue, // Cor azul claro
        title: const Text(
          "To do List",
          style: TextStyle(color: Colors.white), // Texto branco
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: taskController,
                  decoration: const InputDecoration(
                    labelText: "Tarefa",
                    border: OutlineInputBorder(), // Adiciona borda retangular
                  ),
                ),
                const SizedBox(height: 8), // Espaçamento entre o campo de texto e o botão
                SizedBox(
                  width: double.infinity, // Expande o botão para a largura total
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue, // Fundo azul claro
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Formato retangular
                      ),
                    ),
                    onPressed: () {
                      if (taskController.text.isNotEmpty) {
                        addTask(taskController.text);
                      }
                    },
                    child: const Text(
                      "Cadastrar",
                      style: TextStyle(color: Colors.white), // Texto branco
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(
                    tasks[index]["title"],
                    style: TextStyle(
                      decoration: tasks[index]["isChecked"]
                          ? TextDecoration.lineThrough // Riscado se estiver marcado
                          : TextDecoration.none,
                    ),
                  ),
                  value: tasks[index]["isChecked"],
                  onChanged: (value) {
                    toggleCheckbox(index);
                  },
                  activeColor: Colors.green, // Caixa de seleção verde quando marcada
                  checkColor: Colors.black, // Sinal de marcação preto
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}