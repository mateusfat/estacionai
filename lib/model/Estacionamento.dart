import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionai/model/Historico.dart';
import 'package:estacionai/model/Vaga.dart';
import 'package:estacionai/view_model/Historico_CRUD.dart';
import 'package:estacionai/view_model/Vagas_CRUD.dart';
import 'package:flutter/cupertino.dart';

class Estacionamento extends ChangeNotifier{
  List<Vaga> listaVagas = [];
  List<Historico> listaHistorico = [];
  bool bCarregandoVagas = false;
  bool bCarregandoHistorico = false;

  final oVagas = VagasCRUD();
  final oHistorico = HistoricoCRUD();


  ocupaVaga({required Vaga vaga, required Historico historico}) async {
    await oHistorico.adicionarHistorico(historico);
    await oVagas.atualizarVaga(Vaga(id: vaga.id,ocupada: true,cod: vaga.cod));
    listaVagas.firstWhere((element) => element.id == vaga.id).ocupada = true;
    listaHistorico.add(historico);
    listaHistorico.sort((a, b) => b.dtentrada!.compareTo(a.dtentrada!));
    notifyListeners();
  }

  desocupaVaga({required Vaga vaga}) async {
    await oHistorico.buscarUmHistorico(codVaga: vaga.cod!).then((oHist) async {
      if(oHist != null){
        Timestamp DataSaida = Timestamp.fromDate(DateTime.now());
        await oHistorico.atualizarHistorico((Historico(
          nome: oHist.nome,
          dtentrada: oHist.dtentrada,
          dtsaida: DataSaida,
          telefone: oHist.telefone,
          vaga: oHist.vaga,
          veiculo: oHist.veiculo,
          id: oHist.id
        )));
        listaHistorico.firstWhere((element) => element.id == oHist.id).dtsaida = DataSaida;
      }
    });
    await oVagas.atualizarVaga(Vaga(id: vaga.id,cod: vaga.cod,ocupada: false));
    listaVagas.firstWhere((element) => element.id == vaga.id).ocupada = false;
    notifyListeners();
  }

  Future retornaVagas() async {
    bCarregandoVagas = true;
    notifyListeners();
    listaVagas = await oVagas.retornarVagas();
    bCarregandoVagas = false;
    notifyListeners();
  }

  retornaHistorico() async {
    bCarregandoHistorico = true;
    notifyListeners();
    listaHistorico = await oHistorico.retornarHistorico();
    bCarregandoHistorico = false;
    notifyListeners();
  }


}