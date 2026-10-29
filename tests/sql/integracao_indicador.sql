/*
  CT05 e CT06 - integracao banco <-> aplicacao do indicador de saude do lote.

  Roda sobre a COPIA do banco (tests\LOTE_AVES_TESTE.FDB), criada pelo executar_testes.bat.
  Oraculo: percentual de mortalidade = aves mortas acumuladas / quantidade inicial x 100.
  Cada linha do resultado traz o caso, PASSOU ou FALHOU e os valores lidos de SP_GET_LOTES.
*/

/* Versao ativa da procedure testada: registrar na issue junto com o commit */
SHOW PROCEDURE SP_GET_LOTES;

SET TERM ^ ;

EXECUTE BLOCK
RETURNS (
  CASO                   VARCHAR(4) ,
  RESULTADO              VARCHAR(6) ,
  QUANTIDADE_ATUAL       INTEGER    ,
  PERCENTUAL_MORTALIDADE DOUBLE PRECISION,
  ESPERADO               VARCHAR(40))
AS
  DECLARE ID_CT05 INTEGER;
  DECLARE ID_CT06 INTEGER;
BEGIN
  /* Preparacao: dois lotes de 100 aves; o trigger TRG_INS_LOTE gera o ID */
  INSERT INTO TAB_LOTE_AVES (DESCRICAO, DATA_ENTRADA, QUANTIDADE_INICIAL)
  VALUES ('TESTE CT05', CURRENT_DATE, 100)
  RETURNING ID_LOTE INTO :ID_CT05;

  INSERT INTO TAB_LOTE_AVES (DESCRICAO, DATA_ENTRADA, QUANTIDADE_INICIAL)
  VALUES ('TESTE CT06', CURRENT_DATE, 100)
  RETURNING ID_LOTE INTO :ID_CT06;

  /* CT06: 12 mortes em dois lancamentos, para exercitar o "acumuladas" da regra */
  EXECUTE PROCEDURE SP_INS_MORTALIDADE(:ID_CT06, CURRENT_DATE, 7, 'CT06 - lancamento 1');
  EXECUTE PROCEDURE SP_INS_MORTALIDADE(:ID_CT06, CURRENT_DATE, 5, 'CT06 - lancamento 2');

  /* CT05: lote sem mortes */
  CASO                   = 'CT05';
  ESPERADO               = 'ATUAL = 100; PERCENTUAL = 0,00';
  QUANTIDADE_ATUAL       = NULL;
  PERCENTUAL_MORTALIDADE = NULL;

  SELECT L.QUANTIDADE_ATUAL, L.PERCENTUAL_MORTALIDADE
    FROM SP_GET_LOTES L
   WHERE L.ID_LOTE = :ID_CT05
    INTO :QUANTIDADE_ATUAL, :PERCENTUAL_MORTALIDADE;

  RESULTADO = IIF(QUANTIDADE_ATUAL = 100 AND ABS(PERCENTUAL_MORTALIDADE - 0) < 0.01, 'PASSOU', 'FALHOU');
  SUSPEND;

  /* CT06: lote com 12 mortes acumuladas */
  CASO                   = 'CT06';
  ESPERADO               = 'ATUAL = 88; PERCENTUAL = 12,00';
  QUANTIDADE_ATUAL       = NULL;
  PERCENTUAL_MORTALIDADE = NULL;

  SELECT L.QUANTIDADE_ATUAL, L.PERCENTUAL_MORTALIDADE
    FROM SP_GET_LOTES L
   WHERE L.ID_LOTE = :ID_CT06
    INTO :QUANTIDADE_ATUAL, :PERCENTUAL_MORTALIDADE;

  RESULTADO = IIF(QUANTIDADE_ATUAL = 88 AND ABS(PERCENTUAL_MORTALIDADE - 12) < 0.01, 'PASSOU', 'FALHOU');
  SUSPEND;
END^

SET TERM ; ^

/* Mantem o lote 'TESTE CT06' na copia do banco para a conferencia manual do CT07 */
COMMIT;
