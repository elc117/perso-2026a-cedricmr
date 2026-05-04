# Backend Web com Haskell+Scotty

## 1. Identificação

- Nome: Cedric Marques Rocha
- Curso: Sistemas de Informação

---

## 2. Tema/objetivo

O trabalho feito é em um serviço web de diário de treinos de academia, desenvolvido em Haskell com a biblioteca Scotty e persistência em SQLite. O serviço permite registrar treinos e exercícios realizados, consultar histórico, acompanhar a evolução de carga por exercício e visualizar estatísticas como frequência por grupo muscular e recordes pessoais. Foi também desenvolvido um frontend simples em HTML, Tailwind CSS e JavaScript que consome a API e exibe os dados com um gráfico de evolução de carga usando Chart.js. A lógica principal do serviço está concentrada em funções puras no arquivo `Logica.hs`, separadas das rotas HTTP definidas em `Rotas.hs`. Funções como `filtrarPorGrupo`, `maiorCarga`, `volumeTreino`, `evolucaoCarga`, `recordes` e `frequenciaPorGrupo` recebem e retornam dados sem nenhuma dependência do Scotty, o que facilita os testes unitários e a separação entre lógica e infraestrutura. A programação funcional aparece no uso de funções de alta ordem como `map`, `filter` e `foldl`, e na composição de funções para transformar e agregar dados dos treinos.

---

## 3. Processo de desenvolvimento

A ideia inicial era desenvolver um serviço simples de registro de treinos de academia com GET,POST,PUT e DELETE, mas eu migrei para apenas GET e POST durante o desenvolvimento por que já atenderia os requisitos. O tema foi escolhido por ser algo do cotidiano e por ter uma estrutura de dados facilmente compatível com programação funcional da linguagem haskell.

O desenvolvimento foi incremental. Comecei pela estrutura base do projeto, definindo os tipos de dados em `Tipos.hs` e as primeiras funções puras em `Logica.hs` antes de adicionar o Scotty. Isso para que fosse mais fácil testar a lógica (pelo menos a incial) isoladamente antes de conectar tudo ao servidor.

A separação entre lógica e rotas foi uma decisão tomada logo no início, o arquivo `Logica.hs` contém apenas funções puras que recebem e retornam dados, enquanto `Rotas.hs` cuida das requisições HTTP. O `Banco.hs` ficou responsável pela comunicação com o SQLite. Isso deixou o código mais organizado e facilitou os testes.

Alguns erros encontrados ao longo do desenvolvimento:

- O `OverloadedStrings` precisou ser adicionado em vários arquivos para que strings literais funcionassem como `Text` e `Query`
- O parâmetro `id` causava warning por conflitar com a função `id` do Prelude, para resolver foi renomeado para `treinoId_` e `tid`
- O CORS bloqueava requisições POST do frontend, o `simpleCors` não era suficiente e precisei configurar uma política customizada com `wai-cors`
- O deploy no Render falhou inicialmente por falta da flag `-threaded` no `ghc-options` do cabal

A maior dificuldade foi realizar a conexão com o banco de dados. Foi necessário implementar as instâncias de `FromRow` para os tipos `Treino` e `Exercicio`, o que exigiu entender como o `sqlite-simple` mapeia as colunas do banco para os campos dos tipos Haskell. Além disso, a função `rotas` precisou receber a conexão como parâmetro, o que implicou em outras mudanças no código.

---

## 4. Testes


Os testes foram organizados no arquivo `Testes.hs`, que chama as funções puras de `Logica.hs` com dados simulados e verifica os resultados. Não foi usado HUnit, optei por um programa simples que imprime `True` ou `False` para cada teste.

As funções testadas foram:

- `filtrarPorGrupo` — verifica se a filtragem por grupo muscular retorna a quantidade correta de treinos
- `volumeTreino` — verifica se o cálculo de (séries × repetições × carga) está correto
- `maiorCarga` — verifica se retorna a maior carga registrada para um exercício, e `Nothing` quando o exercício não existe
- `buscarPorId` — verifica se retorna o treino correto dado um id
- `evolucaoCarga` — verifica se retorna a lista de cargas na ordem correta
- `recordes` — verifica se retorna o recorde correto para cada exercício
- `frequenciaPorGrupo` — verifica se conta corretamente os treinos por grupo muscular

Os testes rodam automaticamente ao iniciar o servidor, antes de  iniciar o servidor web Scotty.

---

## 5. Execução

### Dependências

- GHC 9.6.7
- Cabal 3.0 ou superior

### Compilar e executar

para rodar localmente:
```bash
cabal build
cabal run
```

O servidor sobe na porta 3000. Acesse `http://localhost:3000/treinos` para verificar.

### Frontend

Abra o arquivo `frontend/index.html` diretamente no navegador. O frontend já está configurado para consumir a API em produção no Render. Para usar com um servidor local, é necessario substituir a URL do Render por `http://localhost:3000` no arquivo `index.html`.

---

## 6. Deploy

Link do serviço publicado: <[aqui](https://perso-2026a-cedricmr.onrender.com)>

O deploy foi realizado no Render via Docker, já que Haskell não tem suporte nativo na plataforma. Foi criado um `Dockerfile` na raiz do projeto que instala as dependências e compila o executável. O Render detecta o `Dockerfile` automaticamente e realiza o build a cada push no repositório do GitHub.

---

## 7. Resultado final

demonstração feita no com o backend rodando no render:
https://youtu.be/iXZRF8m2hoU (velocidade 2x)

O vídeo demonstra o funcionamento do serviço cadastro de um novo treino, adição de um exercício, visualização do histórico, estatísticas de recordes e frequência por grupo muscular, e o gráfico de evolução.

---

## 8. Uso de IA 

### 8.1 Ferramentas de IA utilizadas

Claude Sonnet 4.5 (Thinking) no site [claude.ai](https://claude.ai). 

---

### 8.2 Interações relevantes com IA

#### Interação 1

- **Objetivo da consulta:** Definir a estrutura do projeto e separação de arquivos
- **Trecho do prompt ou resumo fiel:** Perguntei como organizar o projeto em módulos separados para lógica, rotas e tipos
- **O que foi aproveitado:** A sugestão de separar em `Tipos.hs`, `Logica.hs`, `Main.hs`, `Rotas.hs` e `Banco.hs`
- **O que foi modificado ou descartado:** Decidi renomear os arquivos, o que gerou erros de compilação que precisei resolver entendendo como o Haskell relaciona nome de arquivo com declaração de módulo

#### Interação 2

- **Objetivo da consulta:** Entender e reescrever as funções de lógica
- **Trecho do prompt ou resumo fiel:** Pedi como poderia reescrever as funções `volumeTreino` e `maiorCarga` de forma mais simples e legível
- **O que foi aproveitado:** A explicação sobre `foldl` e `Maybe`, e a versão mais explícita do `volumeTreino` sem composição de funções
- **O que foi modificado ou descartado:** No `volumeTreino` removi o `where` e reescrevi usando `foldl` diretamente. Na `maiorCarga` a IA sugeriu trocar o `case` por `if/then/else`, mas mantive o `case` por achar mais claro para esse caso específico

#### Interação 3 

- **Objetivo da consulta:** Resolver o problema de CORS bloqueando requisições POST do frontend
- **Trecho do prompt ou resumo fiel:** Perguntei como habilitar CORS no Scotty para permitir requisições POST de origem diferente
- **O que foi aproveitado:** A solução com política customizada usando `wai-cors`
- **O que foi modificado ou descartado:** A política foi simplificada para incluir apenas `GET` e `POST`, já que o serviço não usa outros verbos


---

### 8.3 Exemplo de erro, limitação ou sugestão inadequada da IA

A IA sugeriu usar `param` para capturar parâmetros de rota no Scotty, mas a função correta na versão utilizada é `pathParam`. O erro só foi identificado durante a compilação a IA não sabia a versão exata do Scotty em uso e sugeriu uma função que não existia no escopo disponível. A correção foi simples após ler a mensagem de erro do compilador.

---

### 8.4 Comentário pessoal sobre o processo envolvendo IA

O uso do Claude foi útil principalmente para lidar com os erros de compilação do GHC, que no início eram difíceis de interpretar. Com o tempo fui conseguindo entender melhor as mensagens de erro e resolver alguns problemas por conta própria antes de consultar a IA.

Uma limitação percebida no uso da IA foi em relação às versões das bibliotecas, em alguns momentos o Claude sugeriu funções desatualizadas ou incompatíveis com a versão em uso. Nesses casos foi necessário interpretar o erro do compilador e corrigir a sugestão. O processo ajudou a compreender melhor conceitos como `Maybe`, `foldl` e a separação entre código puro e código com efeitos colaterais.

---

## 9. Referências e créditos

- Documentação do Scotty: [scotty: Haskell web framework](https://hackage.haskell.org/package/scotty)
- Documentação do sqlite-simple: [https://hackage.haskell.org/package/sqlite-simple](https://hackage.haskell.org/package/sqlite-simple)
- Documentação do aeson: [aeson: Fast JSON parsing and encoding](https://hackage.haskell.org/package/aeson)
- Documentação do wai-cors: [wai-cors: CORS for WAI](https://hackage.haskell.org/package/wai-cors)
- Material de aula da disciplina: [aula 11](https://liascript.github.io/course/?https://raw.githubusercontent.com/elc117/demo-scotty-codespace-2026a/main/README.md#1)
- Vídeo sobre Scotty (materia da aula 11): [Build a Haskell Server with Scotty framework](https://www.youtube.com/watch?v=psTTKGj9G6Y)
