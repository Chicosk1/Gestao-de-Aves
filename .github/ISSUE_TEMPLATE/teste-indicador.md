---
name: Teste do indicador de saúde do lote
about: Plano, rastreabilidade e resultados dos casos CT01 a CT07
title: Teste do indicador de saúde do lote
labels: teste, indicador-saude
---

## Regra (oráculo)

Percentual de mortalidade = aves mortas acumuladas ÷ quantidade inicial do lote × 100.

| Percentual de mortalidade | Status | Farol |
| --- | --- | --- |
| De 0% até abaixo de 5% | NORMAL | verde (`clGreen`) |
| De 5% a 10%, inclusive | ATENÇÃO | amarelo (`clYellow`) |
| Acima de 10% | CRÍTICO | vermelho (`clRed`) |

**Fonte da regra:** _(anexar o enunciado original)_. O README do repositório descreve as faixas invertidas; ele não é o oráculo.

## Versão testada

- Commit: _(ver `versao.txt` da rodada)_
- Texto ativo da `SP_GET_LOTES`: no início do `isql.txt` da rodada

## Casos

- [ ] CT01 · DUnitX · 4,99% → NORMAL, verde
- [ ] CT02 · DUnitX · 5,00% → ATENÇÃO, amarelo
- [ ] CT03 · DUnitX · 10,00% → ATENÇÃO, amarelo
- [ ] CT04 · DUnitX · 10,01% → CRÍTICO, vermelho
- [ ] CT05 · isql · 100 aves, nenhuma morte → atual 100, percentual 0,00
- [ ] CT06 · isql · 100 aves, 7 + 5 mortes → atual 88, percentual 12,00
- [ ] CT07 · manual · lote `TESTE CT06` na tela → CRÍTICO, farol vermelho (anexar captura)

## Matriz de rastreabilidade

| Condição da regra | Risco | Técnica | Casos | Evidência |
| --- | --- | --- | --- | --- |
| Faixa NORMAL: [0; 5) | R1 | Partição de equivalência e valor limite | CT01, CT05 | `dunitx.txt`, `isql.txt` |
| Fronteira de 5% pertence a ATENÇÃO | R2 | Valor limite | CT02 | `dunitx.txt` |
| Fronteira de 10% pertence a ATENÇÃO | R2 | Valor limite | CT03 | `dunitx.txt` |
| Faixa CRÍTICO: (10; 100] | R1 | Partição de equivalência e valor limite | CT04, CT06, CT07 | `dunitx.txt`, `isql.txt`, captura |
| Fórmula com mortes acumuladas | R1 | Partição: sem mortes e com dois lançamentos | CT05, CT06 | `isql.txt` |
| Tela lê o campo e acende o farol | R1 | Teste funcional de sistema | CT07 | captura de tela |

## Rodadas

A cada rodada, comentar nesta issue com data, commit, os arquivos `dunitx.txt`, `dunitx.xml`, `isql.txt` e `versao.txt` anexados e o resultado de cada caso: passou, falhou ou sem execução. Caso sem execução conta como pendente, não como aprovado. Divergência vira issue de defeito ligada a esta.
