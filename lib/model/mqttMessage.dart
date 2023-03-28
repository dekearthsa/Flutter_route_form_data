class Cat {
  String name;
  String color;
  Cat({required this.name, required this.color});
  factory Cat.fromJson(Map<String, dynamic> json) {
 
    return Cat(name:json['name'] , color:  json['color']);

  }
}