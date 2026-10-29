@echo off
setlocal EnableExtensions

rem ======================================================================
rem  Testes do indicador de saude do lote - CT01 a CT06
rem  Uso: tests\executar_testes.bat  (pode ser chamado de qualquer pasta)
rem
rem  Variaveis de ambiente:
rem    ISC_PASSWORD  senha do Firebird (obrigatoria; nao fica no repositorio)
rem    ISC_USER      usuario do Firebird (padrao: SYSDBA)
rem    ISQL          caminho do isql.exe (padrao: isql do PATH)
rem    RSVARS        rsvars.bat do Delphi; se existir, compila antes de rodar
rem                  (padrao: Delphi 12, Studio\23.0)
rem ======================================================================

set "TESTES=%~dp0"
set "RAIZ=%TESTES%.."
set "RESULTADOS=%TESTES%resultados"
set "BANCO_ORIGEM=%RAIZ%\LOTE_AVES_DB.FDB"
set "BANCO_TESTE=%TESTES%LOTE_AVES_TESTE.FDB"
set "EXE=%TESTES%Win32\Debug\LoteAvesTests.exe"

if not defined ISC_USER set "ISC_USER=SYSDBA"
if not defined ISQL     set "ISQL=isql"
if not defined RSVARS   set "RSVARS=C:\Program Files (x86)\Embarcadero\Studio\23.0\bin\rsvars.bat"

if not defined ISC_PASSWORD (
  echo [ERRO] Defina a senha do Firebird antes de rodar: set ISC_PASSWORD=sua_senha
  exit /b 2
)

if not exist "%RESULTADOS%" mkdir "%RESULTADOS%"
set "FALHAS=0"

rem Versao e data da rodada: evidencia para a issue
> "%RESULTADOS%\versao.txt" echo Data: %DATE% %TIME%
for /f %%c in ('git -C "%RAIZ%" rev-parse --short HEAD 2^>nul') do >> "%RESULTADOS%\versao.txt" echo Commit: %%c

echo == 1/4 Copiando o banco de teste
copy /Y "%BANCO_ORIGEM%" "%BANCO_TESTE%" >nul
if errorlevel 1 (
  echo [ERRO] Nao foi possivel copiar "%BANCO_ORIGEM%"
  exit /b 2
)

echo == 2/4 DUnitX: CT01 a CT04
if exist "%RSVARS%" (
  call "%RSVARS%"
  msbuild "%TESTES%LoteAvesTests.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 /v:minimal /nologo
  if errorlevel 1 (
    echo [ERRO] Falha ao compilar LoteAvesTests.dproj
    exit /b 2
  )
)
if not exist "%EXE%" (
  echo [ERRO] LoteAvesTests.exe nao encontrado. Compile tests\LoteAvesTests.dproj no Delphi, Win32 Debug.
  exit /b 2
)
"%EXE%" --xmlfile:"%RESULTADOS%\dunitx.xml" > "%RESULTADOS%\dunitx.txt" 2>&1
if errorlevel 1 (
  echo    DUnitX: ha casos com falha - veja resultados\dunitx.txt
  set "FALHAS=1"
) else (
  echo    DUnitX: CT01 a CT04 passaram
)

echo == 3/4 isql: CT05 e CT06
"%ISQL%" -bail -q -m -i "%TESTES%sql\integracao_indicador.sql" -o "%RESULTADOS%\isql.txt" "%BANCO_TESTE%" 2>nul
if errorlevel 9009 (
  echo    CT05 e CT06: bloqueados - isql nao encontrado. Instale o Firebird 4 ou 5 ou defina ISQL com o caminho do isql.exe
  set "FALHAS=1"
  goto resultado
)
if errorlevel 1 (
  echo    isql: execucao interrompida por erro - veja resultados\isql.txt
  set "FALHAS=1"
)
findstr /R /C:"CT05 *PASSOU" "%RESULTADOS%\isql.txt" >nul
if errorlevel 1 (
  echo    CT05: nao passou
  set "FALHAS=1"
) else (
  echo    CT05: passou
)
findstr /R /C:"CT06 *PASSOU" "%RESULTADOS%\isql.txt" >nul
if errorlevel 1 (
  echo    CT06: nao passou
  set "FALHAS=1"
) else (
  echo    CT06: passou
)

:resultado
echo == 4/4 Resultado
echo    Saidas em %RESULTADOS%
echo    Anexe dunitx.txt, dunitx.xml, isql.txt e versao.txt na issue de teste.
if "%FALHAS%"=="0" (
  echo    Todos os casos automaticos passaram.
  exit /b 0
)
echo    Ha casos com falha: registre a rodada na issue e abra o defeito pelo modelo.
exit /b 1
