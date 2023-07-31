import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/features/home/presentation/view_model/Todo.dart';


CollectionReference<Todo> getTodoCollectionRef(){
  CollectionReference<Todo> todosCollection = FirebaseFirestore.instance.collection('todos').withConverter<Todo>(
      fromFirestore: (snapshot,_)=>Todo.fromJson(snapshot.data()!)
      , toFirestore: (todo,_)=>todo.toJson(),
  );
  return todosCollection;
}
Future<void>addTaskToFirestore(Todo todo)async {

  CollectionReference<Todo> todosRef= getTodoCollectionRef();
  var todoDocument= todosRef.doc();
  todo.id=todoDocument.id;
  todoDocument.set(todo);
}
Stream<QuerySnapshot<Todo>> getTasks(int dateTimeInMillis) {
  return getTodoCollectionRef().where('dateTime', isEqualTo: dateTimeInMillis)
      .snapshots();
}
Future<void> deleteTodo(Todo todo ){
  return getTodoCollectionRef()
      .doc(todo.id)
      .delete();

}
 editIsDone(Todo todo){
  CollectionReference todoRef=getTodoCollectionRef();
     todoRef.doc(todo.id).update({'isDone': todo.isDone ? false : true});
}