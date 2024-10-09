

class TaskModel{
  String? name;
  String? tag;
  String? desc;
  String? date;
  String? priority;
  int? priorityIndex;

  TaskModel({
    required this.tag,
    required this.date,
    required this.priority,
    required this.name,
    required this.desc,
    required this.priorityIndex
});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['name'] = name;
    map['tag'] = tag;
    map['desc'] = desc;
    map['date'] = date;
    map['priority'] = priority;
    map['priorityIndex'] = priorityIndex;

    return map;
  }


  TaskModel.fromMapObject(Map<String, dynamic> map) {
    name = map['name'];
    tag = map['tag'];
    desc = map['desc'];
    date = map['date'];
    priority = map['priority'];
    priorityIndex = map['priorityIndex'];
  }
}