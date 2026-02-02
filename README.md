# Avaliacao-SAG - Gestão de Lote de Aves

Este projeto consiste numa aplicação Delphi VCL desenvolvida para gerir lotes de aves, permitindo o registo de pesagens médias e o controle de mortalidade com indicadores visuais de saúde do lote.

## 1. Instruções de Execução

### Pré-requisitos
* **IDE:** Embarcadero Delphi (versão 12 recomendada).
* **Banco de Dados:** Firebird SQL.
* **Componentes:** FireDAC (nativo do Delphi).

### Parametrizar a Conexão
Para executar o projeto, é necessário configurar o caminho do banco de dados na unit de conexão, uma vez que o caminho atual é constante:

1.  Abra o ficheiro `src/Model/Data/dmConexao.pas`.
2.  Localize a constante `DB_CAMINHO` na secção `private` da classe `TfdmConexao`.
3.  Altere o valor para o caminho onde se encontra o seu ficheiro `.FDB`:
    ```pascal
    DB_CAMINHO = 'C:\Caminho\Para\O\Seu\Banco\LOTE_AVES_DB.FDB'; // Ajuste aqui
    ```

### Compilação
1.  Abra o ficheiro de projeto `LoteAves.dproj` no Delphi.
2.  Compile em modo **Debug** ou **Release** para a plataforma **Win32**.
3.  Execute a aplicação.

---

## 2. Detalhes Técnicos

### Arquitetura
O projeto utiliza uma arquitetura baseada em camadas (Layered Architecture) com padrões de **MVC (Model-View-Controller)**:
* **View:** Interface com o utilizador (`ucLote.pas`, `ucPesagem.pas`, `ucMortalidade.pas`).
* **Controller:** Lógica de orquestração entre a View e o Model (`cLote.pas`, `cOperacoes.pas`).
* **Model:** Contém as entidades de negócio (`uPesagem.pas`, `uMortalidade.pas`) e a camada de persistência de dados (`uDmLote.pas`, `uDmPesagem.pas`, `uDmMortalidade.pas`).

### Design Patterns e Técnicas Utilizadas
* **Factory:** As classes de entidade e de dados implementam um método de classe `New` que retorna uma interface, facilitando a criação de instâncias sem expor o construtor.
* **Singleton:** A conexão é gerida de forma centralizada através de um método de classe `GetConexao` no DataModule de conexão, garantindo a reutilização da mesma conexão.
* **Template Method:** Uso da classe `TDmBase` para encapsular comportamentos comuns de execução de SQL via FireDAC, que são herdados por outros DataModules.

### Uso de Interfaces
O uso de interfaces (ex: `IPesagem`, `IDmLote`) foi aplicado para:
* **Desacoplamento:** A View e o Controller dependem de abstrações e não de implementações concretas, permitindo que a implementação interna seja alterada sem afetar quem a consome.

### SOLID no Projeto
* **Single Responsibility (S):** Cada classe tem uma função única. Por exemplo, `uDmMortalidade` foca-se exclusivamente na persistência de dados de mortalidade.
* **Dependency Inversion (D):** Os Controllers recebem interfaces em vez de classes concretas, invertendo a dependência para abstrações.

### Encapsulamento e Herança
* **Encapsulamento:** Garantido pelo uso de visibilidade `private` para campos de dados e `public` para métodos e propriedades.
* **Herança:** Aplicada na camada de dados, onde classes como `TDmMortalidade` herdam de `TDmBase`, reutilizando métodos como `ExecutarComando`. Na View, os formulários herdam de `TForm` da VCL.

---

## 3. Indicador de Saúde
A aplicação possui um componente visual (`uFrameIndicador`) que avalia a saúde do lote com base no percentual de mortalidade:
* **Verde (NORMAL):** Mortalidade > 10%.
* **Amarelo (ATENÇÃO):** Mortalidade entre 5% e 10%.
* **Vermelho (CRÍTICO):** Mortalidade < 5%.
