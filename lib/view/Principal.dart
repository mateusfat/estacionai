import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionai/model/Estacionamento.dart';
import 'package:estacionai/model/Historico.dart';
import 'package:estacionai/model/Vaga.dart';
import 'package:estacionai/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  late Estacionamento oEstacionamento;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      oEstacionamento.retornaVagas();
      oEstacionamento.retornaHistorico();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    oEstacionamento = Provider.of<Estacionamento>(context);
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: CustomScrollView(
          slivers: [
            appBarPrincipal(),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            //border: Border.all(color: Colors.grey,),
                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    "VAGAS",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                                  ),
                                  Text("Ver Mais", style: TextStyle(fontSize: 14, color: Colors.black54)),
                                ],
                              ),
                              GridView.builder(
                                itemCount: oEstacionamento.listaVagas.length,
                                shrinkWrap: true,
                                primary: false,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
                                itemBuilder: (BuildContext context, int index) {
                                  bool vagaOcupada = oEstacionamento.listaVagas[index].ocupada!;
                                  return GestureDetector(
                                    onTap: () {
                                      if (vagaOcupada) {
                                        registrarSaida(oEstacionamento.listaVagas[index]);
                                      } else {
                                        registrarEntrada(oEstacionamento.listaVagas[index]);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: vagaOcupada ? Colors.red : Colors.green,
                                          ),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                                      child: Center(
                                          child: Text(
                                        oEstacionamento.listaVagas[index].cod.toString(),
                                        style: TextStyle(color: vagaOcupada ? Colors.red : Colors.green),
                                      )),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.black38, thickness: 2),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            //border: Border.all(color: Colors.grey,),
                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    "HISTÓRICO",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                                  ),
                                  Text("Ver Mais", style: TextStyle(fontSize: 14, color: Colors.black54)),
                                ],
                              ),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: oEstacionamento.listaHistorico.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        title: Text(
                                          "Vaga ${oEstacionamento.listaHistorico[index].vaga} - "
                                          "${oEstacionamento.listaHistorico[index].nome} - "
                                          "Placa ${oEstacionamento.listaHistorico[index].veiculo}",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Telefone: ${oEstacionamento.listaHistorico[index].telefone}"),
                                            Text(
                                                "Entrada: ${formataData.format(oEstacionamento.listaHistorico[index].dtentrada!.toDate())}"),
                                            if (oEstacionamento.listaHistorico[index].dtsaida != null)
                                              Text("Saída: ${formataData.format(oEstacionamento.listaHistorico[index].dtsaida!.toDate())}"),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: 1,
            )),
          ],
        ),
      ),
    );
  }

  appBarPrincipal() {
    return SliverAppBar(
      expandedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: const Text("Bem vindo João", style: TextStyle(color: Colors.white, fontSize: 20)),
        expandedTitleScale: 1,
        background: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.orange, Colors.red], begin: Alignment.bottomRight, end: Alignment.topLeft)),
        ),
      ),
    );
  }

  registrarEntrada(Vaga vaga) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController controladorNome = TextEditingController();
    TextEditingController controladorVeiculo = TextEditingController();
    TextEditingController controladorTelefone = TextEditingController();
    formulario() {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controladorNome,
              decoration: const InputDecoration(
                hintText: "Nome",
              ),
              maxLines: 1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Preenchimento obrigatório';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controladorVeiculo,
              decoration: const InputDecoration(
                hintText: "Placa do Veículo",
              ),
              maxLines: 1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Preenchimento obrigatório';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controladorTelefone,
              decoration: const InputDecoration(
                hintText: "Telefone",
              ),
              maxLines: 1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Preenchimento obrigatório';
                }
                return null;
              },
            ),
          ],
        ),
      );
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Atenção"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Para efetuar a entrada do veículo é necessário preencher as informações abaixo:"),
              formulario(),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                fechaAlerta(context);
              },
            ),
            TextButton(
              child: Text("Confirmar"),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  DateTime dataAtual = DateTime.now();
                  int id = (controladorVeiculo.text + vaga.cod.toString() + dataAtual.toString()).hashCode;
                  Historico oHistoricoIncluir = Historico(
                    veiculo: controladorVeiculo.text,
                    vaga: vaga.cod,
                    telefone: controladorTelefone.text,
                    dtentrada: Timestamp.fromDate(dataAtual),
                    nome: controladorNome.text,
                    id: id.toString(),
                  );
                  await oEstacionamento.ocupaVaga(vaga: vaga, historico: oHistoricoIncluir);
                  fechaAlerta(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  registrarSaida(Vaga vaga) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Atenção"),
          content: Text("Deseja confirmar a saída do veículo da vaga ${vaga.cod} ?"),
          actions: [
            TextButton(
              child: const Text("Não"),
              onPressed: () {
                fechaAlerta(context);
              },
            ),
            TextButton(
              child: const Text("Sim"),
              onPressed: () async {
                await oEstacionamento.desocupaVaga(vaga: vaga);
                fechaAlerta(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    oEstacionamento.removeListener(() {});
    super.dispose();
  }
}
