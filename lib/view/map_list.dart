void main() {
 Map map1={"name": "Manish", "age":25, "Mob":8210710217  };
  
  List<dynamic> list1=[];
  List<dynamic> list2=[];
  
  map1.entries.forEach((elements)=> print("${elements.key}---${elements.value}") );
  print(map1);
  map1["Gender"]="Male";
  map1["Married"]=true;
  print(map1);
  map1.remove("age");
  print(map1);
  map1.removeWhere((key, value) => value == true || key == 'married');
  map1.update("Mob", (value) => value + 10);
  list1=map1.values.toList();
  list2=map1.keys.toList();
  print(map1);
  print(list1);
  print(list2);
  for(var value in list1 ){
    print(value);
  }
   for(var value in map1.keys ){
    print(value);
  }
//   list1.where(list1[index]="Male");
}
