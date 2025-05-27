object dmConexao: TdmConexao
  Height = 480
  Width = 640
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'Database=savr'
      'Password=root'
      'Server=localhost'
      'User_Name=root'
      'TinyIntFormat=Boolean')
    LoginPrompt = False
    Left = 232
    Top = 224
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\Ana Clara\Documents\Embarcadero\Studio\Projects\Savr\li' +
      'bmySQL.dll'
    Left = 424
    Top = 144
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 216
    Top = 136
  end
end
