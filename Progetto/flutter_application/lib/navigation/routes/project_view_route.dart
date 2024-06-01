import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application/commonElements/headings_title.dart';
import 'package:flutter_application/commonElements/tasks_checkbox_view.dart';
import 'package:flutter_application/data/project_list.dart';
import '../../commonElements/blurred_box.dart';
import 'package:flutter_application/classes/all.dart';

import '../../commonElements/carousel_item.dart';
import '../../data/database_helper.dart';
import 'edit_project_route.dart';

class ProjectRoute extends StatefulWidget {
  Project project;
  ProjectRoute(this.project);

  @override
  State<ProjectRoute> createState() => _ProjectRouteState();
}

class _ProjectRouteState extends State<ProjectRoute> {

  Future<List<Task>> _loadTasks() async {
    return await DatabaseHelper.instance.getTasksByProjectName(widget.project.name);
    
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 232, 232, 232), //255, 232
            Color.fromARGB(255, 0, 183, 255),
            Color.fromARGB(255, 0, 183, 255),
            Color.fromARGB(255, 255, 0, 115),
            Color.fromARGB(255, 255, 0, 115),
            Colors.yellow
          ],
          stops: [0.79, 0.79, 0.865, 0.865, 0.94, 0.94],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        )),
        child: Scaffold(
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            appBar: PreferredSize(
              
              preferredSize: Size(MediaQuery.of(context).size.width, 55),
              child: BlurredBox(
                              borderRadius: BorderRadius.zero,
                              sigma: 5,
                              child: AppBar(
                                actions: [
                                  IconButton(onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProjectScreen(
                                          project: widget.project,
                                        ))), icon: const Icon(Icons.settings))
                                ],
              foregroundColor: Colors.white,
              //titleTextStyle: TextStyle(color: Colors.white),
              backgroundColor: const Color.fromARGB(100, 0, 0, 0),
              title: Text(widget.project.name),
                              ),
                            ),
            ),
            body: SingleChildScrollView(child: 
            
            
            Container(
    margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: MediaQuery.of(context).orientation == Orientation.portrait
            ? 20
            : 100),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeadingTitle(titleText: "Descrizione"),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Expanded(
            child: Row(children: [
              Expanded(child: Text(widget.project.description))
            ]),
          ),
        ),
        Text('Attualmente al progetto sta lavorando il team "${widget.project.team}":'),
        CustomHeadingTitle(titleText: "Stato"),
        const Text('Puoi modificare lo stato del progetto (puoi archiviarlo, completarlo o anche eliminarlo se necessario), cliccando su uno dei seguenti pulsanti:'),
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
          ElevatedButton(onPressed: () async {
            DatabaseHelper.instance.updateStatus(widget.project.name, "Fallito"); widget.project.status = 'Fallito'; setState(() {});//

          }, child: const Row(children: [Icon(Icons.archive), SizedBox(width: 5), Text('Archivia come fallito')])),
          const SizedBox(width: 5),
          ElevatedButton(onPressed: () async {
            DatabaseHelper.instance.updateStatus(widget.project.name, "Sospeso"); widget.project.status = 'Sospeso'; setState(() {});
          }, child: const Row(children: [Icon(Icons.close), SizedBox(width: 5), Text('Sospendi')])),
          const SizedBox(width: 5),
          ElevatedButton(onPressed: () async {
            DatabaseHelper.instance.updateStatus(widget.project.name, "Completato"); widget.project.status = 'Completato'; setState(() {});
          }, child: const Row(children: [Icon(Icons.check_circle),  SizedBox(width: 5), Text('Archivia come completato')])),
          const SizedBox(width: 5),
          ElevatedButton(onPressed: () async {
            DatabaseHelper.instance.deleteProject(widget.project.name); Navigator.of(context).pop();
          }, child: const Row(children: [Icon(Icons.delete_forever), SizedBox(width: 5), Text('Elimina')])),

        ],
        
        )),
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [ const Text('Al momento il progetto risulta essere in stato '), statusCheck(widget.project) ]),
        CustomHeadingTitle(titleText: 'Task'),
        FutureBuilder(future: _loadTasks(), builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) { 
            if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return TasksCheckboxViewForHomepage(tasks: snapshot.data as List<Task>);
        }})
        
        
      
      ],
    ),
  ),
            
            
            
            
            
            )));
  }

  
}

  