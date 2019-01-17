# Relógio-Despertador do Michel
Um relógio microcontrolado baseado no PIC16F628A

  Este projeto foi feito numa das disciplinas do curso de engenharia eletrônica da ufjf, o código e layout são de minha autoria. Comigo estavam Jhonatan e Alessandra. O grande desafio é lidar com a falta de memória, por isso a obrigação de se usar este microcontrolador, que conta com incríveis 2k de memória de programa e não tem i2c nativo para comunicar com o rtc, obrigando a importar uma biblioteca relativamente grande.

  Como diferencial nesse projeto, está o ajuste por cursor, o dia da semana na tela e a possibilidade de programar múltiplos alarmes independentes. O uso de memória foi mantido sob controle, em 92%, após significativo trabalho de otimização de código.
  
  O repositório contém os arquivos de projeto do MicroC e do proteus 8, onde pode ser simulado. O código está no arquivo MyProject.c, para abrir o projeto use o arquivo MyProject.mcppi, para abrir no proteus o arquivo é New michel expand.pdsprj.

  Para quem for usar este projeto como fonte de consulta, atente-se para um pequeno erro de design: O lcd tá de cabeça pra baixo hehe. Michel nem reclamou, só riu da gente. Acontece nas melhores famílias...
