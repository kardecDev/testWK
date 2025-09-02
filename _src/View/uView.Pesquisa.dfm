object fPesquisa: TfPesquisa
  Left = 0
  Top = 0
  Caption = 'Pesquisa: Selecione registro desejado e pressione <ENTER>'
  ClientHeight = 304
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object pnlBottom: TPanel
    Left = 0
    Top = 267
    Width = 624
    Height = 37
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 250
    object btnFechar: TBitBtn
      Left = 273
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = btnFecharClick
    end
  end
  object dbgDados: TDBGrid
    Left = 0
    Top = 57
    Width = 624
    Height = 210
    Align = alClient
    DataSource = dsDados
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnTitleClick = dbgDadosTitleClick
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 57
    Align = alTop
    TabOrder = 2
    object gpbFiltro: TGroupBox
      Left = 1
      Top = 1
      Width = 622
      Height = 55
      Align = alClient
      Caption = 'Pesquisar por: [NOME DO CAMPO]'
      TabOrder = 0
      ExplicitLeft = 8
      ExplicitTop = 0
      ExplicitWidth = 185
      ExplicitHeight = 103
      object EdtPesquisa: TEdit
        Left = 2
        Top = 17
        Width = 618
        Height = 36
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = EdtPesquisaChange
        ExplicitLeft = 6
        ExplicitTop = 16
        ExplicitWidth = 603
        ExplicitHeight = 29
      end
    end
  end
  object dsDados: TDataSource
    DataSet = mtDados
    Left = 512
    Top = 16
  end
  object mtDados: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 440
    Top = 16
  end
end
