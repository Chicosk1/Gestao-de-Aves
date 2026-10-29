# Testes do indicador de saúde do lote

Casos CT01 a CT07 da ficha do projeto (Qualidade e Teste de Software 2026/2). O oráculo é a regra de negócio: mortalidade abaixo de 5% é NORMAL, de 5% a 10% é ATENÇÃO e acima de 10% é CRÍTICO. O README da raiz descreve as faixas invertidas e não é usado como referência.

## Estrutura

| Arquivo | Casos | O que faz |
| --- | --- | --- |
| `LoteAvesTests.dproj` / `.dpr` | — | Projeto DUnitX de console que compila `uFrameIndicador.pas` |
| `TestFrameIndicador.pas` | CT01–CT04 | Chama `AtualizarSaude` com 4,99, 5,00, 10,00 e 10,01 e compara status e cor do farol |
| `sql/integracao_indicador.sql` | CT05–CT06 | Cria dois lotes de 100 aves na cópia do banco, lança mortes por `SP_INS_MORTALIDADE` e compara o que `SP_GET_LOTES` devolve |
| `executar_testes.bat` | CT01–CT06 | Copia o banco, roda os dois e guarda as saídas em `tests\resultados\` |

`TestFrameIndicador.pas` está em UTF-8 com BOM por causa de ATENÇÃO e CRÍTICO; mantenha essa codificação ao editar.

## Pré-requisitos

- Delphi 12 (Win32). O DUnitX já vem com o Delphi, em `$(BDS)\source\DUnitX`.
- Firebird 4 ou 5 com o `isql`. O `LOTE_AVES_DB.FDB` está em ODS 13.

## Como rodar

```bat
set ISC_PASSWORD=sua_senha
tests\executar_testes.bat
```

Variáveis opcionais: `ISC_USER` (padrão `SYSDBA`), `ISQL` (caminho do `isql.exe`, se não estiver no PATH) e `RSVARS` (caminho do `rsvars.bat`; se existir, o projeto é compilado antes de rodar — padrão: Delphi 12 em `Studio\23.0`). Sem `rsvars.bat`, compile `LoteAvesTests.dproj` no Delphi em Win32 Debug antes.

O `.bat` faz quatro passos:

1. Copia `LOTE_AVES_DB.FDB` para `tests\LOTE_AVES_TESTE.FDB`; a base original não muda.
2. Roda `LoteAvesTests.exe` e salva `dunitx.txt` e `dunitx.xml`.
3. Roda o script no `isql` sobre a cópia e salva `isql.txt`, que começa com o texto ativo da `SP_GET_LOTES`.
4. Mostra o resultado de cada etapa e grava data e commit em `versao.txt`.

Código de saída: `0` quando todos os casos automáticos passam, `1` quando há falha ou caso bloqueado, `2` quando o ambiente impede a execução.

## CT07 — conferência manual na tela

1. Rode o `.bat`: a cópia do banco fica com o lote `TESTE CT06` (12 mortes em 100 aves).
2. Em `src\Model\Data\dmConexao.pas`, aponte `DB_CAMINHO` para `tests\LOTE_AVES_TESTE.FDB`. Não faça commit dessa mudança.
3. Abra a aplicação, selecione `TESTE CT06` e confira: farol vermelho e status CRÍTICO.
4. Anexe a captura de tela na issue de teste.

## Registro dos resultados

As saídas não vão para o Git (`tests/resultados/` está no `.gitignore`). Anexe-as na issue aberta pelo modelo **Teste do indicador de saúde do lote**; divergências viram issues pelo modelo **Defeito encontrado em teste**. Os modelos usam as labels `teste`, `indicador-saude`, `defeito` e `análise`, que precisam existir no repositório.
