unit Version;

interface

const
  { Versioning Information }

  ToolVersion = '3.0.2';
  ToolAuthor  = 'BFG Team';


  WoWClients = 5;
  WoWClientsVer: array[1..WoWClients] of String =
    ('2.0.6', '2.0.7', '2.0.8', '2.0.9', '2.0.10');

  { Registry Options }
  KeyOptions  = '\Software\RETool';
  KeyName     = '\Software\RETool\SnifferPlugins';
  KeyIsGlobal = False;

  ValuePluginEnabled = 'plugin_%d_enabled';

  { Some Other Constants }

  MaxCacheSize = 2000000;

implementation

end.
