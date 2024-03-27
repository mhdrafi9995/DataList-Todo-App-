

class DataModel {
  String name;
  String age;
  String gender;
  DataModel({required this.name, required this.age, required this.gender});
   factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        name: json["name"],
        age: json["age"], gender: '',
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "gender": gender
    };

  
  
}

