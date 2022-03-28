import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionai/model/Historico.dart';


class HistoricoCRUD{
final FirebaseFirestore _db = FirebaseFirestore.instance;


Future adicionarHistorico(Historico historico) async {
  await _db.collection("historico").doc(historico.id).set(historico.toJson());
}

Future atualizarHistorico(Historico historico) async {
  await _db.collection("historico").doc(historico.id).update(historico.toJson());
}

Future<void> apagarHistorico(String idHistorico) async {
  await _db.collection("historico").doc(idHistorico).delete();
}

Future<List<Historico>> retornarHistorico() async {
  QuerySnapshot<Map<String, dynamic>> snapshot =
  await _db.collection("historico").orderBy('dtentrada',descending: true).get();
  return snapshot.docs.map((docSnapshot) => Historico.fromJson(docSnapshot.data())).toList();
}

Future<Historico?> buscarUmHistorico({required int codVaga}) async {
  QuerySnapshot<Map<String, dynamic>> snapshot =
  await _db.collection("historico").where('vaga',isEqualTo: codVaga).orderBy('dtentrada').limit(1).get();
  if(snapshot.docs.isNotEmpty){
    return snapshot.docs.map((docSnapshot) => Historico.fromJson(docSnapshot.data())).toList().first;
  }
}


}