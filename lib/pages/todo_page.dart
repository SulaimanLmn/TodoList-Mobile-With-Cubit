import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/assets/color.dart';
import 'package:flutter_bloc_test/bloc/todo_bloc.dart';
import 'package:flutter_bloc_test/models/todo_model.dart';
import 'package:flutter_bloc_test/pages/add_task_page.dart';
import 'package:flutter_bloc_test/pages/edit_task_page.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "TODO APP",
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        ),
        backgroundColor: appBarColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 15),
        width: double.infinity,
        child: BlocBuilder<TodoBloc, List<TodoModel>>(
          builder: (context, todos) {
            final nonCompletedTodos =
                BlocProvider.of<TodoBloc>(context).getNonCompleteTodos();
            return ListView.separated(
                itemBuilder: (context, index) {
                  final originalIndex = todos.indexOf(nonCompletedTodos[index]);

                  return Container(
                    width: double.infinity,
                    height: 82,
                    decoration: BoxDecoration(
                      color: textColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 0.5,
                            spreadRadius: 0.5,
                            offset: const Offset(0, 3)),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nonCompletedTodos[index].title,
                                style: TextStyle(color: todoTitleColor),
                              ),
                              const Spacer(),
                              Text(nonCompletedTodos[index].subList)
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 25,
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EditTaskPage(
                                          todo: nonCompletedTodos[index],
                                          index: originalIndex,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: iconColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Delete Task"),
                                        content: const Text(
                                          "Are you sure you want to delete this task?",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              BlocProvider.of<TodoBloc>(context)
                                                  .add(TodoDeleted(
                                                      index: originalIndex));

                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                  color: confirmButtonColor,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: cancelButtonColor,
                                                  fontSize: 17),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: iconColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Complete Task"),
                                        content: const Text(
                                          "Are you sure you want to mark this task as complete?",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              BlocProvider.of<TodoBloc>(context)
                                                  .add(TodoCompleted(
                                                      index: originalIndex));

                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                  color: confirmButtonColor,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: cancelButtonColor,
                                                  fontSize: 17),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.check_box_outlined,
                                    color: iconColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemCount: nonCompletedTodos.length);
          },
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddTaskPage(),
              ),
            );
          },
          shape: const CircleBorder(),
          elevation: 3,
          backgroundColor: appBarColor,
          child: Icon(
            Icons.add,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
