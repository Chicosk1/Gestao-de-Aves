object frmLote: TfrmLote
  Left = 0
  Top = 0
  Caption = 'Lote das Aves'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 60
    Align = alTop
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 21
      Top = 16
      Width = 205
      Height = 25
      Align = alCustom
      Caption = 'Gest'#227'o de Lote de Aves'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnNovaPesagem: TButton
      AlignWithMargins = True
      Left = 512
      Top = 11
      Width = 101
      Height = 38
      Margins.Left = 5
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alRight
      Caption = 'Lan'#231'ar Pesagem'
      TabOrder = 0
      OnClick = btnNovaPesagemClick
    end
    object btnNovaMortalidade: TButton
      AlignWithMargins = True
      Left = 384
      Top = 11
      Width = 113
      Height = 38
      Margins.Left = 5
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alRight
      Caption = 'Lan'#231'ar Mortalidade'
      TabOrder = 1
      OnClick = btnNovaMortalidadeClick
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 60
    Width = 624
    Height = 341
    Margins.Bottom = 10
    Align = alClient
    TabOrder = 1
    object gridLotes: TDBGrid
      Left = 1
      Top = 1
      Width = 622
      Height = 339
      Align = alClient
      DataSource = dsLotes
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDrawColumnCell = gridLotesDrawColumnCell
      Columns = <
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ID_LOTE'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'd.'
          Width = 50
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Alignment = taCenter
          Title.Caption = 'Descri'#231#227'o do Lote'
          Width = 250
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'DATA_ENTRADA'
          Title.Alignment = taCenter
          Title.Caption = 'Data Entrada'
          Width = 80
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'QUANTIDADE_INICIAL'
          Title.Alignment = taCenter
          Title.Caption = 'Qtd. Inicial'
          Width = 80
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'PESO_MEDIO_ATUAL'
          Title.Alignment = taCenter
          Title.Caption = 'Peso M'#233'dio (kg)'
          Width = 90
          Visible = True
        end>
    end
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 401
    Width = 624
    Height = 40
    Align = alBottom
    TabOrder = 2
  end
  object dsLotes: TDataSource
    Left = 568
    Top = 348
  end
end
