class Event {
  List<Eventdata>? eventdata;
  String? start;
  String? end;
  String? create;
  String? version;
  String? link;

  Event(
      {this.eventdata,
      this.start,
      this.end,
      this.create,
      this.version,
      this.link});

  Event.fromJson(Map<String, dynamic> json) {
    if (json['eventdata'] != null) {
      eventdata = <Eventdata>[];
      json['eventdata'].forEach((v) {
        eventdata!.add(Eventdata.fromJson(v));
      });
    }
    start = json['start'];
    end = json['end'];
    create = json['create'];
    version = json['version'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eventdata != null) {
      data['eventdata'] = eventdata!.map((v) => v.toJson()).toList();
    }
    data['start'] = start;
    data['end'] = end;
    data['create'] = create;
    data['version'] = version;
    data['link'] = link;
    return data;
  }
}

class Eventdata {
  String? local;
  String? description;
  String? title;
  String? image;

  Eventdata({this.local, this.description, this.title, this.image});

  Eventdata.fromJson(Map<String, dynamic> json) {
    local = json['local'];
    description = json['description'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['local'] = local;
    data['description'] = description;
    data['title'] = title;
    data['image'] = image;
    return data;
  }
}
