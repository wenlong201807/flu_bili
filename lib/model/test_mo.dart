// 对应文件数据 docs/mock.json
class Autogenerated {
  String? test;
  String? desc;
  String? id;
  String? vid;
  String? title;
  String? tName;
  String? url;

  Autogenerated(
      {this.test,
        this.desc,
        this.id,
        this.vid,
        this.title,
        this.tName,
        this.url});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    test = json['test'];
    desc = json['desc'];
    id = json['id'];
    vid = json['vid'];
    title = json['title'];
    tName = json['tName'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['test'] = this.test;
    data['desc'] = this.desc;
    data['id'] = this.id;
    data['vid'] = this.vid;
    data['title'] = this.title;
    data['tName'] = this.tName;
    data['url'] = this.url;
    return data;
  }
}
