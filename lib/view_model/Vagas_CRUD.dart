import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionai/model/Vaga.dart';

class VagasCRUD {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  adicionarVaga(Vaga vaga) async {
    await _db.collection("vagas").add(vaga.toJson());
  }

  atualizarVaga(Vaga vaga) async {
    await _db.collection("vagas").doc(vaga.id).update(vaga.toJson());
  }

  Future<void> apagarVaga(String idVaga) async {
    await _db.collection("vagas").doc(idVaga).delete();
  }

  Future<List<Vaga>> retornarVagas() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection("vagas").orderBy('cod').get();
    return snapshot.docs.map((docSnapshot) => Vaga.fromJson(docSnapshot.data())).toList();
  }

}
