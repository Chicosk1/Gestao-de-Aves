object FrameIndicador: TFrameIndicador
  Left = 0
  Top = 0
  Width = 150
  Height = 30
  TabOrder = 0
  object shpFarol: TShape
    Left = 5
    Top = 5
    Width = 20
    Height = 20
    Shape = stCircle
  end
  object lblStatus: TLabel
    Left = 30
    Top = 8
    Width = 47
    Height = 15
    Caption = 'Situa'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
end
