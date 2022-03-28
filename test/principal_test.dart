import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionai/model/Historico.dart';
import 'package:estacionai/model/Vaga.dart';
import 'package:test/test.dart';

Future<void> main() async {

  /* Testando com listas locais, pois não é possível testar com o Cloud Firestore diretamente aqui sem utilizar um
  Mock ou Fake Firestore. */
  List<Vaga> listaVagas = [];
  List<Historico> listaHistorico = [];

  test('Deve adicionar um Historico na lista de históricos e seu length deve ser 1.', () async {
    listaHistorico.add(Historico(id: "teste", nome: "teste", dtentrada: Timestamp.now(),
      dtsaida: Timestamp.now(),telefone: "(11)1111-1111",vaga: 1,veiculo: "ABC-1234"));
     expect(listaHistorico.length, equals(1));
  });

  test('Deve adicionar uma Vaga na lista de vagas e seu length deve ser 1.', () async {
    listaVagas.add(Vaga(id: "teste",cod: 1,ocupada: true));
    expect(listaVagas.length, equals(1));
  });

  test('A vaga de código 1 deve estar ocupada.', () async {
    listaVagas.add(Vaga(id: "teste",cod: 1,ocupada: true));
    expect(listaVagas.first.ocupada, equals(true));
  });
}


