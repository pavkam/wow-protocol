object BFGMain: TBFGMain
  Left = 302
  Top = 242
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'WoW RE Tool'
  ClientHeight = 330
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label40: TLabel
    Left = 336
    Top = 12
    Width = 69
    Height = 13
    Caption = 'Hex Value:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pgcMain: TPageControl
    Left = 0
    Top = 0
    Width = 505
    Height = 330
    ActivePage = tbMapExtractor
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    TabOrder = 0
    TabPosition = tpBottom
    OnChange = pgcMainChange
    object tbMain: TTabSheet
      Caption = 'Sniffer'
      object Label5: TLabel
        Left = 1
        Top = 1
        Width = 67
        Height = 13
        Caption = 'Messages:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 11
        Top = 233
        Width = 88
        Height = 13
        Caption = 'Select Realm:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 23
        Top = 260
        Width = 74
        Height = 13
        Caption = 'Key Pieces:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label19: TLabel
        Left = 8
        Top = 184
        Width = 456
        Height = 18
        Caption = 'Message Window Hidden for Performance Reasons!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label21: TLabel
        Left = 200
        Top = 72
        Width = 241
        Height = 40
        Caption = 'WoW RE Sniffer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = cl3DDkShadow
        Font.Height = -29
        Font.Name = 'Comic Sans MS'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Panel5: TPanel
        Left = 3
        Top = 20
        Width = 153
        Height = 137
        BevelInner = bvLowered
        Caption = 'Panel5'
        Color = clWhite
        ParentBackground = False
        TabOrder = 8
        object Image2: TImage
          Left = 2
          Top = 2
          Width = 149
          Height = 133
          Align = alClient
          Center = True
          Picture.Data = {
            0A544A504547496D61676561090000FFD8FFE000104A46494600010101006000
            600000FFDB004300080606070605080707070909080A0C140D0C0B0B0C191213
            0F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F2739
            3D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232
            3232323232323232323232323232323232323232323232323232323232323232
            32323232323232323232323232FFC00011080071009003012200021101031101
            FFC4001F0000010501010101010100000000000000000102030405060708090A
            0BFFC400B5100002010303020403050504040000017D01020300041105122131
            410613516107227114328191A1082342B1C11552D1F02433627282090A161718
            191A25262728292A3435363738393A434445464748494A535455565758595A63
            6465666768696A737475767778797A838485868788898A92939495969798999A
            A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
            D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
            01010101010101010000000000000102030405060708090A0BFFC400B5110002
            0102040403040705040400010277000102031104052131061241510761711322
            328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
            292A35363738393A434445464748494A535455565758595A636465666768696A
            737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
            A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
            E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7FA
            28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A
            28A2800A28A2800A28A2800A28A2800AC6BFF16F87F4BD5A1D2AFB57B482FE62
            A23B7793E6258E178ED93EB5B35E2FE20F82971ABF8FEE75FB9D7625D367B84B
            9916542651823280F002E38073C71C71401E8FE37F13A783FC257BAD343E73C2
            A04719240676202827D326BCA7C23F117C6317C47D3B43D7EEEC6FEDF5341205
            B5D8DE4864257057A608E41CF7F6AF66D6F45B0F11E8B73A56A3089AD2E136B2
            E7F1041EC41C107DAB9FF087C32F0DF82AE25BAD32DE592EE41B7ED170FBDD57
            FBABC0007E19F7A00EC68A28A0028A28A0028A28A0028A28A0028A28A0028A28
            A0028A28A002BCA7E2A6A336BDACE8DE02D3019A5BD9D67D455491B2DD483862
            0F00F27F01EB5E95AB6A76DA369375A8DDC8B1DBDB4664766E800AF39F83DA45
            C5DC5A9F8DB538F17BADCC5E20C7718E104E003E9DBE8A2803D3E1852DE08E18
            D76C71A84503B003029F45140051451400514514005145140051451400514514
            00514562789BC5BA2F8474E6BCD5EF12118263881064948EC8BDCD006DD15E79
            E0DF1E788BC5DAC8957C2925A787254262BD9A50AF9E70707EF03D30BD3AE4D7
            A1D007977C67D56E65D3B4DF0A69E7379ACDC08DD14FCDE50EA471D3D6BD1749
            D362D1F47B3D36024C56B0A42848C6428C7F4AF26D6E46B9FDA5746865E6382C
            418C11D090E4E38AF65A0028A28A0028A28A0028A29080CA41E8463838A006A4
            B1C85823AB153B5B69CE0FA1A7D782789EC2FBE0E78D20F11E9134F3E83A94D8
            BD82672E43124B0CFD3904F39E39AF76B5B98AF6D21BA81B743346B246DEAA46
            41FC8D004B45145001451450062F8AFC4D65E12F0F5CEAF7D931C23E58D7AC8C
            7A28FAD78C782BC257FF00157C452F8CBC5BB8E98B2116B66D9DB201D1474F90
            71FEF1CFBE6C7ED0B717775A9F87B458E57582E0B36C00619CB05193ED9E9D39
            AF63B0B5B2F09F85A0B7CAC567A7DB00483C61472793DFDCD006A222451AA22A
            A2200AAAA30001D00A86DEFECEEE5962B6BB8269223B6448E40C50FA103A57CA
            3E31F1E789FE236B32C5A74379FD9F09FDCD9D923B7CB9E19F68C9278F6E95CD
            2D978A3C1F7506A5F64D4B4A9948293344D1F7070723079032A7F11401F4178F
            341D4EC3E2A786BC59A65B4B3C523ADADDF95117283B138E8A413CF6C72715EB
            35E75F0A3E232F8DF4636F7F246BACDB0C4C8005F357B381FCFDEBD16800A28A
            2800A8EE2E21B5B792E2E2548A18D4B3BB9C0503A926A4AF03F8D5E3EB9D42FC
            F81B415964919D52F0C60E646382B12E3A8F5FCBD6802B78ABE39EB5A96A9269
            BE0CB43E52B6167111965940EA42E3815BDF0EFE2378ABFB76CFC3BE33D36E52
            6BE42F697325B18DDBFDE18031EF818CD74DF0A7E1EC7E09D044D751A1D62ED4
            1B87C0CC63A88C1F41DFD48F6AEDB52B49AEF4EB886D6E4DA5D491324572A819
            A22470C01E0E2803CBFE3AEA905C68165E17B6226D5350BA8FCB851B25403D48
            EB824D7A5E8560DA5681A7D83B6E7B6B78E2639CE48500FE19AE3FC11F0AAC3C
            2D7CFABEA37926B3ADB9CFDB2E5794EDF28249CE38C939FA57A0500145145001
            4514500799FC68F05CBE26F0BADFD846CDA9E984CB108D49774FE2518E73C023
            DC5637853E24E8FE3AF05BF85B55BA4B4D6E7B56B502707CB9DB18560DD3278C
            A9E7AF5AF65AF38F157C16F0CF892F8EA1079DA5DEB3EF924B4C0573EA54F00E
            79C8C7E3401ADF0D3C2D71E13F07DB69F7F05925FA16F35ED86778DC4AE5B009
            38C575B34315C44D14D1A491B75575041FC0D71BE0CF863A4F82AFA5BEB4BED4
            6EEEA58BCA66BA9815C673C2803F5CF53EB5DB5007807C43F0949F0CFC4367E3
            7F0AA1B7B31284B9B741F247BB823191F2B74C7638E9C57B5F87B5FB1F136876
            BAB69D2AC904E80E01C946EEA7D083C55AD4F4EB5D5F4CB9D3AF6212DB5C4663
            910F706BC0747D62FBE0878E26D07556967F0D5E132C5295C951D038C0E48C61
            97E878EE01F4451542C35AD3354B34BBB1BFB7B8B771959124041AA5ABF8CBC3
            9A123B6A5ACD9405464A194173EC14724D0033C67E2487C27E14BED5E6233126
            2253FC6E78515E45F033C2736ABA9DDF8E35652EED23A5AEF5FBCE4FCF20CFA7
            2A3FE0553DECDA9FC71D7A1B6B38A5B3F0758CC1A59DFE579D867A763C6303B6
            727D2BDB6C6CADF4DB182CAD2258ADE0411C71A8C055030050058A28A2800A28
            A2800A28A2800A28A2800A28A2800A28A2800AC2F15784748F18E946C357B7F3
            10731C8A70F137F794D6ED1401F3C6A1FB3CEB36924CDA2EBF0BC6794498346C
            DD70095C8FD3BD5AF0CFECECE9751CFE25D4A392153CDADA67E7E9D5CE303AF4
            1F88AF7DA2802AE9DA6D969161158E9F6D1DB5AC4309146B80B56A8A2800A28A
            2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A
            2800A28A2800A28A2800A28A2803FFD9}
          Transparent = True
          ExplicitLeft = -109
          ExplicitTop = -21
          ExplicitWidth = 151
          ExplicitHeight = 135
        end
      end
      object btExit: TButton
        Left = 383
        Top = 257
        Width = 84
        Height = 23
        Caption = 'Exit'
        TabOrder = 0
        OnClick = btExitClick
      end
      object btStartStop: TButton
        Left = 289
        Top = 257
        Width = 88
        Height = 23
        Caption = 'btStartStop'
        TabOrder = 1
        OnClick = btStartStopClick
      end
      object cbLogVis: TCheckBox
        Left = 414
        Top = 0
        Width = 83
        Height = 17
        Caption = 'Log Visible'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = cbLogVisClick
      end
      object mmLog: TRichEdit
        Left = 0
        Top = 18
        Width = 495
        Height = 207
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        OnEnter = mmLogEnter
      end
      object edtYAWE: TEdit
        Left = -100
        Top = 111
        Width = 38
        Height = 21
        TabOrder = 4
        Text = 'YAWE'
      end
      object pnlPlaceKeyPieces: TPanel
        Left = 114
        Top = 262
        Width = 162
        Height = 13
        BevelKind = bkTile
        BevelOuter = bvNone
        Caption = 'Key Pieces'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object pnlPlaceRealms: TPanel
        Left = 116
        Top = 229
        Width = 381
        Height = 21
        BevelKind = bkTile
        BevelOuter = bvNone
        Caption = 'Realms ComboBox'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object btToTray: TButton
        Left = 472
        Top = 257
        Width = 25
        Height = 23
        Caption = '_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        OnClick = btToTrayClick
      end
    end
    object tbOptions: TTabSheet
      Caption = 'Options'
      ImageIndex = 1
      object Label1: TLabel
        Left = 8
        Top = 0
        Width = 141
        Height = 13
        Caption = 'Official Logon Server:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 8
        Top = 40
        Width = 122
        Height = 13
        Caption = 'Logon Server Port:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 152
        Top = 40
        Width = 173
        Height = 13
        Caption = 'World(Realm) Server Port:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 11
        Top = 184
        Width = 315
        Height = 13
        Caption = 'Log File name (%d - replaces with current date)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 11
        Top = 103
        Width = 226
        Height = 13
        Caption = 'Sniffer External IP ( for 2 comps. )'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 392
        Top = 40
        Width = 88
        Height = 13
        Caption = 'Max TimeOut:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 11
        Top = 60
        Width = 38
        Height = 13
        Caption = 'Listen:'
      end
      object Label10: TLabel
        Left = 11
        Top = 84
        Width = 35
        Height = 13
        Caption = 'Open:'
      end
      object Label22: TLabel
        Left = 176
        Top = 59
        Width = 38
        Height = 13
        Caption = 'Listen:'
      end
      object edtLogonServer: TEdit
        Left = 8
        Top = 16
        Width = 481
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edtLogonPort: TEdit
        Left = 49
        Top = 58
        Width = 83
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnKeyPress = edtLogonPortKeyPress
      end
      object edtWorldPort: TEdit
        Left = 220
        Top = 56
        Width = 105
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnKeyPress = edtLogonPortKeyPress
      end
      object edtOutFile: TEdit
        Left = 11
        Top = 200
        Width = 446
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object btBrowse: TButton
        Left = 464
        Top = 200
        Width = 23
        Height = 21
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = btBrowseClick
      end
      object edtExternalIp: TEdit
        Left = 11
        Top = 119
        Width = 478
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object edtConnTime: TEdit
        Left = 392
        Top = 56
        Width = 97
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnKeyPress = edtLogonPortKeyPress
      end
      object cbMinimizeOnRun: TCheckBox
        Left = 178
        Top = 244
        Width = 177
        Height = 17
        Caption = 'Minimize To Tray on Start'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object cbSaveRealm: TCheckBox
        Left = 178
        Top = 263
        Width = 177
        Height = 17
        Caption = 'Save Last Used Realm'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnClick = cbSaveRealmClick
      end
      object rgKey: TRadioGroup
        Left = 11
        Top = 227
        Width = 161
        Height = 53
        Caption = 'Key Extraction Method'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = []
        Items.Strings = (
          'Standard - No heuristics.'
          'Fast - With heuristics.'
          'YAWE - Debug only')
        ParentFont = False
        TabOrder = 9
      end
      object edtOpenLogonPort: TEdit
        Left = 49
        Top = 81
        Width = 83
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        OnKeyPress = edtLogonPortKeyPress
      end
      object Panel1: TPanel
        Left = 11
        Top = 172
        Width = 478
        Height = 3
        TabOrder = 11
      end
      object cbLogRTF: TCheckBox
        Left = 178
        Top = 224
        Width = 177
        Height = 17
        Caption = 'Use RTF for logging'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
    end
    object tbPlugins: TTabSheet
      Caption = 'Plugins'
      ImageIndex = 2
      object lbCurrPlug: TLabel
        Left = 3
        Top = 5
        Width = 44
        Height = 13
        Caption = 'Plugin:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clOlive
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbbPlugins: TComboBox
        Left = 70
        Top = 2
        Width = 427
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cbbPluginsChange
      end
      object gbInfo: TGroupBox
        Left = 3
        Top = 24
        Width = 495
        Height = 254
        Caption = 'Information'
        TabOrder = 1
        object lbPlugName: TLabel
          Left = 8
          Top = 16
          Width = 80
          Height = 15
          Caption = 'lbPlugName'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Fixedsys'
          Font.Style = []
          ParentFont = False
        end
        object lbPlugVersion: TLabel
          Left = 8
          Top = 35
          Width = 104
          Height = 15
          Caption = 'lbPlugVersion'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Fixedsys'
          Font.Style = []
          ParentFont = False
        end
        object lbPlugID: TLabel
          Left = 264
          Top = 35
          Width = 64
          Height = 15
          Caption = 'lbPlugID'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clPurple
          Font.Height = -11
          Font.Name = 'Fixedsys'
          Font.Style = []
          ParentFont = False
        end
        object lbPlugDev: TLabel
          Left = 264
          Top = 13
          Width = 72
          Height = 15
          Caption = 'lbPlugDev'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'Fixedsys'
          Font.Style = []
          ParentFont = False
        end
        object lbPlugInfo: TLabel
          Left = 8
          Top = 59
          Width = 82
          Height = 13
          Caption = 'Information:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbPackets: TLabel
          Left = 8
          Top = 123
          Width = 125
          Height = 13
          Caption = 'Processes Packets:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbFormat: TLabel
          Left = 430
          Top = 231
          Width = 59
          Height = 13
          Alignment = taRightJustify
          Caption = 'lbFormat'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object cbEnabled: TCheckBox
          Left = 8
          Top = 231
          Width = 105
          Height = 17
          Caption = 'Enable Plugin'
          TabOrder = 0
          OnClick = cbEnabledClick
        end
        object mmInfo: TMemo
          Left = 8
          Top = 75
          Width = 481
          Height = 39
          Color = clBtnFace
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
        end
        object mmPack: TMemo
          Left = 8
          Top = 139
          Width = 481
          Height = 86
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -8
          Font.Name = 'Fixedsys'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 2
        end
        object btSelNone: TButton
          Left = 137
          Top = 231
          Width = 80
          Height = 17
          Caption = 'Disable All'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          OnClick = btSelNoneClick
        end
        object btSelRTFed: TButton
          Left = 223
          Top = 231
          Width = 154
          Height = 17
          Caption = 'Enable All Formatting'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnClick = btSelRTFedClick
        end
      end
    end
    object tbPost: TTabSheet
      Caption = 'Post Processing'
      ImageIndex = 4
      object Label18: TLabel
        Left = 8
        Top = 8
        Width = 143
        Height = 13
        Caption = 'Input (Raw) Data File:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label20: TLabel
        Left = 8
        Top = 56
        Width = 102
        Height = 13
        Caption = 'Output Log File:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label43: TLabel
        Left = 8
        Top = 107
        Width = 443
        Height = 26
        Caption = 
          'Note: The input file should be any log file created with "Raw Du' +
          'mper" plugin. Other data is invalid and unusable by this post-pr' +
          'ocessing module!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object edtPostInFile: TEdit
        Left = 8
        Top = 23
        Width = 455
        Height = 21
        TabOrder = 0
      end
      object edtPostOutFile: TEdit
        Left = 8
        Top = 72
        Width = 455
        Height = 21
        TabOrder = 1
      end
      object btStartProcess: TButton
        Left = 352
        Top = 240
        Width = 142
        Height = 32
        Caption = 'Process Input File'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = btStartProcessClick
      end
      object btBrowseIn: TButton
        Left = 469
        Top = 23
        Width = 23
        Height = 21
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = btBrowseInClick
      end
      object btBrowseOut: TButton
        Left = 469
        Top = 72
        Width = 23
        Height = 21
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = btBrowseOutClick
      end
      object pgMain: TProgressBar
        Left = 8
        Top = 240
        Width = 338
        Height = 32
        TabOrder = 5
      end
    end
    object tbUpdateExtract: TTabSheet
      Caption = 'Update Fields Extractor'
      ImageIndex = 5
      object Label23: TLabel
        Left = 8
        Top = 8
        Width = 112
        Height = 13
        Caption = 'WoW Executable:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label24: TLabel
        Left = 8
        Top = 56
        Width = 168
        Height = 13
        Caption = 'Output Update Fields File:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label25: TLabel
        Left = 8
        Top = 109
        Width = 98
        Height = 13
        Caption = 'Output Format:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clPurple
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label44: TLabel
        Left = 8
        Top = 171
        Width = 456
        Height = 26
        Caption = 
          'Note: This utility let'#39's you extract all update fields from WoW ' +
          'executable in any desired format.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object edtWoWPath: TEdit
        Left = 8
        Top = 23
        Width = 455
        Height = 21
        TabOrder = 0
      end
      object btBrowseWoW: TButton
        Left = 469
        Top = 23
        Width = 23
        Height = 21
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btBrowseWoWClick
      end
      object btBrowseUFOut: TButton
        Left = 469
        Top = 72
        Width = 23
        Height = 21
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = btBrowseUFOutClick
      end
      object edtUFPath: TEdit
        Left = 8
        Top = 72
        Width = 455
        Height = 21
        TabOrder = 3
      end
      object cbbFormat: TComboBox
        Left = 8
        Top = 125
        Width = 249
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
      end
      object btExtractUF: TButton
        Left = 152
        Top = 239
        Width = 209
        Height = 32
        Caption = 'Extract Update Fields'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnClick = btExtractUFClick
      end
      object cbUnixLines: TCheckBox
        Left = 272
        Top = 127
        Width = 191
        Height = 17
        Caption = 'Unix Style Line Terminator'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = cbEnabledClick
      end
    end
    object tbMPQExtract: TTabSheet
      Caption = 'MPQ Extractor'
      ImageIndex = 6
      object Label26: TLabel
        Left = 8
        Top = 8
        Width = 79
        Height = 13
        Caption = 'MPQ Achive:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label27: TLabel
        Left = 8
        Top = 48
        Width = 105
        Height = 13
        Caption = 'Files in Archive:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtMPQPath: TEdit
        Left = 8
        Top = 23
        Width = 393
        Height = 21
        TabOrder = 0
        OnChange = edtMPQPathChange
      end
      object btBrowseMPQPath: TButton
        Left = 404
        Top = 23
        Width = 23
        Height = 21
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btBrowseMPQPathClick
      end
      object btExtractSelectedFiles: TButton
        Left = 299
        Top = 255
        Width = 190
        Height = 24
        Caption = 'Extract File ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = btExtractSelectedFilesClick
      end
      object btLoadMPQ: TButton
        Left = 431
        Top = 23
        Width = 58
        Height = 21
        Caption = 'Load'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = btLoadMPQClick
      end
      object lbxFiles: TListBox
        Left = 8
        Top = 64
        Width = 481
        Height = 186
        ItemHeight = 13
        TabOrder = 4
      end
      object btCloseArchive: TButton
        Left = 103
        Top = 255
        Width = 190
        Height = 24
        Caption = 'Close MPQ Archive'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnClick = btCloseArchiveClick
      end
    end
    object tbMapExtractor: TTabSheet
      Caption = 'Map Extractor'
      ImageIndex = 7
      object Label28: TLabel
        Left = 8
        Top = 8
        Width = 201
        Height = 13
        Caption = 'World Of Warcraft Data Folder:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label29: TLabel
        Left = 8
        Top = 56
        Width = 75
        Height = 13
        Caption = 'Output File:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbMap: TLabel
        Left = 144
        Top = 221
        Width = 5
        Height = 9
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Lucida Console'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lbMemory: TLabel
        Left = 407
        Top = 4
        Width = 4
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object Label45: TLabel
        Left = 144
        Top = 99
        Width = 316
        Height = 39
        Caption = 
          'Note: This tool creates an output file (YMF format) that should ' +
          'be used with YAWE only. Further processing might give you the de' +
          'sired format.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object edtWoWDataPath: TEdit
        Left = 8
        Top = 23
        Width = 455
        Height = 21
        TabOrder = 0
      end
      object btBrowseWoWDir: TButton
        Left = 469
        Top = 23
        Width = 23
        Height = 21
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btBrowseWoWDirClick
      end
      object edtOutTTFile: TEdit
        Left = 8
        Top = 72
        Width = 455
        Height = 21
        TabOrder = 2
      end
      object btBrowseOutTTFile: TButton
        Left = 469
        Top = 72
        Width = 23
        Height = 21
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = btBrowseOutTTFileClick
      end
      object btExtractMaps: TButton
        Left = 352
        Top = 240
        Width = 142
        Height = 32
        Caption = 'Extract Map Info'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = btExtractMapsClick
      end
      object pgMaps: TProgressBar
        Left = 8
        Top = 240
        Width = 338
        Height = 32
        TabOrder = 5
      end
      object cbXCompress: TCheckBox
        Left = 151
        Top = 147
        Width = 191
        Height = 17
        Caption = 'Compress Tile Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = cbEnabledClick
      end
      object pnlPlaceMapDraw: TPanel
        Left = 8
        Top = 99
        Width = 130
        Height = 130
        BevelKind = bkTile
        BevelOuter = bvNone
        Caption = 'Map Drawing'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
    end
    object tbDataCheck: TTabSheet
      Caption = 'Data Check'
      ImageIndex = 8
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label30: TLabel
        Left = 8
        Top = 5
        Width = 98
        Height = 13
        Caption = 'Cardinal Value:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label31: TLabel
        Left = 173
        Top = 5
        Width = 96
        Height = 13
        Caption = 'Decimal Value:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label32: TLabel
        Left = 8
        Top = 49
        Width = 86
        Height = 13
        Caption = 'Binary Value:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label33: TLabel
        Left = 8
        Top = 98
        Width = 86
        Height = 13
        Caption = '4 Char Value:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label34: TLabel
        Left = 256
        Top = 99
        Width = 163
        Height = 13
        Caption = '4 Char Value (Reversed):'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label35: TLabel
        Left = 8
        Top = 139
        Width = 92
        Height = 13
        Caption = '4 Bytes Value:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label36: TLabel
        Left = 256
        Top = 139
        Width = 169
        Height = 13
        Caption = '4 Bytes Value (Reversed):'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label37: TLabel
        Left = 8
        Top = 189
        Width = 77
        Height = 13
        Caption = 'Float Value:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clOlive
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label38: TLabel
        Left = 256
        Top = 189
        Width = 154
        Height = 13
        Caption = 'Float Value (Reversed):'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clOlive
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label39: TLabel
        Left = 8
        Top = 240
        Width = 88
        Height = 13
        Caption = 'C Time Value:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label41: TLabel
        Left = 336
        Top = 5
        Width = 69
        Height = 13
        Caption = 'Hex Value:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label42: TLabel
        Left = 288
        Top = 47
        Width = 77
        Height = 13
        Caption = 'Packet Hex:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtValCardinal: TEdit
        Left = 8
        Top = 20
        Width = 145
        Height = 21
        TabOrder = 0
        OnChange = edtValCardinalChange
      end
      object edtValDecimal: TEdit
        Left = 173
        Top = 20
        Width = 145
        Height = 21
        TabOrder = 1
        OnChange = edtValDecimalChange
      end
      object edtBinaryValue: TEdit
        Left = 8
        Top = 64
        Width = 261
        Height = 20
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object edt4Chars: TEdit
        Left = 8
        Top = 112
        Width = 225
        Height = 21
        TabOrder = 3
        OnChange = edt4CharsChange
      end
      object Panel2: TPanel
        Left = 8
        Top = 91
        Width = 473
        Height = 4
        TabOrder = 4
      end
      object edt4CharsRev: TEdit
        Left = 256
        Top = 112
        Width = 225
        Height = 21
        TabOrder = 5
        OnChange = edt4CharsRevChange
      end
      object edt4Bytes: TEdit
        Left = 8
        Top = 154
        Width = 225
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 6
      end
      object edt4BytesRev: TEdit
        Left = 256
        Top = 153
        Width = 225
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 7
      end
      object Panel3: TPanel
        Left = 8
        Top = 181
        Width = 473
        Height = 4
        TabOrder = 8
      end
      object edtValFloat: TEdit
        Left = 8
        Top = 203
        Width = 225
        Height = 21
        TabOrder = 9
        OnChange = edtValFloatChange
      end
      object edtValFloatRev: TEdit
        Left = 256
        Top = 203
        Width = 225
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 10
      end
      object Panel4: TPanel
        Left = 8
        Top = 230
        Width = 473
        Height = 4
        TabOrder = 11
      end
      object edtValCTime: TEdit
        Left = 8
        Top = 254
        Width = 225
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 12
      end
      object btGetValCTime: TButton
        Left = 256
        Top = 254
        Width = 225
        Height = 21
        Caption = 'Get Current Time'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 13
        OnClick = btGetValCTimeClick
      end
      object edtHexValue: TEdit
        Left = 336
        Top = 20
        Width = 145
        Height = 21
        TabOrder = 14
        OnChange = edtHexValueChange
      end
      object edtHexPktVal: TEdit
        Left = 288
        Top = 62
        Width = 193
        Height = 21
        TabOrder = 15
        OnChange = edtHexPktValChange
      end
    end
    object tbHelp: TTabSheet
      Caption = 'Info'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel6: TPanel
        Left = 11
        Top = 16
        Width = 465
        Height = 233
        BevelInner = bvLowered
        BevelOuter = bvSpace
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object Label15: TLabel
          Left = 8
          Top = 180
          Width = 448
          Height = 48
          Caption = 
            'Note: BFG Team takes absolutely no responsability on the manner ' +
            'that this tool '#13'had been used. We do NOT guarantee it will work,' +
            ' nor do we guarantee that it'#39's '#13'100% undetectable. It'#39's you own ' +
            'risk. Have fun !'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Comic Sans MS'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Image1: TImage
          Left = 8
          Top = 37
          Width = 161
          Height = 137
          Center = True
          Picture.Data = {
            0A544A504547496D61676561090000FFD8FFE000104A46494600010101006000
            600000FFDB004300080606070605080707070909080A0C140D0C0B0B0C191213
            0F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F2739
            3D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232
            3232323232323232323232323232323232323232323232323232323232323232
            32323232323232323232323232FFC00011080071009003012200021101031101
            FFC4001F0000010501010101010100000000000000000102030405060708090A
            0BFFC400B5100002010303020403050504040000017D01020300041105122131
            410613516107227114328191A1082342B1C11552D1F02433627282090A161718
            191A25262728292A3435363738393A434445464748494A535455565758595A63
            6465666768696A737475767778797A838485868788898A92939495969798999A
            A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
            D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
            01010101010101010000000000000102030405060708090A0BFFC400B5110002
            0102040403040705040400010277000102031104052131061241510761711322
            328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
            292A35363738393A434445464748494A535455565758595A636465666768696A
            737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
            A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
            E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7FA
            28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A
            28A2800A28A2800A28A2800A28A2800AC6BFF16F87F4BD5A1D2AFB57B482FE62
            A23B7793E6258E178ED93EB5B35E2FE20F82971ABF8FEE75FB9D7625D367B84B
            9916542651823280F002E38073C71C71401E8FE37F13A783FC257BAD343E73C2
            A04719240676202827D326BCA7C23F117C6317C47D3B43D7EEEC6FEDF5341205
            B5D8DE4864257057A608E41CF7F6AF66D6F45B0F11E8B73A56A3089AD2E136B2
            E7F1041EC41C107DAB9FF087C32F0DF82AE25BAD32DE592EE41B7ED170FBDD57
            FBABC0007E19F7A00EC68A28A0028A28A0028A28A0028A28A0028A28A0028A28
            A0028A28A002BCA7E2A6A336BDACE8DE02D3019A5BD9D67D455491B2DD483862
            0F00F27F01EB5E95AB6A76DA369375A8DDC8B1DBDB4664766E800AF39F83DA45
            C5DC5A9F8DB538F17BADCC5E20C7718E104E003E9DBE8A2803D3E1852DE08E18
            D76C71A84503B003029F45140051451400514514005145140051451400514514
            00514562789BC5BA2F8474E6BCD5EF12118263881064948EC8BDCD006DD15E79
            E0DF1E788BC5DAC8957C2925A787254262BD9A50AF9E70707EF03D30BD3AE4D7
            A1D007977C67D56E65D3B4DF0A69E7379ACDC08DD14FCDE50EA471D3D6BD1749
            D362D1F47B3D36024C56B0A42848C6428C7F4AF26D6E46B9FDA5746865E6382C
            418C11D090E4E38AF65A0028A28A0028A28A0028A29080CA41E8463838A006A4
            B1C85823AB153B5B69CE0FA1A7D782789EC2FBE0E78D20F11E9134F3E83A94D8
            BD82672E43124B0CFD3904F39E39AF76B5B98AF6D21BA81B743346B246DEAA46
            41FC8D004B45145001451450062F8AFC4D65E12F0F5CEAF7D931C23E58D7AC8C
            7A28FAD78C782BC257FF00157C452F8CBC5BB8E98B2116B66D9DB201D1474F90
            71FEF1CFBE6C7ED0B717775A9F87B458E57582E0B36C00619CB05193ED9E9D39
            AF63B0B5B2F09F85A0B7CAC567A7DB00483C61472793DFDCD006A222451AA22A
            A2200AAAA30001D00A86DEFECEEE5962B6BB8269223B6448E40C50FA103A57CA
            3E31F1E789FE236B32C5A74379FD9F09FDCD9D923B7CB9E19F68C9278F6E95CD
            2D978A3C1F7506A5F64D4B4A9948293344D1F7070723079032A7F11401F4178F
            341D4EC3E2A786BC59A65B4B3C523ADADDF95117283B138E8A413CF6C72715EB
            35E75F0A3E232F8DF4636F7F246BACDB0C4C8005F357B381FCFDEBD16800A28A
            2800A8EE2E21B5B792E2E2548A18D4B3BB9C0503A926A4AF03F8D5E3EB9D42FC
            F81B415964919D52F0C60E646382B12E3A8F5FCBD6802B78ABE39EB5A96A9269
            BE0CB43E52B6167111965940EA42E3815BDF0EFE2378ABFB76CFC3BE33D36E52
            6BE42F697325B18DDBFDE18031EF818CD74DF0A7E1EC7E09D044D751A1D62ED4
            1B87C0CC63A88C1F41DFD48F6AEDB52B49AEF4EB886D6E4DA5D491324572A819
            A22470C01E0E2803CBFE3AEA905C68165E17B6226D5350BA8FCB851B25403D48
            EB824D7A5E8560DA5681A7D83B6E7B6B78E2639CE48500FE19AE3FC11F0AAC3C
            2D7CFABEA37926B3ADB9CFDB2E5794EDF28249CE38C939FA57A0500145145001
            4514500799FC68F05CBE26F0BADFD846CDA9E984CB108D49774FE2518E73C023
            DC5637853E24E8FE3AF05BF85B55BA4B4D6E7B56B502707CB9DB18560DD3278C
            A9E7AF5AF65AF38F157C16F0CF892F8EA1079DA5DEB3EF924B4C0573EA54F00E
            79C8C7E3401ADF0D3C2D71E13F07DB69F7F05925FA16F35ED86778DC4AE5B009
            38C575B34315C44D14D1A491B75575041FC0D71BE0CF863A4F82AFA5BEB4BED4
            6EEEA58BCA66BA9815C673C2803F5CF53EB5DB5007807C43F0949F0CFC4367E3
            7F0AA1B7B31284B9B741F247BB823191F2B74C7638E9C57B5F87B5FB1F136876
            BAB69D2AC904E80E01C946EEA7D083C55AD4F4EB5D5F4CB9D3AF6212DB5C4663
            910F706BC0747D62FBE0878E26D07556967F0D5E132C5295C951D038C0E48C61
            97E878EE01F4451542C35AD3354B34BBB1BFB7B8B771959124041AA5ABF8CBC3
            9A123B6A5ACD9405464A194173EC14724D0033C67E2487C27E14BED5E6233126
            2253FC6E78515E45F033C2736ABA9DDF8E35652EED23A5AEF5FBCE4FCF20CFA7
            2A3FE0553DECDA9FC71D7A1B6B38A5B3F0758CC1A59DFE579D867A763C6303B6
            727D2BDB6C6CADF4DB182CAD2258ADE0411C71A8C055030050058A28A2800A28
            A2800A28A2800A28A2800A28A2800A28A2800AC2F15784748F18E946C357B7F3
            10731C8A70F137F794D6ED1401F3C6A1FB3CEB36924CDA2EBF0BC6794498346C
            DD70095C8FD3BD5AF0CFECECE9751CFE25D4A392153CDADA67E7E9D5CE303AF4
            1F88AF7DA2802AE9DA6D969161158E9F6D1DB5AC4309146B80B56A8A2800A28A
            2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A
            2800A28A2800A28A2800A28A2803FFD9}
          Transparent = True
        end
        object Label17: TLabel
          Left = 184
          Top = 121
          Width = 152
          Height = 23
          Caption = 'ciobanua@gmail.com'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'Comic Sans MS'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object Label16: TLabel
          Left = 184
          Top = 105
          Width = 64
          Height = 16
          Caption = 'Contact Us:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Comic Sans MS'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label14: TLabel
          Left = 192
          Top = 64
          Width = 54
          Height = 48
          Caption = 'PavkaM'#13'TheSelby'#13'Seth'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clActiveCaption
          Font.Height = -12
          Font.Name = 'Comic Sans MS'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label13: TLabel
          Left = 184
          Top = 49
          Width = 64
          Height = 16
          Caption = 'Created By:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Comic Sans MS'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label12: TLabel
          Left = 248
          Top = 8
          Width = 128
          Height = 27
          Caption = 'WoW RE Tool'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = cl3DDkShadow
          Font.Height = -19
          Font.Name = 'Comic Sans MS'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
  end
  object dlgSave: TSaveDialog
    FilterIndex = 0
    Left = 388
    Top = 172
  end
  object KeyTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = KeyTimerTimer
    Left = 420
    Top = 136
  end
  object pmTray: TPopupMenu
    Images = MenuImages
    OnPopup = pmTrayPopup
    Left = 348
    Top = 104
    object miRestart: TMenuItem
      Caption = 'Restart'
      ImageIndex = 3
      OnClick = miRestartClick
    end
    object miStop: TMenuItem
      Caption = 'Stop'
      ImageIndex = 0
      OnClick = miStopClick
    end
    object miStart: TMenuItem
      Caption = 'Start'
      ImageIndex = 2
      OnClick = miStartClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object miRestore: TMenuItem
      Caption = 'Restore'
      ImageIndex = 4
      OnClick = miRestoreClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miExit: TMenuItem
      Caption = 'Exit'
      ImageIndex = 1
      OnClick = miExitClick
    end
  end
  object MenuImages: TImageList
    Left = 452
    Top = 136
    Bitmap = {
      494C010105000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      00000000000000000000000000000000000000000000F7F7F700525252007373
      7300B5B5B500F7F7F70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000042424200737373008484
      840052525200181818003131310073737300B5B5B500F7F7F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000021212100BDBDBD00C6C6
      C600E7E7E700E7E7E700C6C6C6008C8C8C005252520029292900313131007373
      7300B5B5B500F7F7F70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000031313100BDBDBD00A5A5
      A5009C8C8400D6CEBD0000000000FFFFFF00F7F7F700EFEFEF00D6D6D6009C9C
      9C00636363002929290042424200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000031313100BDBDBD00A5A5
      A500735242006329000063290000946B4A00BD9C8C00DECEC60000000000FFFF
      FF00F7F7F700EFEFEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000031313100BDBDBD00A5A5
      A5006B5242006329000063290000733108007339100073311000733110009463
      4A00C6B5A500F7F7F70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000031313100BDBDBD00A5A5
      A5006B5242005A29000063290000733108007B3910007B391000733110007331
      080094634A00F7F7F70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000031313100C6C6C600A5A5
      A500846B6300E7D6CE0084634200EFE7DE00C6AD9C007B3918007B3910007331
      100094634A00F7F7F70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000031313100C6C6C600A5A5
      A500846B6300E7D6CE00EFE7DE006329000084422100843918007B3910007331
      100094634A00F7F7F70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000031313100CECECE00A5A5
      A500735A52009C8473005A29000063290000632900007B3918007B3910007331
      100094634A00F7F7F70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000039393900D6D6D600ADAD
      AD00949494008C8C8C0084848400736B6300735242006B4221007B3910007331
      100094634A00F7F7F70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000021212100A5A5A500D6D6
      D600D6D6D600C6C6C600B5B5B500A5A5A5009C9C9C008C8C8C00848484007B6B
      63008C736300EFEFEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6D6D600737373003131
      310029292900636363009C9C9C00BDBDBD00CECECE00C6C6C600B5B5B500A5A5
      A5009C9C9C00CECECE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7F7F700B5B5B500737373003131310018181800525252008C8C8C00BDBD
      BD00CECECE00C6C6C60008080800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F700C6C6C600848484004242
      4200181818000808080073737300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000008080000000000181010001810100018101000181010001810
      1000181010001810100010080800424242000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000101800084A6B000842630018394A00313139004A2929006B423900734A
      4200734A4200734A420052313100424242000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000001018001029390021212100737373000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000949494007373
      73000010180010527B002163840029739400317B9C0031739400295A6B002939
      4200392931005A3931004A292900424242000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000021292900215A73004AB5F700295A9C001818
      3100A5A5A5000000000000000000000000000000000000000000000000000000
      0000313131000810520008084200313131000000000000000000101018000008
      4A000000310063636300000000000000000000000000313131008C8C8C002929
      29000010100021638400317394003984A5004A8CAD004A94B5004A94B5004A8C
      AD003984A5002918100039212100424242000000000000000000000000000000
      00003131310021212100A5A5A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000073737300082129004AC6E7004284
      EF0010214A009494940000000000000000000000000000000000000000000000
      000018185A002121CE001821C60010107B003131310010101800101094001018
      B5001010AD00000021000000000000000000636363008C8C8C00E7F7FF00E7F7
      FF005A5A5A00102931004284A5004A94B5005A9CBD005AA5C6005AA5C6005A9C
      BD004A94B5002110100031181800424242000000000000000000000000000000
      00003121210031DE7B004A39310021212100A5A5A50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000001021004AC6
      F7004273EF000810290000000000000000000000000000000000000000000000
      000021215A003942D6002121CE002121C60010107B0018189C001818BD001818
      BD001018B500000021000000000000000000B5B5B50029292900E7F7FF00E7F7
      FF00E7F7FF006B6B6B00081821005294B5005AA5C6005AA5C6005AA5C6005AA5
      C6005A9CBD001008080021101000424242000000000000000000000000000000
      00002921210021CE630018CE5A0029CE6B004A39310021212100A5A5A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000821000010310000000000636363002163
      8C004A94FF002952AD0063636300000000000000000000000000000000000000
      00003131310031398C00424ADE002129CE002121CE002121CE002121C6001821
      C6000808420063636300000000000000000000000000A5A5A50031313100CECE
      CE00E7F7FF00E7F7FF009C9C9C00101821005AA5C600296B9C000863A5001052
      8C005AA5C6000808080010080800424242000000000000000000000000000000
      00002921180021BD5A0008B5420008B5420018BD520029C66300423131002121
      2100A5A5A5000000000000000000000000000000000000000000000000000000
      00000000000042424200081852001842B5000010310000000000737373001842
      7300427BFF004273EF0042424200000000000000000000000000000000000000
      0000000000003131310031398C003131DE002929D6002129CE002121CE000808
      4A006363630000000000000000000000000000000000D6D6D600313131009C9C
      9C00E7F7FF00E7F7FF00CECECE00101818004A8CB50084B5D6009CCEEF00106B
      B5004A8CB5000000000008000000424242000000000000000000000000000000
      00002921180021B5520008AD390008AD390008AD390010AD420018B5520029BD
      63004231290021212100B5B5B500000000000000000000000000000000000000
      00001010180008217B001839BD00214AC600001031000000000008214A00296B
      CE00427BFF00427BFF0042424200000000000000000000000000000000000000
      000000000000101018002929BD003131E7003131DE002929DE002929D6001818
      840031313100000000000000000000000000D6D6D60021212100E7F7FF00E7F7
      FF00E7F7FF00ADADAD00101818004A849C005AA5C6006B8CB500CEE7F700216B
      A500529CBD000000000000000000424242000000000000000000000000000000
      00002918180021B5520008AD390008AD390008AD390008AD390008AD390010B5
      4A0029BD630039C6730021212100000000000000000000000000000000000000
      210008189C002142CE004273FF002152CE00184AC600215AC6002963D6003973
      F700427BFF003963CE0042424200000000000000000000000000000000000000
      0000181818003131C6003939EF003939EF003131E7004A4AE7003131DE002929
      DE0018188400424242000000000000000000636363009C9C9C00E7F7FF00E7F7
      FF009C9C9C0008101800397B9C005294B5005AA5BD005A9CBD004284AD00529C
      BD005294B5000000000000000000424242000000000000000000000000000000
      00002118180021BD5A0008B5420008B5420008B5420008B5420018BD520029C6
      63003929210021212100B5B5B500000000000000000000000000082152001039
      BD00315AE700427BFF00427BFF00396BF700396BEF004273FF00427BFF00427B
      FF00427BFF0021397B0094949400000000000000000000000000000000000000
      0000424263004242F7003942F7003939F70010105A004A4A8C005A5AE7003131
      E7003131DE000808310000000000000000000000000021212100BDBDBD006B6B
      6B000008080021638400317B9C004284A5004A94B500529CB500529CB5004A94
      B5004284A5000000000000000000424242000000000000000000000000000000
      00002918180018CE5A0000C6420008C64A0018CE5A0029CE6B00423129002121
      2100A5A5A500000000000000000000000000000000000000000008212900399C
      BD004AA5F700427BFF00427BFF00427BFF00427BFF00427BFF00427BFF00427B
      FF00396BCE002121310000000000000000000000000000000000000000000000
      000039395A007B7BEF005252F70010185A0063636300313131004A528C006363
      E700424AE7000808290000000000000000000000000000000000525252004242
      420000101800185A7B00216B8C0031739400397B9C004284A5004284A500397B
      9C00317394000000000000000000424242000000000000000000000000000000
      00002921210021D66B0010D65A0029DE73004A39390021212100A5A5A5000000
      0000000000000000000000000000000000000000000000000000000000001018
      180039A5B50052CEFF00427BFF00427BFF0052C6FF0052DEFF0052CEEF00317B
      8C00101821000000000000000000000000000000000000000000000000000000
      0000313131002929390018182900636363000000000000000000313131002121
      3900101829006363630000000000000000000000000000000000000000000000
      0000000810000839520010425A00184A630018526B0021526B0021526B001852
      6B00184A63000000000000000000424242000000000000000000000000000000
      00003129290031E784005242420021212100A5A5A50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000031313100399C9C005AF7FF004A9CFF001018390000000000313131008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424242004242420042424200424242004242420042424200424242004242
      4200424242004242420042424200737373000000000000000000000000000000
      00003131310021212100A5A5A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000042424200215A5A005AFFFF000818180000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000063636300184A4A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0083FF000000000000803F000000000000
      8003000000000000820100000000000080210000000000008001000000000000
      8001000000000000800100000000000080010000000000008001000000000000
      800100000000000080010000000000008001000000000000F001000000000000
      FF01000000000000FFFF000000000000FFFFF000FFFFFFFFFFFFF000FFFFFE1F
      FFFFC000FFFFFE07F0C38000F1FFFF03F0030000F07FFFC3F0030000F01FFC41
      F0038000F007F841F8078000F001F001F8070000F001E001F0030000F001C001
      F0038000F007C003F003C000F01FE007F0C3F000F07FF00FFFFFF000F1FFF87F
      FFFFFFFFFFFFFC7FFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object LogSwapper: TTimer
    Interval = 10000
    OnTimer = LogSwapperTimer
    Left = 388
    Top = 136
  end
  object dlgOpen: TOpenDialog
    Left = 272
    Top = 104
  end
end
