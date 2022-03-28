# Estacionai

Aplicativo de gerenciamento de um estacionamento feito em Flutter!

## Desafio Proposto

Seu João tem um estacionamento e hoje tem um caderno onde anota todas as entradas e saídas, assim como preenche qual vaga o caminhão ocupa cada vez que acontece uma entrada ou saída.

Agora o Sr. João quer poder fazer isso na palma de sua mão com seu Smartphone. Com seu app, ele quer ver quais vagas estão ou não ocupadas, assim como registrar entradas e saídas dos veículos e qual vaga estes veículos estão ocupando! Ele também queria ter um histórico dessas entradas e saídas para poder fazer o fechamento no final do dia.

João é um administrador mais velho, então uma interface fácil de utilizar é mais vantajosa que uma interface muito complexa.

## O aplicativo desenvolvido

-Pensando em uma solução simples e objetiva, foi desenvolvido um aplicativo inicialmente contendo uma única tela, onde
é possível o Sr. João acessar as vagas disponíveis e o histórico das mesmas facilmente. As vagas númeradas possuem coloração
verde quando disponíveis e vermelha quando ocupadas.
Quando clicado em uma vaga ocupada é apresentado um alerta pedindo confirmação da saída do veículo, e quando clicado sobre
uma vaga livre é apresentado um alerta para preenchimento de informações como nome, placa do veículo e telefone de contato, assim
como botões de confirmar e cancelar.
Os botões de "Ver Mais" presentes nas Vagas e no Histórico ainda não estão funcionais, mas possuem o objetivo de detalhar
a visualização e mostrar as demais Vagas/Registros de Histórico caso existam. Como o objetivo é fazer algo simples para
demonstrar tecnologias e funcionalidade não foram implementadas tais telas.

- Persistência dos dados / Banco de Dados:  Foi utilizada a tecnologia Cloud Firestore do Firebase, que possui funcionalidade
com ou sem rede de internet disponível.

- Gerênciamento de Estado: Provider

- Testes unitários: O Firestore é bem limitado para a realização de testes unitários e seria necessário a utilização de Mock
ou Fake Firestore, e portanto utilizei algumas listas locais de Vagas e Histórico para alguns testes simples. Testes de obtenção de dados
  não foram realizados devido à esta limitação.
