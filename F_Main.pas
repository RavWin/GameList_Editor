unit F_Main;

interface

uses
   Winapi.Windows, Winapi.Messages, Winapi.ShellAPI,
   System.SysUtils, System.Variants, System.Classes, System.IniFiles, System.Generics.Collections,
   System.RegularExpressions, System.UITypes, System.ImageList, System.StrUtils, System.IOUtils, System.Math,
   System.SyncObjs, System.Generics.Defaults,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Styles, Vcl.Themes, Vcl.ImgList,
   Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls,
   Xml.omnixmldom, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, Xml.Win.msxmldom,
   F_MoreInfos, F_About, F_Help, F_ConfigureSSH, U_gnugettext, U_Resources, U_Game,
   F_ConfigureNetwork, F_AdvNameEditor, U_DownloadThread, IdURI,
   RVer,
   Vcl.OleCtrls, WMPLib_TLB, System.Net.URLClient,
   System.Net.HttpClient, System.Net.HttpClientComponent, System.Actions,
  Vcl.ActnList, Vcl.Mask, Vcl.VirtualImageList, Vcl.BaseImageCollection,
  Vcl.ImageCollection;

type
   TMediaInfo = class
      FileExt: string;
      FileLink: string;
   end;

   //Stores which media types exist for a game (gamelist paths + media folder scan)
   TGameMediaStatus = record
      HasImage: Boolean;
      HasVideo: Boolean;
      HasBox: Boolean;
      HasManual: Boolean;
      HasWheel: Boolean;
      HasTips: Boolean;
      HasMap: Boolean;
   end;

   TFrm_Editor = class(TForm)
      Pnl_Background: TPanel;
      Pgc_Editor: TPageControl;
      Tbs_Main: TTabSheet;
      Tbs_Scrape: TTabSheet;
      ProgressBar: TProgressBar;
      ProgressBarScrape: TProgressBar;
      XMLDoc: TXMLDocument;
      OpenDialog: TFileOpenDialog;
      MainMenu: TMainMenu;
      Mnu_File: TMenuItem;
      Mnu_Choosefolder: TMenuItem;
      Mnu_Quit: TMenuItem;
      Mnu_Actions: TMenuItem;
      Mnu_System: TMenuItem;
      Mnu_LowerCase: TMenuItem;
      Mnu_UpperCase: TMenuItem;
      Mnu_RemoveRegion: TMenuItem;
      Mnu_DeleteOrphans: TMenuItem;
      Mnu_DeleteDuplicates: TMenuItem;
      Mnu_ExportTxt: TMenuItem;
      Mnu_ReloadGameList: TMenuItem;
      Mnu_Game: TMenuItem;
      Mnu_GaLowerCase: TMenuItem;
      Mnu_GaUpperCase: TMenuItem;
      Mnu_Selection: TMenuItem;
      Mnu_SetHidden: TMenuItem;
      Mnu_SetNoHidden: TMenuItem;
      Mnu_SetFavorite: TMenuItem;
      Mnu_SetNoFavorite: TMenuItem;
      Mnu_NameEditor: TMenuItem;
      Mnu_Options: TMenuItem;
      Mnu_General: TMenuItem;
      Mnu_GodMode: TMenuItem;
      Mnu_DeleteWoPrompt: TMenuItem;
      Mnu_AutoHash: TMenuItem;
      Mnu_PiPrompts: TMenuItem;
      Mnu_ShowTips: TMenuItem;
      Mnu_Genesis: TMenuItem;
      N3: TMenuItem;
      Mnu_NetWork: TMenuItem;
      Mnu_ConfigureNetwork: TMenuItem;
      N2: TMenuItem;
      Mnu_SSH: TMenuItem;
      Mnu_ConfigSSH: TMenuItem;
      N1: TMenuItem;
      Mnu_Theme: TMenuItem;
      Mnu_Theme1: TMenuItem;
      Mnu_Theme2: TMenuItem;
      Mnu_Theme3: TMenuItem;
      Mnu_Theme4: TMenuItem;
      Mnu_Theme5: TMenuItem;
      Mnu_Theme6: TMenuItem;
      Mnu_Theme9: TMenuItem;
      Mnu_Theme10: TMenuItem;
      Mnu_Theme11: TMenuItem;
      Mnu_Theme12: TMenuItem;
      Mnu_Theme13: TMenuItem;
      Mnu_Theme15: TMenuItem;
      Mnu_Theme16: TMenuItem;
      Mnu_Theme17: TMenuItem;
      N4: TMenuItem;
      Mnu_Language: TMenuItem;
      Mnu_Lang1: TMenuItem;
      Mnu_Lang2: TMenuItem;
      Mnu_Lang3: TMenuItem;
      Mnu_Lang4: TMenuItem;
      Mnu_Lang5: TMenuItem;
      Mnu_Help: TMenuItem;
      Mnu_About: TMenuItem;
      OpenFile: TOpenDialog;
      Img_List: TImageList;
      SaveDialog: TSaveDialog;
      Pnl_Top: TPanel;
      Scl_Pictures: TScrollBox;
      Img_ScreenScraper: TImage;
      Btn_Scrape: TButton;
      Img_Loading: TImage;
      Mmo_ScrapeDescription: TMemo;
      Lbl_ScrapeDescription: TLabel;
      Lbl_ScrapeGenre: TLabel;
      Edt_ScrapeGenre: TEdit;
      Lbl_ScrapeDeveloper: TLabel;
      Edt_ScrapeDeveloper: TEdit;
      Lbl_ScrapePublisher: TLabel;
      Edt_ScrapePublisher: TEdit;
      Lbl_ScrapeRating: TLabel;
      Edt_ScrapeRating: TEdit;
      Lbl_ScrapePlayers: TLabel;
      Edt_ScrapePlayers: TEdit;
      Lbl_ScrapeDate: TLabel;
      Edt_ScrapeDate: TEdit;
      Edt_ScrapeRegion: TEdit;
      Lbl_ScrapeRegion: TLabel;
      Edt_ScrapeName: TEdit;
      Lbl_ScrapeName: TLabel;
      Img_ScrapeBackground: TImage;
      Img_Scrape: TImage;
      Btn_ScrapeSave: TButton;
      Edt_ScrapeRomPath: TEdit;
      Btn_ScrapeLower: TButton;
      Btn_ScrapeUpper: TButton;
      Chk_ScrapePicture: TCheckBox;
      Chk_ScrapeVideo: TCheckBox;
      Chk_ScrapeInfos: TCheckBox;
      Chk_ManualCRC: TCheckBox;
      Edt_ManualCRC: TEdit;
      Chk_Box2D: TCheckBox;
      Chk_Box3D: TCheckBox;
      Chk_Mix1: TCheckBox;
      Chk_Mix2: TCheckBox;
      Chk_Screenshot: TCheckBox;
      Chk_Title: TCheckBox;
      Chk_ArcadeBox: TCheckBox;
      Chk_Wheel: TCheckBox;
      Chk_Video: TCheckBox;
      Mnu_Reload: TMenuItem;
      Net_HTTPClient: TNetHTTPClient;
    pSystemControls: TPanel;
    Edt_RomPath: TEdit;
    pSystems: TPanel;
    Lbl_SelectSystem: TLabel;
    Lbl_Filter: TLabel;
    Lbl_Search: TLabel;
    Cbx_Systems: TComboBox;
    Cbx_Filter: TComboBox;
    Edt_Search: TEdit;
    Chk_ListByRom: TCheckBox;
    Chk_FullRomName: TCheckBox;
    Img_System: TImage;
    Lbl_NbGamesFound: TLabel;
    pGameEdit: TPanel;
    Pgc_Media: TPageControl;
    Tbs_Picture: TTabSheet;
    Img_Game: TImage;
    Img_BackGround: TImage;
    Tbs_Video: TTabSheet;
    Img_BackgroundVideo: TImage;
    pGameData: TPanel;
    Lbl_Name: TLabel;
    Lbl_Region: TLabel;
    Lbl_Date: TLabel;
    Lbl_Players: TLabel;
    Lbl_Rating: TLabel;
    Lbl_Hidden: TLabel;
    Lbl_Favorite: TLabel;
    Lbl_Publisher: TLabel;
    Lbl_Developer: TLabel;
    Lbl_Genre: TLabel;
    Lbl_Description: TLabel;
    Lbl_KidGame: TLabel;
    Mmo_Description: TMemo;
    Edt_Rating: TEdit;
    Edt_ReleaseDate: TEdit;
    Edt_Developer: TEdit;
    Edt_Publisher: TEdit;
    Edt_Genre: TEdit;
    Edt_NbPlayers: TEdit;
    Edt_Name: TEdit;
    Btn_SaveChanges: TButton;
    Edt_Region: TEdit;
    Btn_MoreInfos: TButton;
    Btn_Delete: TButton;
    Cbx_Hidden: TComboBox;
    Cbx_Favorite: TComboBox;
    Cbx_KidGame: TComboBox;
    Img_Logo: TImage;
    tsControls: TTabSheet;
    Btn_ChangeImage: TButton;
    Btn_SetDefaultPicture: TButton;
    Btn_ChangeAll: TButton;
    Btn_RemovePicture: TButton;
    Btn_ChangeVideo: TButton;
    Btn_RemoveVideo: TButton;
    bScrape: TButton;
    pmGameList: TPopupMenu;
    pm_RemoveFromList: TMenuItem;
    pm_FindStale: TMenuItem;
    pm_FindImage: TMenuItem;
    pm_FindVideo: TMenuItem;
    alMain: TActionList;
    aViewGame: TAction;
    aViewScraper: TAction;
    tsGameList: TTabSheet;
    aViewGameLists: TAction;
    lbRoms: TListBox;
    bScanFolder: TButton;
    leROMext: TLabeledEdit;
    mLog: TMemo;
    bAddToList: TButton;
    cbSortList: TComboBox;
    bFindDupes: TButton;
    pm_SaveGameList: TMenuItem;
    Mnu_AutoLoadOnStart: TMenuItem;
    pm_ScanForROMs: TMenuItem;
    pmPicture: TPopupMenu;
    pmVideo: TPopupMenu;
    pm_ChangeImage: TMenuItem;
    pm_SetDefaultPicture: TMenuItem;
    pm_ChangeAllPictures: TMenuItem;
    pm_RemovePicture: TMenuItem;
    pm_ChangeVideo: TMenuItem;
    pm_RemoveVideo: TMenuItem;
    lbListRoms: TListBox;
    pm_FileNameToGameName: TMenuItem;
    FindDuplicates: TMenuItem;
    aFindDuplicates: TAction;
    icSystems: TImageCollection;
    icDefault: TImageCollection;

      procedure FormCreate(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
      procedure Cbx_SystemsChange(Sender: TObject);
      procedure Mnu_QuitClick(Sender: TObject);
      procedure Mnu_ChoosefolderClick(Sender: TObject);
      procedure Btn_SaveChangesClick(Sender: TObject);
      procedure FieldChange(Sender: TObject);
      procedure Mmo_DescriptionKeyPress(Sender: TObject; var Key: Char);
      procedure Btn_ChangeImageClick(Sender: TObject);
      procedure Btn_SetDefaultPictureClick(Sender: TObject);
      procedure Cbx_FilterChange(Sender: TObject);
      procedure Btn_ChangeAllClick(Sender: TObject);
      procedure Btn_MoreInfosClick(Sender: TObject);
      procedure Mnu_GodModeClick(Sender: TObject);
      procedure Mnu_AutoHashClick(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure Btn_DeleteClick(Sender: TObject);
      procedure Mnu_DeleteWoPromptClick(Sender: TObject);
      procedure ChangeCaseClick(Sender: TObject);
      procedure ChangeCaseGameClick(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure Btn_RemovePictureClick(Sender: TObject);
      procedure Mnu_AboutClick(Sender: TObject);
      procedure Mnu_RemoveRegionClick(Sender: TObject);
      procedure Mnu_ThemeClick(Sender: TObject);
      procedure Mnu_GenesisClick(Sender: TObject);
      procedure Mnu_HelpClick(Sender: TObject);
      procedure Mnu_ShowTipsClick(Sender: TObject);
      procedure Mnu_PiPromptsClick(Sender: TObject);
      procedure Mnu_ConfigSSHClick(Sender: TObject);
      procedure Mnu_LangClick(Sender: TObject);
      procedure Edt_SearchChange(Sender: TObject);
      procedure Mnu_DeleteOrphansClick(Sender: TObject);
      procedure Mnu_DeleteDuplicatesClick(Sender: TObject);
      procedure Btn_ScrapeClick(Sender: TObject);
      procedure Mnu_ConfigureNetworkClick(Sender: TObject);
      procedure Mnu_SetHiddenClick(Sender: TObject);
      procedure Mnu_SetNoHiddenClick(Sender: TObject);
      procedure Mnu_SetFavoriteClick(Sender: TObject);
      procedure Mnu_SetNoFavoriteClick(Sender: TObject);
      procedure Chk_ListByRomClick(Sender: TObject);
      procedure Mnu_NameEditorClick(Sender: TObject);
      procedure Mnu_ExportTxtClick(Sender: TObject);
      procedure Mnu_ReloadGameListClick(Sender: TObject);
      procedure Chk_FullRomNameClick(Sender: TObject);
      procedure Tbs_ScrapeShow(Sender: TObject);
      procedure Tbs_ScrapeHide(Sender: TObject);
      procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
                MousePos: TPoint; var Handled: Boolean);
      procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
                MousePos: TPoint; var Handled: Boolean);
      procedure ImgScrapedClick(Sender: TObject);
      procedure Btn_ScrapeSaveClick(Sender: TObject);
      procedure Btn_ScrapeUpperClick(Sender: TObject);
      procedure Btn_ScrapeLowerClick(Sender: TObject);
      procedure Chk_ScrapeClick(Sender: TObject);
      procedure Chk_ManualCRCClick(Sender: TObject);
      procedure Mnu_ReloadClick(Sender: TObject);
      procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
      procedure Pgc_MediaChange(Sender: TObject);
      procedure Btn_ChangeVideoClick(Sender: TObject);
      procedure Btn_RemoveVideoClick(Sender: TObject);
    procedure aViewGameExecute(Sender: TObject);
    procedure aViewScraperExecute(Sender: TObject);
    procedure aViewGameListsExecute(Sender: TObject);
    procedure bScanFolderClick(Sender: TObject);
    procedure bAddToListClick(Sender: TObject);
    procedure pm_RemoveFromListClick(Sender: TObject);
    procedure pm_FindStaleClick(Sender: TObject);
    procedure pm_SaveGameListClick(Sender: TObject);
    procedure Mnu_AutoLoadOnStartClick(Sender: TObject);
    procedure pm_ScanForROMsClick(Sender: TObject);
    procedure pmGameListPopup(Sender: TObject);
    procedure lbListRomsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lbListRomsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbSortListChange(Sender: TObject);
    procedure bFindDupesClick(Sender: TObject);
    procedure pmPicturePopup(Sender: TObject);
    procedure pmVideoPopup(Sender: TObject);
    procedure lbListRomsClick(Sender: TObject);
    procedure aFindDuplicatesExecute(Sender: TObject);
    procedure Mnu_FileNameToGameNameClick(Sender: TObject);
    procedure pm_FindImageClick(Sender: TObject);
    procedure pm_FindVideoClick(Sender: TObject);

   private

      FThemeNumber, FLanguage: Integer;
      FRootPath: string;
      FCurrentFolder: string;
      FSelectedSystem: string;
      FImageFolder: string;
      FVideoFolder: string;
      FVideoScrapeLink: string;
      FIsLoading: Boolean;
      FGodMode, FAutoHash, FDelWoPrompt, FGenesisLogo,
      FShowTips, FFolderIsOnPi, FPiPrompts, FSysIsRecal,
      FPiLoadedOnce, FGameListChanged, FChangingSystem,
      FSuppressDialogs: Boolean;
      FRecalLogin, FRecalPwd, FRetroLogin, FRetroPwd: string;
      FSSLogin, FSSPwd: string;
      FScrapedGame: TGame;
      FIsWine: Boolean;
      GSystemList: TObjectDictionary<string,TObjectList<TGame>>;
      Wmp_Video: TWindowsMediaPlayer;

      FAutoLoadOnStart: Boolean; // Auto Load Last Root Folder on start

      FPrevWinControl: TWinControl;

      //For the "Game List" tab: advanced game list with media statuses
      FRomsSortMode: Integer;
      FRomsStatusMap: TDictionary<TGame, TGameMediaStatus>;
      FFilteredGames: TList<TGame>;

      //Context menu (pmGameList) source: lbListRoms
      FMenuSourceList: TListBox;

      //For the scrape
      FPictureLinks: TObjectList<TMediaInfo>;
      FInfosList: TStringList;
      FMaxThreads, FThreadCount, FStartCount: Integer;
      FTempXmlPath: string;

      procedure LoadFromIni;
      procedure SaveToIni;
      procedure BuildSystemsList( aReload : Boolean = False );
      procedure LoadGamesList( const aSystem: string );
      procedure LoadGame( aGame: TGame );
      procedure ClearAllFields;
      procedure SaveBatchChangesToGamelist;
      procedure SaveChangesToGamelist( aScrape, aSaveVideo, aSavePic, aSaveInfos: Boolean );
      procedure EnableControls( aValue: Boolean );
      procedure EnableComponents( aValue: Boolean );
      procedure CheckIfChangesToSave;
      procedure ChangeImage( const aPath: string; aGame: TGame );
       procedure ApplyGameImage( aGame: TGame );
      procedure ChangeVideo( const aPath: string; aGame: TGame );
      procedure LoadSystemLogo( const aPictureName: string );
      procedure DeleteGame( aGame: TGame; reloadGameList: Boolean = True );
      procedure DeleteGamePicture;
      procedure DeleteGameVideo;
      procedure StartGameVideo( const aPath: string );
      procedure StopGameVideo;
      procedure CheckMenuItem( aNumber: Integer; aLang: Boolean = False );
      procedure RemoveRegionFromGameName( aGame: TGame; aStartPos: Integer );
      procedure ConvertFieldsCase( aGame: TGame; aUnique: Boolean = False;
                                   aUp: Boolean = False );
      procedure StopOrStartES( aStop, aRecal: Boolean );
      procedure DeleteDuplicates( const aSystem: string );
      procedure ReloadIni;
      procedure SetFavOrHidden( aFav, aValue: Boolean );
      procedure TransformGamesNames( aRemChars, aAddChars, aChangecase: Boolean;
                                     aNbStart, aNbEnd, aCaseIndex: Integer;
                                     const aStringStart, aStringEnd : string );
      procedure ExportToTxt;
      procedure CreateWindowsMediaPlayer;

      function IsRunningUnderWine: Boolean;
      function getSystemKind: TSystemKind;
      function getCurrentFolderName: string;
      function GetCurrentLogoName: string;
      function GetCurrentSystemId: string;
      function GetCountryEnum( const aShortName: string ): TCountryName;
      function BuildGamesList( const aPathToFile: string; aProgress: Boolean = False ): TObjectList<TGame>;
      function CountGamesInFile( const aPathToFile: string ): Integer;
      function FormatDateFromString( const aDate: string; aIso: Boolean = False ): string;
      function GetThemeEnum( aNumber: Integer ): TThemeName;
      function GetLangEnum( aNumber: Integer ): TLangName;
      function GetPhysicalRomPath( const aRomPath: string ): string;
      function GetPhysicalMediaPath( const aPath: string ): string;
      function MyMessageDlg( const Msg: string; DlgTypt: TmsgDlgType; button: TMsgDlgButtons;
                            Caption: array of string; dlgcaption: string ): Integer;

      //Methods related to the scrape tab
      procedure ClearScrapeMedia;
      procedure ParseXml;
      procedure DisplayPictures;
      procedure FillFields;
      procedure EnableScrapeComponents( aValue: Boolean );
      procedure GetPictures;
      procedure GetPicture( aMedia: TMediaInfo );
      procedure ThreadTerminated( Sender: TObject );
      procedure EmptyScrapeFields;
      procedure ConvertScrapeToUpOrLow( aUp: Boolean = False );
      procedure UpdateVideo( aGame: TGame );
      procedure SaveLinkToFile( aLink, aPath: string );

      function GetGameXml( const aSysId: string; aGame: TGame ): Boolean;
      function GetFileSize( const aPath: string ): string;

      procedure FindGameRoms( const aSystem: string );
      procedure SaveGamelist(const FileName: string; aGameList: TObjectList<TGame>);
      procedure AddRomList(aRoms: TStrings);
      procedure RefreshListRoms;
      procedure FileNameToGameName;
      function ConfirmSaveGameList( aOnSwitch: Boolean ): Boolean;
      function GetGameMediaStatus( aGame: TGame ): TGameMediaStatus;
      function GetImageFolderPath: string;
      function GetVideoFolderPath: string;
      function EnsureMediaFolder( const aFolderRel: string ): Boolean;
      procedure ScrapeAndApplySelectedGames;
      procedure FindImageInSubfolders;
      procedure FindVideoInSubfolders;
      procedure WMAutoLoad( var Msg: TMessage ); message WM_APP + 1;


   public
      FProxyServer, FProxyUser,
      FProxyPwd, FProxyPort: string;
      FProxyUse: Boolean;
      FImgList: TObjectList<TImage>;
      procedure WarnUser( const aMessage: string );
      procedure WarnUserWithSafeUrl( const aMessage, aMessage2, aUrl: string );
      function SetFocusedControl( Control: TWinControl ): Boolean; override;

   end;

var
   Frm_Editor: TFrm_Editor;
   //lock for the thread counter (prevents concurrent access)
   CounterGuard: TCriticalSection;

implementation

{$R *.dfm}

function TFrm_Editor.IsRunningUnderWine: Boolean;
var
   Handle: THandle;
begin
   Handle := GetModuleHandle('ntdll.dll');
   Result := (Handle <> 0) and (GetProcAddress(Handle, 'wine_get_version') <> nil);
end;

function TFrm_Editor.SetFocusedControl(Control: TWinControl): Boolean;
begin
   if ( Control = Btn_SaveChanges ) and ( ActiveControl is TEdit ) then
      FPrevWinControl := ActiveControl;
   Result:= inherited SetFocusedControl(Control);
end;

function TFrm_Editor.GetPhysicalRomPath( const aRomPath: string ): string;
begin
   Result:= FRootPath + FCurrentFolder + aRomPath;
   Result:= StringReplace( Result, '/', '\', [rfReplaceAll] );
end;

function TFrm_Editor.GetPhysicalMediaPath( const aPath: string ): string;
begin
   if aPath.IsEmpty then Result:= ''
   else begin
      Result:= FRootPath + FCurrentFolder + aPath;
      Result:= StringReplace( Result, '/', '\', [rfReplaceAll] );
   end;
end;

//Returns the folder (relative, with trailing slash, as stored in the gamelist
//xml) in which the game images are saved. If no game has an image yet, falls
//back to the standard "media/images" folder.
function TFrm_Editor.GetImageFolderPath: string;
begin
   //The leading "./" matches the format the consoles (e.g. the R36H) expect
   //for image/video paths in gamelist.xml.
   if FImageFolder.IsEmpty then
      Result:= './' + Cst_MediaFolderName + '/' + Cst_MediaImageSubFolder + '/'
   else if Copy( FImageFolder, 1, 2 ) = './' then
      Result:= FImageFolder
   else
      Result:= './' + FImageFolder;
end;

//Returns the folder (relative, with trailing slash) in which the game videos
//are saved. Falls back to the standard "media/videos" folder when none exists.
function TFrm_Editor.GetVideoFolderPath: string;
begin
   //The leading "./" matches the format the consoles (e.g. the R36H) expect
   //for image/video paths in gamelist.xml.
   if FVideoFolder.IsEmpty then
      Result:= './' + Cst_MediaFolderName + '/' + Cst_MediaVideoSubFolder + '/'
   else if Copy( FVideoFolder, 1, 2 ) = './' then
      Result:= FVideoFolder
   else
      Result:= './' + FVideoFolder;
end;

//Ensures the given relative media folder exists on disk. If it is missing,
//prompts the user and creates it on confirmation. Returns True when the folder
//is (or was made) available, False if the user declined or an error occurred.
function TFrm_Editor.EnsureMediaFolder( const aFolderRel: string ): Boolean;
var
   FullPath: string;
begin
   Result:= True;
   FullPath:= FRootPath + FCurrentFolder +
              StringReplace( aFolderRel, '/', '\', [rfReplaceAll] );
   if DirectoryExists( FullPath ) then Exit;

   if MyMessageDlg( Rst_CreateFolder, mtConfirmation, [mbYes, mbNo],
                    [Rst_Yes, Rst_No], Rst_Info ) <> mrYes then begin
      Result:= False;
      Exit;
   end;

   try
      TDirectory.CreateDirectory( FullPath );
      Result:= DirectoryExists( FullPath );
   except
      on E: Exception do begin
         WarnUser( Rst_CreateFolderError + sLineBreak + E.Message );
         Result:= False;
      end;
   end;
end;

//Properly formats the date from the string retrieved from the xml
//or returns an ISO-formatted date for saving depending on the call (aIso)
function TFrm_Editor.FormatDateFromString( const aDate: string; aIso: Boolean = False ): string;
var
   FullStr, Day, Month, Year: string;
   DayInt, MonthInt, YearInt: Integer;
begin
   FullStr:= aDate;
   Result:= '';

   //if we format for display and the passed string
   //matches the criteria
   if ( not aIso ) and ( FullStr.Contains( Cst_DateSuffix ) ) then begin
      SetLength( FullStr, 8 );
      Day:= Copy( FullStr, 7, 2 );
      Month:= Copy( FullStr, 5, 2 );
      Year:= Copy( FullStr, 1, 4 );
      if ( TryStrToInt( Day, DayInt ) ) and ( DayInt > 0 ) then
         Result:= Result + Day + '/';
      if ( TryStrToInt( Month, MonthInt ) ) and ( MonthInt > 0 ) then
         Result:= Result + Month + '/';
      if ( TryStrToInt( Year, YearInt ) ) and ( YearInt > 0 ) then
         Result:= Result + Year;

      //otherwise if we format for saving to the .xml
      //and the string contains only digits or /
   end else if aIso and ( TRegEx.IsMatch( FullStr, '^[0-9]' ) ) then begin

      //if the string is 4 characters long
      if ( Length( FullStr) = 4 ) then
         Result:= FullStr + Cst_DateLongFill + Cst_DateSuffix;

      //if the string is 7 characters long
      if ( Length( FullStr) = 7 ) then begin
         Month:= Copy( FullStr, 1, 2 );
         Year:= Copy( FullStr, 4, 4 );
         Result:= Year + Month + Cst_DateShortFill + Cst_DateSuffix;
      end;

      //if the string is 10 characters long
      if ( Length( FullStr) = 10 ) then begin
         Day:= Copy( FullStr, 1, 2 );
         Month:= Copy( FullStr, 4, 2 );
         Year:= Copy( FullStr, 7, 4 );
         Result:= Year + Month + Day + Cst_DateSuffix;
      end;
   end;
end;

//Builds a custom messagedlg (to allow translating the buttons)
function TFrm_Editor.MyMessageDlg(const Msg: string; DlgTypt: TmsgDlgType; button: TMsgDlgButtons;
                      Caption: array of string; dlgcaption: string ): Integer;
var
   aMsgdlg: TForm;
   ii: Integer;
   Dlgbutton: Tbutton;
   Captionindex: Integer;
begin
   aMsgdlg := CreateMessageDialog(  Msg, DlgTypt, button   );
   aMsgdlg.Caption := dlgcaption;
   aMsgdlg.BiDiMode := bdLeftToRight;
   Captionindex := 0;
   for ii:= 0 to Pred( aMsgdlg.ComponentCount ) do begin
      if (aMsgdlg.components[ii] is Tbutton) then Begin
         Dlgbutton:= Tbutton( aMsgdlg.Components[ii]   );
         if ( Captionindex <= High( Caption ) ) then
            Dlgbutton.Caption:= Caption[Captionindex];
         Inc( Captionindex );
      end;
   end;
   Result:= aMsgdlg.Showmodal;
end;

//Loading parameters from the INI file
procedure TFrm_Editor.LoadFromIni;
var
   FileIni: TIniFile;
begin
   FileIni:= TIniFile.Create( ExtractFilePath( Application.ExeName ) + Cst_IniFilePath );
   try
      //Try to read the ini file; if not found, set everything to false by default
      FGodMode:= FileIni.ReadBool( Cst_IniOptions, Cst_IniGodMode, False );
      Mnu_GodMode.Checked:= FGodMode;
      Mnu_DeleteWoPrompt.Enabled:= FGodMode;
      Btn_Delete.Visible:= FGodMode;

      FAutoHash:= FileIni.ReadBool( Cst_IniOptions, Cst_IniAutoHash, False );
      Mnu_AutoHash.Checked:= FAutoHash;

      FDelWoPrompt:= FileIni.ReadBool( Cst_IniOptions, Cst_IniDelWoPrompt, False );
      Mnu_DeleteWoPrompt.Checked:= FDelWoPrompt;

      FPiPrompts:= FileIni.ReadBool( Cst_IniOptions, Cst_IniPiPrompts, False );
      Mnu_PiPrompts.Checked:= FPiPrompts;

      FGenesisLogo:= FileIni.ReadBool( Cst_IniOptions, Cst_IniGenesisLogo, False );
      Mnu_Genesis.Checked:= FGenesisLogo;

      FShowTips:= FileIni.ReadBool(  Cst_IniOptions, Cst_ShowTips, True );
      Mnu_ShowTips.Checked:= FShowTips;

      FThemeNumber:= FileIni.ReadInteger( Cst_IniOptions, Cst_ThemeNumber, 5 );
      FLanguage:= FileIni.ReadInteger( Cst_IniOptions, Cst_IniLanguage, 0 );

      FRecalLogin:= FileIni.ReadString( Cst_IniOptions, Cst_IniRecalLogin, Cst_RecalLogin);
      FRecalPwd:= FileIni.ReadString( Cst_IniOptions, Cst_IniRecalPwd, Cst_RecalPwd);
      FRetroLogin:= FileIni.ReadString( Cst_IniOptions, Cst_IniRetroLogin, Cst_RetroLogin);
      FRetroPwd:= FileIni.ReadString( Cst_IniOptions, Cst_IniRetroPwd, Cst_RetroPwd);

      FSSLogin:= FileIni.ReadString( Cst_IniOptions, Cst_IniSSUser, '');
      FSSPwd:= FileIni.ReadString( Cst_IniOptions, Cst_IniSSPwd, '');
      FProxyUser:= FileIni.ReadString( Cst_IniOptions, Cst_IniProxyUser, '');
      FProxyPwd:= FileIni.ReadString( Cst_IniOptions, Cst_IniProxyPwd, '');
      FProxyServer:= FileIni.ReadString( Cst_IniOptions, Cst_IniProxyServer, '');
      FProxyPort:= FileIni.ReadString( Cst_IniOptions, Cst_IniProxyPort, '0');
      FProxyUse:= FileIni.ReadBool( Cst_IniOptions, Cst_IniProxyUse, False);

      FRootPath:= FileIni.ReadString( Cst_IniOptions, Cst_IniRootFolder, '');
      FSelectedSystem:= FileIni.ReadString( Cst_IniOptions, Cst_IniSystem, '');
      FAutoLoadOnStart := FileIni.ReadBool( Cst_IniOptions, Cst_IniAutoLoadOnStart, True);
   finally
      FileIni.Free;
   end;
end;

//Saving parameters to the INI file
procedure TFrm_Editor.SaveToIni;
var
   FileIni: TIniFile;
   iniPath: String;
begin
  iniPath := ExtractFilePath( Application.ExeName ) + Cst_IniFilePath;
  ForceDirectories(ExtractFilePath (iniPath));
   FileIni:= TIniFile.Create( ExtractFilePath( Application.ExeName ) + Cst_IniFilePath );
   try
      FileIni.WriteBool( Cst_IniOptions, Cst_IniGodMode, FGodMode );
      FileIni.WriteBool( Cst_IniOptions, Cst_IniAutoHash, FAutoHash );
      FileIni.WriteBool( Cst_IniOptions, Cst_IniDelWoPrompt, ( FGodMode and FDelWoPrompt ) );
      FileIni.WriteBool( Cst_IniOptions, Cst_IniGenesisLogo, FGenesisLogo );
      FileIni.WriteBool( Cst_IniOptions, Cst_ShowTips, FShowTips );
      FileIni.WriteBool( Cst_IniOptions, Cst_IniPiPrompts, FPiPrompts );
      FileIni.WriteInteger( Cst_IniOptions, Cst_ThemeNumber, FThemeNumber );
      FileIni.WriteInteger( Cst_IniOptions, Cst_IniLanguage, FLanguage );
      FileIni.WriteString( Cst_IniOptions, Cst_IniRecalLogin, FRecalLogin);
      FileIni.WriteString( Cst_IniOptions, Cst_IniRecalPwd, FRecalPwd);
      FileIni.WriteString( Cst_IniOptions, Cst_IniRetroLogin, FRetroLogin);
      FileIni.WriteString( Cst_IniOptions, Cst_IniRetroPwd, FRetroPwd);
      FileIni.WriteString( Cst_IniOptions, Cst_IniSSUser, FSSLogin);
      FileIni.WriteString( Cst_IniOptions, Cst_IniSSPwd, FSSPwd);
      FileIni.WriteString( Cst_IniOptions, Cst_IniProxyUser, FProxyUser);
      FileIni.WriteString( Cst_IniOptions, Cst_IniProxyPwd, FProxyPwd);
      FileIni.WriteString( Cst_IniOptions, Cst_IniProxyServer, FProxyServer);
      FileIni.WriteString( Cst_IniOptions, Cst_IniRootFolder, FRootPath);
      FileIni.WriteString( Cst_IniOptions, Cst_IniSystem, FSelectedSystem);
      if ( FProxyPort.IsEmpty ) then FileIni.WriteString( Cst_IniOptions, Cst_IniProxyPort, '0' )
      else FileIni.WriteString( Cst_IniOptions, Cst_IniProxyPort, FProxyPort );
      FileIni.WriteBool( Cst_IniOptions, Cst_IniProxyUse, FProxyUse);
      FileIni.WriteBool( Cst_IniOptions, Cst_IniAutoLoadOnStart, FAutoLoadOnStart);
   finally
      FileIni.Free;
   end;
end;

//Retrieve the theme enum from the integer stored in the ini file
function TFrm_Editor.GetThemeEnum( aNumber: Integer ): TThemeName;
var
   _ThemeName: TThemeName;
begin
   Result:= tnCharcoalDarkSlate;
   for _ThemeName:= Low( TThemeName )to High( TThemeName ) do begin
      if ( aNumber = Ord( _ThemeName ) ) then begin
         Result:= _ThemeName;
         Break;
      end;
   end;
end;

//Retrieve the language enum from the integer stored in the ini file
function TFrm_Editor.GetLangEnum( aNumber: Integer ): TLangName;
var
   _LangName: TLangName;
begin
   Result:= lnEnglish;
   for _LangName:= Low( TLangName ) to High( TLangName ) do begin
      if ( aNumber = Ord( _LangName ) ) then begin
         Result:= _LangName;
         Break;
      end;
   end;
end;

//Retrieve the enum of the country (region) of the scraped game
function TFrm_Editor.GetCountryEnum( const aShortName: string ): TCountryName;
var
   _CountryName: TCountryName;
begin
   Result:= cnUnd;
   for _CountryName:= Low( TCountryName ) to High( TCountryName ) do begin
      if ( aShortName =  Cst_CountryName[_CountryName] ) then begin
         Result:= _CountryName;
         Break;
      end;
   end;
end;

//On program startup
procedure TFrm_Editor.FormCreate(Sender: TObject);
begin
   Caption := Cst_AppName + ' v' + GetVersion;
   FIsWine := IsRunningUnderWine;
   CreateWindowsMediaPlayer;
   FRomsSortMode:= 0;
   FRomsStatusMap:= TDictionary<TGame, TGameMediaStatus>.Create;
   TranslateComponent( Self );
   FImgList:= TObjectList<TImage>.Create;
   FInfosList:= TStringList.Create( True );
   FPictureLinks:= TObjectList<TMediaInfo>.Create;
   Lbl_NbGamesFound.Caption:= '';
   GSystemList:= TObjectDictionary<string, TObjectList<TGame>>.Create([doOwnsValues]);
   LoadFromIni;
   Mnu_AutoLoadOnStart.Checked := FAutoLoadOnStart;
   TStyleManager.TrySetStyle( Cst_ThemeNameStr[GetThemeEnum( FThemeNumber )] );
   FPiLoadedOnce:= False;
   FGameListChanged:= False;
   FTempXmlPath:= ExtractFilePath( Application.ExeName ) + Cst_TempXml;
   CounterGuard:= TCriticalSection.Create;
//   Img_System.Picture.Assign(icSystems.Images[3].SourceImages[0].Image);
//   Application.ProcessMessages;
end;

procedure TFrm_Editor.CreateWindowsMediaPlayer;
begin
   if not FIsWine then
   begin
      try
         Wmp_Video := TWindowsMediaPlayer.Create(Self);
         with Wmp_Video do
         begin
            Top := 0;
            Left := 0;
            Height := 812;
            Width := 612;
            TabOrder := 0;
            uiMode := 'none';
            enableContextMenu := False;
            autoSize := False;
            stretchToFit := True;
            align := alClient;
            Visible := false;
            Parent := Tbs_Video;

            SetBounds(Left, Top, Width, Height);
         end;
      except
         on E: Exception do
         ShowMessage('Error creating Windows Media Player: ' + E.Message);
      end;
   end;
end;

//Puts the focus on the combo system and the window display
procedure TFrm_Editor.FormShow(Sender: TObject);
var
   Frm_Help: TFrm_Help;
begin
   Pgc_Editor.ActivePage := Tbs_Main;
   UseLanguage( Cst_LangNameStr[GetLangEnum( FLanguage )] );
   RetranslateComponent( Self );
   CheckMenuItem( Succ( FThemeNumber ) );
   CheckMenuItem( Succ( FLanguage ), True );
   if FShowTips then begin
      //Shows the "Help" window
      Frm_Help:= TFrm_Help.Create(nil);
      try
         FShowTips:= Frm_Help.Execute( not FShowTips );
      finally
         Frm_Help.Free;
      end;
   end;
   Tbs_Scrape.TabVisible:= False;
   Mnu_ShowTips.Checked:= FShowTips;
   if (FRootPath<>'') and (lbListRoms.Items.Count < 1)  and (FAutoLoadOnStart) then begin
     OpenDialog.FileName := FRootPath;
     Img_BackGround.Visible:= True;
     lbListRoms.Items.Clear;
     //We defer the loading until after the window is displayed,
     //otherwise the progress bar would not be visible during the load
     PostMessage( Handle, WM_APP + 1, 0, 0 );
   end;
   lbListRoms.SetFocus;
end;

//Handler of the deferred loading: triggered after the window is displayed,
//so the progress bar is visible during the load
procedure TFrm_Editor.WMAutoLoad( var Msg: TMessage );
begin
   //Let the window draw itself a first time
   Application.ProcessMessages;
   BuildSystemsList( True );
   Btn_SaveChanges.Enabled:= False;
end;

//To check the menu item of the theme or language number retrieved from the ini file
procedure TFrm_Editor.CheckMenuItem( aNumber: Integer; aLang: Boolean = False );
var
   _MenuItem: TMenuItem;
   _CompName: string;
begin
   if aLang then _CompName:= Cst_MenuLang + IntToStr( aNumber )
   else _CompName:= Cst_MenuTheme + IntToStr( aNumber );
   //The menu may have no item for this number (theme indices with
   //gaps): we check to avoid an AV on nil.Checked
   _MenuItem:= FindComponent( _CompName ) as TMenuItem;
   if Assigned( _MenuItem ) then
      _MenuItem.Checked:= True;
end;

//Action on clicking the "choose folder" menu item
procedure TFrm_Editor.Mnu_ChoosefolderClick(Sender: TObject);
begin
   Img_BackGround.Visible:= True;
   EnableControls( False );
   Edt_Search.Enabled:= False;
   Lbl_Search.Enabled:= False;
   ClearAllFields;
   lbListRoms.Items.Clear;
   BuildSystemsList;
   Btn_SaveChanges.Enabled:= False;
end;

//Action on clicking the "Reload Systems" menu item
procedure TFrm_Editor.Mnu_ReloadClick(Sender: TObject);
begin
   Img_BackGround.Visible:= True;
   EnableControls( False );
   Edt_Search.Enabled:= False;
   Lbl_Search.Enabled:= False;
   ClearAllFields;
   lbListRoms.Items.Clear;
   BuildSystemsList( True );
   Btn_SaveChanges.Enabled:= False;
end;

//Reloads the game list of the currently selected system only, re-reading its
//gamelist.xml from disk (e.g. after an external change or after scanning).
procedure TFrm_Editor.Mnu_ReloadGameListClick(Sender: TObject);
var
   _GameListPath: string;
   _Folder: string;
   _NewList: TObjectList<TGame>;
begin
   if Cbx_Systems.ItemIndex < 0 then Exit;
   if FCurrentFolder = '' then Exit;

   _GameListPath:= FRootPath + FCurrentFolder + Cst_GameListFileName;
   if not FileExists( _GameListPath ) then Exit;

   Screen.Cursor:= crHourGlass;
   try
      //Purge the current views first so no stale TGame pointers are kept:
      //the old game list is freed when the GSystemList entry is replaced.
      lbListRoms.Clear;
      if Assigned( FRomsStatusMap ) then
         FRomsStatusMap.Clear;
      FFilteredGames.Free;
      FFilteredGames:= nil;

      _NewList:= BuildGamesList( _GameListPath, False );
      if _NewList = nil then Exit;

      _Folder:= getCurrentFolderName;
      if GSystemList.ContainsKey( _Folder ) then
         GSystemList.Remove( _Folder );
      GSystemList.Add( _Folder, _NewList );

      LoadGamesList( _Folder );
   finally
      Screen.Cursor:= crDefault;
   end;
end;

//allows running the command line that stops/starts Emulation Station
//used if we access the gamelists directly on the Pi, otherwise the changes
//are not taken into account. Uses the small utility plink.exe
procedure TFrm_Editor.StopOrStartES( aStop, aRecal: Boolean );
var
   _PathToPlink: string;
begin
   _PathToPlink:= ExtractFilePath( Application.ExeName ) + Cst_ResourcesFolder;
   if aStop then begin
      if aRecal then
         ShellExecute( 0, nil, 'cmd.exe', PChar( Cst_PlinkCommand + FRecalLogin +
                       Cst_PlinkCommandRecal + FRecalPwd +
                       Cst_PlinkCommandStop ), PChar( _PathToPlink ), SW_HIDE )
      else
         ShellExecute( 0, nil, 'cmd.exe', PChar( Cst_PlinkCommand + FRetroLogin +
                       Cst_PlinkCommandRetro + FRetroPwd +
                       Cst_PlinkCommandStop ), PChar( _PathToPlink ), SW_HIDE );
   end else begin
      if aRecal then
         ShellExecute( 0, nil, 'cmd.exe', PChar( Cst_PlinkCommand + FRecalLogin +
                       Cst_PlinkCommandRecal + FRecalPwd +
                       Cst_PlinkCommandStart ), PChar( _PathToPlink ), SW_HIDE )
      else
         ShellExecute( 0, nil, 'cmd.exe', PChar( Cst_PlinkCommand + FRetroLogin +
                       Cst_PlinkCommandRetro + FRetroPwd +
                       Cst_PlinkCommandStart ), PChar( _PathToPlink ), SW_HIDE )
   end;
end;

//Builds the list of found systems (and their associated game lists)
procedure TFrm_Editor.BuildSystemsList( aReload : Boolean = False );
var
   _GameListPath: string;
   Info: TSearchRec;
   IsFound: Boolean;
   ValidFolderCount: Integer;
   _TotalGamesCount: Integer;
TmpList: TObjectList<TGame>;
   _system: TSystemKindObject;
   ii: Integer;
begin
   //reset the base path and the system logo to empty
   //FRootPath:= '';
   Img_System.Picture.Graphic:= nil;

   //Clear the systems combobox
   //And disable the Controls that are not needed
   Cbx_Systems.Items.Clear;
   Cbx_Systems.Enabled:= False;
   Cbx_Filter.Enabled:= False;
   Lbl_SelectSystem.Enabled:= False;
   Lbl_Filter.Enabled:= False;
   Lbl_NbGamesFound.Caption:= '';
   Btn_ChangeAll.Enabled:= False;
   Cbx_KidGame.ItemIndex:= -1;
   Cbx_Hidden.ItemIndex:= -1;
   Cbx_Favorite.ItemIndex:= -1;
   Edt_Search.Text:= '';

   //Clear the global systems list (2nd open case)
   GSystemList.Clear;

   //The TGame objects are freed by GSystemList.Clear (doOwnsValues):
   //we also purge the advanced list, its cache and the filtered games so we no
   //longer keep stale pointers (otherwise there is an AV risk on the next repaint).
   lbListRoms.Clear;
   if Assigned( FRomsStatusMap ) then
      FRomsStatusMap.Clear;
   FFilteredGames.Free;
   FFilteredGames:= nil;

   //Reset the valid folder counter to 0
   ValidFolderCount:= 0;

   //Select the parent folder where the system folders are located
   if ( not aReload ) then begin
      Mnu_Reload.Enabled:= False;
      if ( OpenDialog.Execute ) then
         //Retrieve the path to the parent folder
         FRootPath:= IncludeTrailingPathDelimiter( OpenDialog.FileName )
      else
         Exit;
   end;

   //Check that the folder is not empty
   IsFound:= ( FindFirst( FRootPath + '*.*', faAnyFile, Info) = 0 );

   //If the folder is empty: show a message to the user
   if not IsFound then begin
      ShowMessage( Rst_WrongFolder );
      Exit;
   end;

   //First pass: count the total number of games in all the
   //valid gamelist.xml files to display an accurate progress bar
   _TotalGamesCount:= 0;
   while IsFound do begin
      if ( (Info.Attr and faDirectory) <> 0 ) and
         ( Info.Name[1] <> '.' ) and
         ( FileExists( FRootPath + IncludeTrailingPathDelimiter( Info.Name ) +
                       Cst_GameListFileName ) ) then
         _TotalGamesCount:= _TotalGamesCount +
                           CountGamesInFile( FRootPath + IncludeTrailingPathDelimiter( Info.Name ) +
                                             Cst_GameListFileName );
      IsFound:= ( FindNext(Info) = 0 );
   end;
   FindClose(Info);

   //Configure and display the progress bar for loading
   Screen.Cursor:= crHourGlass;
   ProgressBar.Visible:= True;
   ProgressBar.Max:= _TotalGamesCount;
   ProgressBar.Position:= 0;

   //Force the window to redraw itself before starting the loading,
   //otherwise the progress bar would not be visible during the work
   Application.ProcessMessages;

   //Loop over the found folders to list them
   IsFound:= ( FindFirst( FRootPath + '*.*', faAnyFile, Info) = 0 );
   while IsFound do begin

      //If the found folder does not start with a . and contains
      //a valid gamelist.xml file then we create the game list
      if ( (Info.Attr and faDirectory) <> 0 ) and
         ( Info.Name[1] <> '.' ) and
         ( FileExists( FRootPath + IncludeTrailingPathDelimiter( Info.Name ) +
                       Cst_GameListFileName ) ) then begin

         //get the name of the current folder to build the paths
         FCurrentFolder:= IncludeTrailingPathDelimiter( Info.Name );

         //Here we retrieve the path to the gamelist.xml file
         _GameListPath:= FRootPath + FCurrentFolder + Cst_GameListFileName;

         //Try to build the game list from the .xml
         TmpList:= BuildGamesList( _GameListPath, True );

         //If the list is not empty we process it, otherwise we skip it
         if Assigned( TmpList ) then begin

            //Build the game list of the system
            //and add the system to the global systems list
            GSystemList.Add( Info.Name, TmpList );

            //Then add the system name to the combobox of found systems
            _system:= TSystemKindObject.Create( Info.Name );
            if ( _system.FSystemKind = skOther ) then
               Cbx_Systems.Items.AddObject( Info.Name, _system )
            else if ( _system.FSystemKind = skMegaDrive ) and FGenesisLogo then
               Cbx_Systems.Items.AddObject( Cst_SystemKindStr[skGenesis], _system )
            else
               Cbx_Systems.Items.AddObject( Cst_SystemKindStr[_system.FSystemKind], _system );

            //Increment the valid system folder counter
            Inc( ValidFolderCount );
         end;
      end;

      //Finally, move to the next folder (if there is one)
      IsFound:= ( FindNext(Info) = 0 );
   end;
   FindClose(Info);

   //Hide the progress bar once everything is loaded
   ProgressBar.Visible:= False;
   Screen.Cursor:= crDefault;

   //If the valid folder counter is zero, show a message to the user
   if ( ValidFolderCount = 0 ) then begin
      ShowMessage( Rst_WrongFolder );
      Screen.Cursor:= crDefault;
      Exit;

      //Enable the systems combobox if at least one system was found
      //Same for the games listbox of the system and load the first system list
   end else begin

      //if the selected folder is on the Pi,
      //warn the user that we are going to stop ES
      FFolderIsOnPi:= FRootPath.StartsWith( Cst_Recalbox ) or
                      FRootPath.StartsWith( Cst_Retropie );

      if FFolderIsOnPi and not FPiLoadedOnce then begin
         FPiLoadedOnce:= True;
         if not FPiPrompts then
            MyMessageDlg( Rst_StopES, mtInformation, [mbOK], [Rst_Ok], Rst_Info );
         if FRootPath.StartsWith( Cst_Recalbox ) then begin
            StopOrStartES( True, True );
            FSysIsRecal:= True;
         end else begin
            StopOrStartES( True, False );
            FSysIsRecal:= False;
         end;
      end;

      Cbx_Systems.Enabled:= True;
      Lbl_SelectSystem.Enabled:= Cbx_Systems.Enabled;
      Cbx_Filter.Enabled:= Cbx_Systems.Enabled;
      Lbl_Filter.Enabled:= Cbx_Systems.Enabled;
      //Restore the last selected system if found in the list,
      //otherwise fall back to the first system of the list
      Cbx_Systems.ItemIndex:= 0;
      for ii:= 0 to Pred( Cbx_Systems.Items.Count ) do begin
         _system:= TSystemKindObject( Cbx_Systems.Items.Objects[ii] );
         if ( _system.FSystemKind = skOther ) then begin
            if ( Cbx_Systems.Items[ii] = FSelectedSystem ) then begin
               Cbx_Systems.ItemIndex:= ii;
               Break;
            end;
         end else if ( Cst_SystemKindFolderNames[_system.FSystemKind] = FSelectedSystem ) then begin
            Cbx_Systems.ItemIndex:= ii;
            Break;
         end;
      end;
      EnableControls( True );
      Cbx_Filter.ItemIndex:= 0;
      Edt_Search.Enabled:= True;
      Lbl_Search.Enabled:= True;
      LoadGamesList( getCurrentFolderName );
      Mnu_Reload.Enabled:= True;

      //Restore the default cursor
      Screen.Cursor:= crDefault;
   end;
end;

//Builds the game (object) list for a given system
function TFrm_Editor.BuildGamesList( const aPathToFile: string; aProgress: Boolean = False ): TObjectList<TGame>;

   //Ensures the searched node exists; if it does not,
   //returns an empty string, otherwise returns the text value of the node
   function GetNodeValue( aNode: IXMLNode; const aNodeName: string ): string;
   begin
      Result:= '';
      if Assigned( aNode.ChildNodes.FindNode( aNodeName ) ) then
         Result:= aNode.ChildNodes.Nodes[aNodeName].Text;
   end;

var
   _GameList: TObjectList<TGame>;
   _Game: TGame;
   _Node: IXmlNode;
begin
   //set the hourglass cursor to show it is working.
   Screen.Cursor:= crHourGlass;

   //Initialise to nil in case of an empty game list
   Result:= nil;

   //Open and activate the gamelist.xml to iterate through it
   XMLDoc.FileName:= aPathToFile;
   XMLDoc.Active:= True;

   //Look for the first "game"
   _Node := XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );

   //If no game is found, exit and return nil
   if not Assigned( _Node ) then begin
      XMLDoc.Active:= False;
      Exit;
   end;

   //Create the list of TGame objects
   _GameList:= TObjectList<TGame>.Create( True );

   //Then loop over all the games and for each game
   //create a TGame object that we fill in and add to the _Gamelist
   repeat
      //We only create a "game" if the node is not empty.
      if _Node.HasChildNodes then begin

         //Create the TGame object and pass the info as arguments
         _Game:= TGame.Create( GetNodeValue( _Node, Cst_Path ),
                               GetNodeValue( _Node, Cst_Name ),
                               GetNodeValue( _Node,Cst_Description ),
                               GetNodeValue( _Node, Cst_ImageLink ),
                               GetNodeValue( _Node, Cst_VideoLink ),
                               GetNodeValue( _Node, Cst_Rating ),
                               GetNodeValue( _Node, Cst_Developer ),
                               GetNodeValue( _Node, Cst_Publisher ),
                               GetNodeValue( _Node, Cst_Genre ),
                               GetNodeValue( _Node, Cst_Players ),
                               FormatDateFromString( GetNodeValue( _Node, Cst_ReleaseDate ) ),
                               GetNodeValue( _Node, Cst_Region ),
                               GetNodeValue( _Node, Cst_Playcount ),
                               GetNodeValue( _Node, Cst_LastPlayed ),
                               GetNodeValue( _Node, Cst_KidGame ),
                               GetNodeValue( _Node, Cst_Hidden ),
                               GetNodeValue( _Node, Cst_Favorite ) );

         _Game.PhysicalRomPath:= GetPhysicalRomPath( _Game.RomPath );
         _Game.PhysicalImagePath:= GetPhysicalMediaPath( _Game.ImagePath );
         _Game.PhysicalVideoPath:= GetPhysicalMediaPath( _Game.VideoPath );
         _Game.IsOrphan:= not FileExists( _Game.PhysicalRomPath );

         //Add it to the _Gamelist
         _GameList.Add( _Game );
      end;

      //Advance the progress bar by one step if requested
      if aProgress then begin
         ProgressBar.Position:= ProgressBar.Position + 1;
         Application.ProcessMessages;
      end;

      //Move on to the next game
      _Node := _Node.NextSibling;
   until ( _Node = nil );

   XMLDoc.Active:= False;

   Result:= _GameList;
end;

//Counts the number of "game" nodes in a gamelist.xml without building objects
//(used to size the progress bar when opening the folder)
function TFrm_Editor.CountGamesInFile( const aPathToFile: string ): Integer;
var
   _Node: IXmlNode;
begin
   Result:= 0;
   XMLDoc.FileName:= aPathToFile;
   XMLDoc.Active:= True;
   try
      _Node:= XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );
      while Assigned( _Node ) do begin
         Inc( Result );
         _Node:= _Node.NextSibling;
      end;
   finally
      XMLDoc.Active:= False;
   end;
end;

//Action when selecting a filter
procedure TFrm_Editor.Cbx_FilterChange(Sender: TObject);
begin
   LoadGamesList( getCurrentFolderName );
end;

//Action when selecting an item in the systems combobox
procedure TFrm_Editor.Cbx_SystemsChange(Sender: TObject);
var
   _PrevSystem: string;
   _system: TSystemKindObject;
   ii: Integer;
begin
   //guard against re-entrancy when restoring the selection after a cancel
   if FChangingSystem then Exit;
   FChangingSystem:= True;
   try
      //remember the current system so we can restore it if the switch is cancelled
      _PrevSystem:= FSelectedSystem;

      //ask the user to save the current gamelist if it was modified
      if not ConfirmSaveGameList( True ) then begin
         //restore the previous system selection and cancel the switch
         Cbx_Systems.ItemIndex:= -1;
         for ii:= 0 to Pred( Cbx_Systems.Items.Count ) do begin
            _system:= TSystemKindObject( Cbx_Systems.Items.Objects[ii] );
            if ( _system.FSystemKind = skOther ) then begin
               if ( Cbx_Systems.Items[ii] = _PrevSystem ) then begin
                  Cbx_Systems.ItemIndex:= ii;
                  Break;
               end;
            end else if ( Cst_SystemKindFolderNames[_system.FSystemKind] = _PrevSystem ) then begin
               Cbx_Systems.ItemIndex:= ii;
               Break;
            end;
         end;
         FSelectedSystem:= _PrevSystem;
         Exit;
      end;

      FSelectedSystem:= getCurrentFolderName;
      EmptyScrapeFields;
      Edt_Search.Text:= '';
      LoadGamesList( getCurrentFolderName );
   finally
      FChangingSystem:= False;
   end;
end;

//when typing text in the search field
procedure TFrm_Editor.Edt_SearchChange(Sender: TObject);
begin
   LoadGamesList( getCurrentFolderName );
end;

//I make a procedure just to activate the controls
//so I don't have to retype them at every state change
procedure TFrm_Editor.EnableControls( aValue: Boolean );
begin
   Lbl_Name.Enabled:= aValue;
   Lbl_Genre.Enabled:= aValue;
   Lbl_Rating.Enabled:= aValue;
   Lbl_Developer.Enabled:= aValue;
   Lbl_Publisher.Enabled:= aValue;
   Lbl_Players.Enabled:= aValue;
   Lbl_Date.Enabled:= aValue;
   Lbl_Description.Enabled:= aValue;
   Lbl_Region.Enabled:= aValue;
   Lbl_Hidden.Enabled:= aValue;
   Lbl_Favorite.Enabled:= aValue;
   Lbl_KidGame.Enabled:= aValue;

   Btn_ChangeImage.Enabled:= aValue;
   Btn_ChangeVideo.Enabled:= aValue;
   Btn_Scrape.Enabled:= aValue;
   Btn_RemovePicture.Enabled:= aValue;
   Btn_RemoveVideo.Enabled:= aValue;
   Btn_SetDefaultPicture.Enabled:= aValue;
   Btn_MoreInfos.Enabled:= aValue;
   Btn_Delete.Enabled:= aValue;

   //Synchronize the state of the context menu of the media controls
   pm_ChangeImage.Enabled:= Btn_ChangeImage.Enabled;
   pm_ChangeVideo.Enabled:= Btn_ChangeVideo.Enabled;
   pm_RemovePicture.Enabled:= Btn_RemovePicture.Enabled;
   pm_RemoveVideo.Enabled:= Btn_RemoveVideo.Enabled;
   pm_SetDefaultPicture.Enabled:= Btn_SetDefaultPicture.Enabled;
   pm_ChangeAllPictures.Enabled:= Btn_ChangeAll.Enabled;

   Mnu_System.Enabled:= aValue or not ( GSystemList.Count = 0 );
   Mnu_Game.Enabled:= aValue and not ( lbListRoms.Items.Count = 0 );

   Edt_Name.Enabled:= aValue;
   Edt_Genre.Enabled:= aValue;
   Edt_Rating.Enabled:= aValue;
   Edt_Region.Enabled:= aValue;
   Edt_Developer.Enabled:= aValue;
   Edt_Publisher.Enabled:= aValue;
   Edt_ReleaseDate.Enabled:= aValue;
   Edt_NbPlayers.Enabled:= aValue;
   Edt_RomPath.Enabled:= aValue;
   Mmo_Description.Enabled:= aValue;

   Cbx_KidGame.Enabled:= aValue;
   Cbx_Hidden.Enabled:= aValue;
   Cbx_Favorite.Enabled:= aValue;
   Chk_ListByRom.Enabled:= aValue;
   Chk_ManualCRC.Enabled:= Btn_Scrape.Enabled;

   Tbs_Scrape.TabVisible:= aValue;

   if FIsWine then
      Tbs_Video.TabVisible:= False
   else
      Tbs_Video.TabVisible:= aValue;

   if aValue = false then 
      StopGameVideo();
end;

//Action when the content of one of the fields changes
procedure TFrm_Editor.FieldChange(Sender: TObject);
begin
   CheckIfChangesToSave;
end;

//Check if there are changes to enable the
//"Save changes" button or not
procedure TFrm_Editor.CheckIfChangesToSave;
var
   _Game: TGame;
begin
   if FIsLoading then Exit;

   if lbListRoms.SelCount > 1 then
     Btn_SaveChanges.Enabled:= not ( Edt_Name.Text = '' ) or
                               not ( Edt_Genre.Text = '' ) or
                               not ( Edt_Rating.Text = '' ) or
                               not ( Edt_NbPlayers.Text = '' ) or
                               not ( Edt_Developer.Text = '' ) or
                               not ( Edt_Publisher.Text = '' ) or
                               not ( Edt_ReleaseDate.Text = '' ) or
                               not ( Mmo_Description.Text = '' ) or
                               not ( Edt_Region.Text = '' ) or
                               not ( Cbx_KidGame.ItemIndex = -1 ) or
                               not ( Cbx_Hidden.ItemIndex = -1 ) or
                               not ( Cbx_Favorite.ItemIndex = -1 )
   else begin
     _Game:= ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame );
     Btn_SaveChanges.Enabled:= not ( _Game.Name.Equals( Edt_Name.Text ) ) or
                               not ( _Game.Genre.Equals( Edt_Genre.Text ) ) or
                               not ( _Game.Rating.Equals( Edt_Rating.Text ) ) or
                               not ( _Game.Players.Equals( Edt_NbPlayers.Text ) ) or
                               not ( _Game.Developer.Equals( Edt_Developer.Text ) ) or
                               not ( _Game.Publisher.Equals( Edt_Publisher.Text ) ) or
                               not ( _Game.ReleaseDate.Equals( Edt_ReleaseDate.Text ) ) or
                               not ( _Game.Description.Equals( Mmo_Description.Text ) ) or
                               not ( _Game.Region.Equals( Edt_Region.Text ) ) or
                               not ( _Game.KidGame = Cbx_KidGame.ItemIndex ) or
                               not ( _Game.Hidden = Cbx_Hidden.ItemIndex ) or
                               not ( _Game.Favorite = Cbx_Favorite.ItemIndex );
   end;

end;

//Loading the game list of a system into the games listbox
procedure TFrm_Editor.LoadGamesList( const aSystem: string );

   //retrieves the path to the images (from the xml)
   procedure GetImageFolder( aGame: TGame );
   var
      EndPos: Integer;
   begin
      EndPos:= LastDelimiter( '/', aGame.ImagePath );
      FImageFolder:= Copy( aGame.ImagePath, 1, EndPos );
   end;

   procedure GetVideoFolder( aGame: TGame );
   var
      EndPos: Integer;
   begin
      EndPos:= LastDelimiter( '/', aGame.VideoPath );
      FVideoFolder:= Copy( aGame.VideoPath, 1, EndPos );
   end;

   //Checks whether the image exists "physically"
   //because the link may be set but the image
   //may not exist in the images folder...
   function CheckIfFileMissing( const aLink: string ): Boolean;
   begin
      Result:= aLink.IsEmpty or not ( FileExists( aLink ) );
   end;

   function AdjustDecimalSeparator(const Value: string): string;
   begin
      Result := StringReplace(Value, ',', '.', [rfReplaceAll]);
   end;

   function CountChar(const S: string; const Ch: Char): Integer;
   var
      i: Integer;
   begin
      Result := 0;
      for i := 1 to Length(S) do
         if S[i] = Ch then
            Inc(Result);
   end;

   function FlexibleDateParse(const ADateStr: string): TDate;
   var
      Year, Month: Word;
   begin
      if Length(ADateStr) = 4 then // Only year provided
      begin
         Result := EncodeDate(StrToIntDef(ADateStr, 0), 1, 1);
      end else if (CountChar(ADateStr, '-') = 1) or (CountChar(ADateStr, '/') = 1)  then // Year and month provided
      begin
         Year := StrToIntDef(Copy(ADateStr, 1, 4), 0);
         Month := StrToIntDef(Copy(ADateStr, 6, 2), 0);
         Result := EncodeDate(Year, Month, 1);
      end else begin // Assume full date
         Result := StrToDateDef(ADateStr, Now);
      end;
   end;

   function SameFolder(Path1, Path2: string): Boolean;
   begin
      try
         Result := AnsiSameText(ExtractFilePath(Path1), ExtractFilePath(Path2));
      except
         Result := False;
      end;
   end;

   // Implement the procedure in the implementation section
   procedure InitializeDuplicateDictionaries(const GameList: TObjectList<TGame>; const FilterIndex: Integer;
     out NameCountMap: TDictionary<string, Integer>;
     out ROMPathCountMap: TDictionary<string, Integer>);
   var
     Game: TGame;
     ROMFileName: string;
   begin
     NameCountMap := nil;
     ROMPathCountMap := nil;

     // Create dictionaries only for relevant filters
     if (FilterIndex = 29) then
       NameCountMap := TDictionary<string, Integer>.Create;
     if (FilterIndex = 30) then
       ROMPathCountMap := TDictionary<string, Integer>.Create;

     try
       for Game in GameList do begin
         // Count game names for filter 29 (All with duplicate name)
         if (FilterIndex = 29) and Assigned(NameCountMap) then begin
           if NameCountMap.ContainsKey(Game.Name) then
             NameCountMap[Game.Name] := NameCountMap[Game.Name] + 1
           else
             NameCountMap.Add(Game.Name, 1);
         end;

         // Count ROM paths for filter 30 (All with duplicate roms)
         if (FilterIndex = 30) and Assigned(ROMPathCountMap) then begin
           ROMFileName := ExtractFileName(Game.PhysicalRomPath);
           if ROMPathCountMap.ContainsKey(ROMFileName) then
             ROMPathCountMap[ROMFileName] := ROMPathCountMap[ROMFileName] + 1
           else
             ROMPathCountMap.Add(ROMFileName, 1);
         end;
       end;
     except on E: Exception do
       begin
         // Make sure dictionaries are still initialized with empty values
         if (FilterIndex = 29) and not Assigned(NameCountMap) then
           NameCountMap := TDictionary<string, Integer>.Create;
         if (FilterIndex = 30) and not Assigned(ROMPathCountMap) then
           ROMPathCountMap := TDictionary<string, Integer>.Create;
         // Handle catastrophic failure in the counting process
         ShowMessage('Error while searching for duplicates: ' + E.Message);
       end;
     end;
   end;

var
   _ReferenceGame: TGame;
   _TmpList: TObjectList<TGame>;
   _TmpGame: TGame;
   _FilterIndex: Integer;
   _ImageFolderFound: Boolean;
   _VideoFolderFound: Boolean;
   _FormatSettings: TFormatSettings;
   _ParsedReferenceRating, _ParsedGameRating: Double;
   _ParsedReferenceDate: TDate;
   _NameCountMap: TDictionary<string, Integer>;
   _ROMPathCountMap: TDictionary<string, Integer>;
begin
   //store the "number" of the filter.
   _FilterIndex:= Cbx_Filter.ItemIndex;
   _ImageFolderFound:= False;
   _VideoFolderFound:= False;
   StopGameVideo;

   //Try to retrieve the game list of the chosen system
   if GSystemList.TryGetValue( aSystem, _TmpList ) then begin

      FormatSettings := TFormatSettings.Create;
      FormatSettings.DecimalSeparator := '.';

      // Retrieve the currently selected game
      try
         if (lbListRoms.ItemIndex <> -1) and
            (lbListRoms.Items.Objects[lbListRoms.ItemIndex] <> nil) and
            (lbListRoms.Items.Objects[lbListRoms.ItemIndex] is TGame) then begin
             _ReferenceGame := (lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame);
         end else begin
             _ReferenceGame := nil;
         end;
      except on E: Exception do begin
             _ReferenceGame := nil;
          end;
      end;
      // If any game selected, parse number filters
      if Assigned(_ReferenceGame) then begin
          _ParsedReferenceRating := StrToFloatDef(AdjustDecimalSeparator(_ReferenceGame.Rating), 0, FormatSettings);
          _ParsedReferenceDate := FlexibleDateParse(_ReferenceGame.ReleaseDate);
      end else begin
          _ParsedReferenceRating := 0;
          _ParsedReferenceDate := Now;
      end;

      //Load the logo of the chosen system
      if ( GetCurrentLogoName = Cst_SystemKindImageNames[skMegaDrive] ) and
         FGenesisLogo then
         LoadSystemLogo( Cst_SystemKindImageNames[skGenesis] )
      else
         LoadSystemLogo( GetCurrentLogoName );

      //retrieve the name of the loaded rom folder
      FCurrentFolder:= IncludeTrailingPathDelimiter( getCurrentFolderName );

      //Disable the events on the changes in the fields
      //Otherwise it breaks when changing system (index out of bounds)
      FIsLoading:= True;

      //Start by clearing the filtered game list
      if FFilteredGames = nil then
         FFilteredGames:= TList<TGame>.Create
      else
         FFilteredGames.Clear;

      // Initialize dictionaries for duplicate detection (filters 29 and 30)
      if (_FilterIndex = 29) or (_FilterIndex = 30) then begin
        InitializeDuplicateDictionaries(_TmpList, _FilterIndex, _NameCountMap, _ROMPathCountMap);
      end;

      //Loop over the game list to add the names
      //to the games listbox
      for _TmpGame in _TmpList do begin

         //Retrieve the link to the images for this system (xml link)
         if not ( _TmpGame.ImagePath.IsEmpty ) and
            not _ImageFolderFound then begin
            GetImageFolder( _TmpGame );
            _ImageFolderFound:= True;
         end;

         if not ( _TmpGame.VideoPath.IsEmpty ) and
            not _VideoFolderFound then begin
            GetVideoFolder( _TmpGame );
            _VideoFolderFound:= True;
         end;

         if ( _FilterIndex = 21 ) or ( _FilterIndex = 22 ) then
         begin
            _ParsedGameRating := StrToFloatDef(AdjustDecimalSeparator(_TmpGame.Rating), 0, FormatSettings);
         end;

         //Careful: boolean factory to manage the filters ^^
         if ( _FilterIndex = 0 ) or
            ( ( _FilterIndex = 1 ) and ( CheckIfFileMissing( _TmpGame.PhysicalImagePath ) ) ) or
            ( ( _FilterIndex = 2 ) and ( CheckIfFileMissing( _TmpGame.PhysicalVideoPath ) ) ) or
            ( ( _FilterIndex = 3 ) and ( _TmpGame.ReleaseDate.IsEmpty ) ) or
            ( ( _FilterIndex = 4 ) and ( _TmpGame.Players.IsEmpty ) ) or
            ( ( _FilterIndex = 5 ) and ( _TmpGame.Rating.IsEmpty ) ) or
            ( ( _FilterIndex = 6 ) and ( _TmpGame.Developer.IsEmpty ) ) or
            ( ( _FilterIndex = 7 ) and ( _TmpGame.Publisher.IsEmpty ) ) or
            ( ( _FilterIndex = 8 ) and ( _TmpGame.Description.IsEmpty ) ) or
            ( ( _FilterIndex = 9 ) and ( _TmpGame.Genre.IsEmpty ) ) or
            ( ( _FilterIndex = 10 ) and ( _TmpGame.Region.IsEmpty ) ) or
            ( ( _FilterIndex = 11 ) and ( _TmpGame.KidGame = 1 ) ) or
            ( ( _FilterIndex = 12 ) and ( _TmpGame.Hidden = 1 ) ) or
            ( ( _FilterIndex = 13 ) and ( _TmpGame.Favorite = 1 ) ) or
            ( ( _FilterIndex = 14 ) and ( _TmpGame.IsOrphan ) ) or
            ( ( _FilterIndex = 15 ) and Assigned(_ReferenceGame) and (_TmpGame.Region = _ReferenceGame.Region) ) or
            ( ( _FilterIndex = 16 ) and Assigned(_ReferenceGame) and (_TmpGame.ReleaseDate = _ReferenceGame.ReleaseDate) ) or
            ( ( _FilterIndex = 17 ) and Assigned(_ReferenceGame) and (not _TmpGame.ReleaseDate.IsEmpty) and (FlexibleDateParse(_TmpGame.ReleaseDate) <= _ParsedReferenceDate) ) or
            ( ( _FilterIndex = 18 ) and Assigned(_ReferenceGame) and (not _TmpGame.ReleaseDate.IsEmpty) and (FlexibleDateParse(_TmpGame.ReleaseDate) >= _ParsedReferenceDate) ) or
            ( ( _FilterIndex = 19 ) and Assigned(_ReferenceGame) and (_TmpGame.Players = _ReferenceGame.Players) ) or
            ( ( _FilterIndex = 20 ) and Assigned(_ReferenceGame) and (_TmpGame.Rating = _ReferenceGame.Rating) ) or
            ( ( _FilterIndex = 21 ) and Assigned(_ReferenceGame) and (not _TmpGame.Rating.IsEmpty) and (_ParsedGameRating <= _ParsedReferenceRating) ) or
            ( ( _FilterIndex = 22 ) and Assigned(_ReferenceGame) and (not _TmpGame.Rating.IsEmpty) and (_ParsedGameRating >= _ParsedReferenceRating) ) or
            ( ( _FilterIndex = 23 ) and Assigned(_ReferenceGame) and (_TmpGame.Publisher = _ReferenceGame.Publisher) ) or
            ( ( _FilterIndex = 24 ) and Assigned(_ReferenceGame) and (_TmpGame.Developer = _ReferenceGame.Developer) ) or
            ( ( _FilterIndex = 25 ) and Assigned(_ReferenceGame) and (_TmpGame.Genre = _ReferenceGame.Genre) ) or
            ( ( _FilterIndex = 26 ) and Assigned(_ReferenceGame) and (SameFolder(_TmpGame.PhysicalRomPath, _ReferenceGame.PhysicalRomPath)) ) or
            ( ( _FilterIndex = 27 ) and Assigned(_ReferenceGame) and (_TmpGame.Name	= _ReferenceGame.Name) ) or
            ( ( _FilterIndex = 28 ) and Assigned(_ReferenceGame) and (ExtractFileName(_TmpGame.PhysicalRomPath) = ExtractFileName(_ReferenceGame.PhysicalRomPath)) ) or
            ( ( _FilterIndex = 29 ) and _NameCountMap.ContainsKey(_TmpGame.Name) and (_NameCountMap[_TmpGame.Name] > 1) ) or
            ( ( _FilterIndex = 30 ) and _ROMPathCountMap.ContainsKey(ExtractFileName(_TmpGame.PhysicalRomPath)) and
                                  (_ROMPathCountMap[ExtractFileName(_TmpGame.PhysicalRomPath)] > 1) ) then begin

            if ( not Chk_ListByRom.Checked ) and
               ( ( Edt_Search.Text = '' ) or
               ContainsText( _TmpGame.Name, Edt_Search.Text ) ) then begin
               FFilteredGames.Add( _TmpGame )

            end else if ( Chk_ListByRom.Checked ) then begin
               if ( Chk_FullRomName.Checked ) and
                  ( ( Edt_Search.Text = '' ) or
                  ContainsText( _TmpGame.RomPath, Edt_Search.Text ) ) then
                  FFilteredGames.Add( _TmpGame )
               else if ( ( Edt_Search.Text = '' ) or
                  ContainsText( _TmpGame.RomName, Edt_Search.Text ) ) then
                  FFilteredGames.Add( _TmpGame )
            end;
         end
      end;

      // Free the dictionaries if they were created
      if (_FilterIndex = 29) or (_FilterIndex = 30) then begin
         if Assigned(_NameCountMap) then
            _NameCountMap.Free;
         if Assigned(_ROMPathCountMap) then
            _ROMPathCountMap.Free;
      end;

      //Rebuild the advanced game list (with media statuses, sorted and filtered)
      RefreshListRoms;

      //Show the number of found games
      if Cbx_Filter.ItemIndex = 0 then
         Lbl_NbGamesFound.Caption:= IntToStr( lbListRoms.Items.Count ) + Rst_GamesFound
      else
         Lbl_NbGamesFound.Caption:= IntToStr( lbListRoms.Items.Count ) + ' / ' +
                                    IntToStr( _TmpList.Count ) + Rst_GamesFound;

      //Focus the first game of the list
      ClearAllFields;

      //If there are games in the list, automatically display the first one
      if ( lbListRoms.Items.Count > 0 ) then begin
         EnableControls( True );
         lbListRoms.Selected[0]:= True;
         LoadGame( ( lbListRoms.Items.Objects[0] as TGame ) );
         Btn_ChangeAll.Enabled:= ( Cbx_Filter.ItemIndex = 1 );
      end else begin
         Btn_ChangeAll.Enabled:= False;
         EnableControls( False );
      end;

      //re-enable the events on the fields
      FIsLoading:= False;
   end;
end;

//Loads the selected system logo into the provided TImage.
procedure TFrm_Editor.LoadSystemLogo( const aPictureName: string );
var
    idxImage: Integer;
begin
    if Assigned( icSystems ) then begin
       idxImage:= icSystems.GetIndexByName( aPictureName );
       if idxImage >= 0 then begin
          Img_System.Picture.Assign( icSystems.Images[idxImage].SourceImages[0].Image );
          Exit;
       end;
    end;
    Img_System.Picture.Graphic:= nil;
end;

//Click on a game in the list
procedure TFrm_Editor.lbListRomsClick(Sender: TObject);
begin
   ClearAllFields;
   EmptyScrapeFields;
   if ( lbListRoms.SelCount > 1 ) then begin
      EnableComponents( False );
   end else begin
      EnableComponents( True );
      LoadGame( ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame ) );
   end;
end;

//Deactivation of the components when multiselect
procedure TFrm_Editor.EnableComponents( aValue: Boolean );
begin
   Edt_Name.Enabled:= aValue;
   Edt_Genre.Enabled:= True;
   Edt_Rating.Enabled:= True;
   Edt_Region.Enabled:= True;
   Edt_Developer.Enabled:= True;
   Edt_Publisher.Enabled:= True;
   Edt_NbPlayers.Enabled:= True;
   Edt_ReleaseDate.Enabled:= True;
   Edt_RomPath.Enabled:= aValue;

   Mmo_Description.Enabled:= True;

   Cbx_KidGame.Enabled:= True;
   Cbx_Hidden.Enabled:= True;
   Cbx_Favorite.Enabled:= True;
   Chk_ListByRom.Enabled:= aValue;

   Lbl_Name.Enabled:= aValue;
   Lbl_Date.Enabled:= True;
   Lbl_Genre.Enabled:= True;
   Lbl_Region.Enabled:= True;
   Lbl_Players.Enabled:= True;
   Lbl_Rating.Enabled:= True;
   Lbl_KidGame.Enabled:= True;
   Lbl_Hidden.Enabled:= True;
   Lbl_Favorite.Enabled:= True;
   Lbl_Description.Enabled:= True;
   Lbl_Publisher.Enabled:= True;

   Lbl_Developer.Enabled:= True;
   Btn_MoreInfos.Enabled:= aValue;
   Btn_Delete.Enabled:= True;
   //Batch scraping of all selected games is supported, so the Scrape button
   //stays available during a multi-selection (aValue = False).
   Btn_Scrape.Enabled:= True;
   bScrape.Enabled := True;
   Btn_ChangeImage.Enabled:= aValue;
   Btn_ChangeVideo.Enabled:= aValue;
   Btn_RemovePicture.Enabled:= aValue;
   Btn_RemoveVideo.Enabled:= aValue;
   Btn_SetDefaultPicture.Enabled:= aValue;
   Btn_ChangeAll.Enabled:= aValue and ( Cbx_Filter.ItemIndex = 1) and ( lbListRoms.Items.Count > 0 );

   //Synchronize the state of the context menu of the media controls
   pm_ChangeImage.Enabled:= Btn_ChangeImage.Enabled;
   pm_ChangeVideo.Enabled:= Btn_ChangeVideo.Enabled;
   pm_RemovePicture.Enabled:= Btn_RemovePicture.Enabled;
   pm_RemoveVideo.Enabled:= Btn_RemoveVideo.Enabled;
   pm_SetDefaultPicture.Enabled:= Btn_SetDefaultPicture.Enabled;
   pm_ChangeAllPictures.Enabled:= Btn_ChangeAll.Enabled;

   Mnu_Game.Enabled:= aValue;
   Mnu_System.Enabled:= aValue;
   Mnu_Selection.Enabled:= not aValue;

   Chk_ManualCRC.Enabled:= Btn_Scrape.Enabled;

   //The Scrape tab stays available during a multi-selection so the batch
   //scraping progress can be displayed there.
   Tbs_Scrape.TabVisible:= True;

   if FIsWine then
      Tbs_Video.TabVisible:= False
   else
      Tbs_Video.TabVisible:= aValue;

   if aValue = false then
      StopGameVideo();
end;

procedure TFrm_Editor.StartGameVideo(const aPath: string);
begin
   if not FIsWine then
   begin
      Img_BackgroundVideo.Visible := false;
      Wmp_Video.Visible := true;
      Wmp_Video.URL := 'file://' + aPath;
      Wmp_Video.controls.play;
   end;
end;

procedure TFrm_Editor.StopGameVideo;
begin
   if not FIsWine then
   begin
      Img_BackgroundVideo.Visible := true;
      Wmp_Video.Visible := false;
      Wmp_Video.controls.stop;
      Wmp_Video.URL := '';
   end;
end;

procedure TFrm_Editor.UpdateVideo(aGame: TGame);
begin
   // Start playing video if the video exists and the video tab is active
   // else stop it
   if (Pgc_Media.ActivePage = Tbs_Video)
      and not (aGame.VideoPath.IsEmpty)
      and FileExists(aGame.PhysicalVideoPath) then
   begin
      StartGameVideo(aGame.PhysicalVideoPath);
   end else begin
      StopGameVideo;
   end;

   // Enable Remove video button if video exists -independent of active tab
   if not (aGame.VideoPath.IsEmpty)
      and FileExists(aGame.PhysicalVideoPath) then
   begin
      Btn_RemoveVideo.Enabled:= True;
   end else begin
      Btn_RemoveVideo.Enabled:= False;
   end;
end;

procedure TFrm_Editor.Pgc_MediaChange(Sender: TObject);
begin
  if ( lbListRoms.Count > 0 ) then
     UpdateVideo( ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame ) );
end;

//Loading into the various fields of the selected game info
procedure TFrm_Editor.LoadGame( aGame: TGame );
var
   _Image: TPngImage;
   _ImageJpg: TJPEGImage;
begin
   //re-enable the events on the fields
   FIsLoading:= True;

   Img_BackGround.Visible:= True;
   Edt_Name.Text:= aGame.Name;
   Edt_Rating.Text:= aGame.Rating;
   Edt_ReleaseDate.Text:= aGame.ReleaseDate;
   Edt_Publisher.Text:= aGame.Publisher;
   Edt_Developer.Text:= aGame.Developer;
   Edt_NbPlayers.Text:= aGame.Players;
   Edt_Genre.Text:= aGame.Genre;
   Mmo_Description.Text:= aGame.Description;
   Edt_Region.Text:= aGame.Region;
   Cbx_KidGame.ItemIndex:= aGame.KidGame;
   Cbx_Hidden.ItemIndex:= aGame.Hidden;
   Cbx_Favorite.ItemIndex:= aGame.Favorite;
   Edt_RomPath.Text:= aGame.RomPath;
   Edt_ScrapeRomPath.Text:= aGame.RomPath;

   //re-enable the events on the fields
   FIsLoading:= False;

   UpdateVideo(aGame);

   if not ( aGame.ImagePath.IsEmpty ) and
          FileExists( aGame.PhysicalImagePath ) then begin
      if ( ExtractFileExt( aGame.PhysicalImagePath ) = '.png' ) then begin
         _Image:= TPngImage.Create;
         try
            _Image.LoadFromFile( aGame.PhysicalImagePath );
            Img_Game.Picture.Graphic:= _Image;
            Btn_RemovePicture.Enabled:= True;
            //display the background image only if the game has no image
            Img_BackGround.Visible:= ( Img_Game.Picture.Graphic = nil );
            Img_Game.Visible:= ( Img_Game.Picture.Graphic <> nil );
            Btn_Scrape.Enabled:= FileExists( aGame.PhysicalRomPath );
            Chk_ManualCRC.Enabled:= Btn_Scrape.Enabled;
            Exit;
         finally
            _Image.Free;
         end;
      end else if ( ExtractFileExt( aGame.PhysicalImagePath ) = '.jpg' ) or
                  ( ExtractFileExt( aGame.PhysicalImagePath ) = '.jpeg' ) then begin
         _ImageJpg:= TJPEGImage.Create;
         try
            _ImageJpg.LoadFromFile( aGame.PhysicalImagePath );
            Img_Game.Picture.Graphic:= _ImageJpg;
            Btn_RemovePicture.Enabled:= True;
            //display the background image only if the game has no image
            Img_BackGround.Visible:= ( Img_Game.Picture.Graphic = nil );
            Img_Game.Visible:= ( Img_Game.Picture.Graphic <> nil );
            Btn_Scrape.Enabled:= FileExists( aGame.PhysicalRomPath );
            Chk_ManualCRC.Enabled:= Btn_Scrape.Enabled;
            Exit;
         finally
            _ImageJpg.Free;
         end;
      end;
   end else begin
      Btn_RemovePicture.Enabled:= False;
      Btn_Scrape.Enabled:= FileExists( aGame.PhysicalRomPath );
      Chk_ManualCRC.Enabled:= Btn_Scrape.Enabled;
      Img_BackGround.Visible:= True;
      Img_Game.Visible:= False;
   end;
end;

//Action on clicking the "change image" button
//Opens a dialog box to change the image of the selected game
procedure TFrm_Editor.Btn_ChangeImageClick(Sender: TObject);
var
   _Game: TGame;
begin
   OpenFile.Filter:= 'Images|*.png;*.jpg;*.jpeg';
   if OpenFile.Execute and ( OpenFile.FileName <> '' ) then begin
      _Game:= ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame );
      ChangeImage( OpenFile.FileName, _Game );
      LoadGame( _Game );
      lbListRoms.SetFocus;
   end;
end;

procedure TFrm_Editor.Btn_ChangeVideoClick(Sender: TObject);
var
   _Game: TGame;
begin
   OpenFile.Filter:= 'Videos|*.mp4';
   if OpenFile.Execute and ( OpenFile.FileName <> '' ) then begin
      _Game:= ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame );
      ChangeVideo( OpenFile.FileName, _Game );
      LoadGame( _Game );
      lbListRoms.SetFocus;
   end;
end;

//Set the game picture to the default image (from icDefault)
procedure TFrm_Editor.Btn_SetDefaultPictureClick(Sender: TObject);
var
    _Game: TGame;
    _Bmp: TBitmap;
begin
    _Game:= ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame );

    _Bmp:= icDefault.GetBitmap( 'default',
                                Max( Img_Game.Width, 1 ),
                                Max( Img_Game.Height, 1 ) );
    try
       Img_Game.Picture.Assign( _Bmp );
    finally
       _Bmp.Free;
    end;

    ApplyGameImage( _Game );
    LoadGame( _Game );
    lbListRoms.SetFocus;
end;

procedure TFrm_Editor.AddRomList(aRoms: TStrings);
var
  I: Integer;
  newGame : TGame;
  gameList: TObjectList<TGame>;
begin
  GSystemList.TryGetValue( getCurrentFolderName, gameList );
  
  for I := 0 to pred(aRoms.Count) do begin
    newGame := TGame.Create('./'+lbRoms.Items[i], TPath.GetFileNameWithoutExtension(lbRoms.Items[i]), 
      '', '', '', '', '', '', '', '', '', '', '', '', '', '', '');
    newGame.PhysicalRomPath:= GetPhysicalRomPath( newGame.RomPath );
    newGame.Color := clSkyBlue;
    gameList.Add(newGame);
  end;
end;

//Action on clicking "change all missing to default"
//Assigns the default image of the system to all games that have no image
procedure TFrm_Editor.aFindDuplicatesExecute(Sender: TObject);
begin
  bFindDupesClick(self);
end;

procedure TFrm_Editor.aViewGameExecute(Sender: TObject);
begin
  Pgc_Editor.ActivePage := Tbs_Main;
end;

procedure TFrm_Editor.aViewGameListsExecute(Sender: TObject);
begin
  Pgc_Editor.ActivePage := tsGameList;
end;

procedure TFrm_Editor.aViewScraperExecute(Sender: TObject);
begin
  Pgc_Editor.ActivePage := Tbs_Scrape;
end;

procedure TFrm_Editor.bAddToListClick(Sender: TObject);
var
  I: Integer;
  gameList: TStringList;
 
begin
  gameList := TStringList.Create;

  for I := 0 to pred(lbRoms.Items.Count) do begin
    if lbRoms.Selected[i] then begin
      gameList.Add(lbRoms.Items[i]);
    end;
  end;
  AddRomList(gameList);
  LoadGamesList( getCurrentFolderName );
  FreeAndNil(gameList);
end;

procedure TFrm_Editor.bScanFolderClick(Sender: TObject);
begin
  FindGameRoms(getCurrentFolderName);
end;

//Detects which media types exist for a game.
//Image/Video come from the gamelist.xml paths; the other types are looked up
//in the <system>/media/<type> folder by ROM name.
function TFrm_Editor.GetGameMediaStatus( aGame: TGame ): TGameMediaStatus;

  function HasFileInFolder( const aTypeSubFolder: string ): Boolean;
  var
     TypeDir, SearchPath: string;
     SR: TSearchRec;
  begin
     Result:= False;
     TypeDir:= FRootPath + FCurrentFolder + Cst_MediaFolderName + '\' +
               aTypeSubFolder;
     if not DirectoryExists( TypeDir ) then Exit;
     SearchPath:= TypeDir + '\' + aGame.RomNameWoExt + '.*';
     if ( FindFirst( SearchPath, faAnyFile, SR ) = 0 ) then begin
        Result:= True;
        FindClose( SR );
     end;
  end;

begin
   Result.HasImage:= FileExists( aGame.PhysicalImagePath );
   Result.HasVideo:= FileExists( aGame.PhysicalVideoPath );
   Result.HasBox:= HasFileInFolder( Cst_MediaBoxSubFolder );
   Result.HasManual:= HasFileInFolder( Cst_MediaManualSubFolder );
   Result.HasWheel:= HasFileInFolder( Cst_MediaWheelSubFolder );
   Result.HasTips:= HasFileInFolder( Cst_MediaTipsSubFolder );
   Result.HasMap:= HasFileInFolder( Cst_MediaMapSubFolder );
end;

//Rebuilds the advanced game list (lbListRoms) of the current filtered games,
//sorted by FRomsSortMode, with media statuses.
procedure TFrm_Editor.RefreshListRoms;
var
   _Game: TGame;
   _Item: TGame;
   _Items: TList<TGame>;
begin
   lbListRoms.Items.BeginUpdate;
   try
      lbListRoms.Clear;
      if FFilteredGames = nil then Exit;

      _Items:= TList<TGame>.Create;
      if FRomsStatusMap = nil then
         FRomsStatusMap:= TDictionary<TGame, TGameMediaStatus>.Create
      else
         FRomsStatusMap.Clear;
      try
         for _Game in FFilteredGames do begin
            if _Game = nil then Continue;
            _Items.Add( _Game );
            //Compute the statuses only once to avoid repeated disk scans
            FRomsStatusMap.AddOrSetValue( _Game, GetGameMediaStatus( _Game ) );
         end;

         //Sort by the selected mode (FRomsSortMode)
         _Items.Sort( TComparer<TGame>.Construct(
            function( const A, B: TGame ): Integer
            var
               SA, SB: TGameMediaStatus;
            begin
               case FRomsSortMode of
                  1: Result:= CompareText( A.RomName, B.RomName );          // by file name
                  2: begin                                                  // by image presence
                        if not FRomsStatusMap.TryGetValue( A, SA ) then
                           FillChar( SA, SizeOf( SA ), 0 );
                        if not FRomsStatusMap.TryGetValue( B, SB ) then
                           FillChar( SB, SizeOf( SB ), 0 );
                        Result:= Ord( SA.HasImage ) - Ord( SB.HasImage );
                        if Result = 0 then Result:= CompareText( A.Name, B.Name );
                     end;
                  3: begin                                                  // by video presence
                        if not FRomsStatusMap.TryGetValue( A, SA ) then
                           FillChar( SA, SizeOf( SA ), 0 );
                        if not FRomsStatusMap.TryGetValue( B, SB ) then
                           FillChar( SB, SizeOf( SB ), 0 );
                        Result:= Ord( SA.HasVideo ) - Ord( SB.HasVideo );
                        if Result = 0 then Result:= CompareText( A.Name, B.Name );
                     end;
                  4: begin                                                  // by description presence
                        Result:= Ord( not A.Description.IsEmpty ) - Ord( not B.Description.IsEmpty );
                        if Result = 0 then Result:= CompareText( A.Name, B.Name );
                     end;
               else
                  Result:= CompareText( A.Name, B.Name );                   // 0: by game name
               end;
            end ) );

         for _Item in _Items do begin
            if ( not Chk_ListByRom.Checked ) then
               lbListRoms.Items.AddObject( _Item.Name, _Item )
            else if ( Chk_FullRomName.Checked ) then
               lbListRoms.Items.AddObject( StringReplace( _Item.RomPath, './', '', [] ), _Item )
            else
               lbListRoms.Items.AddObject( _Item.RomName, _Item );
         end;
      finally
         _Items.Free;
      end;
   finally
      lbListRoms.Items.EndUpdate;
   end;
end;

//Draws one row of the advanced list: name on the left, media statuses on the right.
procedure TFrm_Editor.lbListRomsDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
   LB: TListBox;
   _Game: TGame;
   _Status: TGameMediaStatus;
   _TextWidth, _IconX: Integer;
   _Glyphs: array[0..6] of record Ch: Char; Present: Boolean; end;
   ii: Integer;
   _ThemeText: TColor;
begin
LB:= Control as TListBox;
   if ( Index < 0 ) or ( Index >= LB.Items.Count ) then Exit;

//background + text: the colors (background and font) are already set by
   //TCustomListBox.CNDrawItem according to the theme (scListBox / sfListItemTextNormal,
   //clHighlight / sfListItemTextSelected). We only fill and draw,
   //without rewriting those colors, which preserves the theme with no AV risk.
   LB.Canvas.FillRect( Rect );
   //text color set by CNDrawItem (theme): we keep it for the name
   _ThemeText:= LB.Canvas.Font.Color;

   _Game:= LB.Items.Objects[Index] as TGame;
   if _Game = nil then Exit;

   //media statuses (cached by RefreshListRoms to avoid disk scans)
   if Assigned( FRomsStatusMap ) and FRomsStatusMap.TryGetValue( _Game, _Status ) then
      { nothing: status retrieved }
   else
      _Status:= GetGameMediaStatus( _Game );
   _Glyphs[0].Ch:= 'I'; _Glyphs[0].Present:= _Status.HasImage;
   _Glyphs[1].Ch:= 'V'; _Glyphs[1].Present:= _Status.HasVideo;
   _Glyphs[2].Ch:= 'B'; _Glyphs[2].Present:= _Status.HasBox;
   _Glyphs[3].Ch:= 'M'; _Glyphs[3].Present:= _Status.HasManual;
   _Glyphs[4].Ch:= 'W'; _Glyphs[4].Present:= _Status.HasWheel;
   _Glyphs[5].Ch:= 'T'; _Glyphs[5].Present:= _Status.HasTips;
   _Glyphs[6].Ch:= 'P'; _Glyphs[6].Present:= _Status.HasMap;

   //draw the glyphs starting from the right
   _IconX:= Rect.Right - 4;
   for ii:= High( _Glyphs ) downto Low( _Glyphs ) do begin
      _IconX:= _IconX - LB.Canvas.TextWidth( ' ' + _Glyphs[ii].Ch );
      if _Glyphs[ii].Present then
         LB.Canvas.Font.Color:= clGreen
      else
         LB.Canvas.Font.Color:= clGrayText;
      LB.Canvas.TextOut( _IconX, Rect.Top, _Glyphs[ii].Ch );
   end;

   //game name on the left: theme font color (CNDrawItem)
   if _Game.Color >= 0 then
      LB.Canvas.Font.Color:= _Game.Color
   else
      LB.Canvas.Font.Color:= _ThemeText;
   _TextWidth:= _IconX - Rect.Left - 6;
   //truncate the name if needed
   LB.Canvas.TextRect( TRect.Create( Rect.Left + 2, Rect.Top,
                                     Rect.Left + 2 + _TextWidth, Rect.Bottom ),
                       Rect.Left + 2, Rect.Top, LB.Items[Index] );
end;

//Selects the item under the cursor on right-click so the shared context menu
//acts on the clicked game (right-click alone does not set ItemIndex).
procedure TFrm_Editor.lbListRomsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   Idx: Integer;
begin
   if Button = mbRight then begin
      Idx:= lbListRoms.ItemAtPos( Point( X, Y ), True );
      if Idx >= 0 then
         lbListRoms.ItemIndex:= Idx;
   end;
end;

//Changes the sort of the advanced game list
procedure TFrm_Editor.cbSortListChange(Sender: TObject);
begin
   FRomsSortMode:= cbSortList.ItemIndex;
   if FRomsSortMode < 0 then FRomsSortMode:= 0;
   RefreshListRoms;
end;

//Finds and highlights duplicates in the advanced game list
procedure TFrm_Editor.bFindDupesClick(Sender: TObject);
var
   _SystemList: TObjectList<TGame>;
   _CountByName: TDictionary<string, Integer>;
   _CountByRom: TDictionary<string, Integer>;
   _CountByCrc: TDictionary<string, Integer>;
   _FirstOfGroupByName: TDictionary<string, TGame>;
   _FirstOfGroupByRom: TDictionary<string, TGame>;
   _FirstOfGroupByCrc: TDictionary<string, TGame>;
   _Game: TGame;
   _Crc: string;
   ii: Integer;
begin
   if not GSystemList.TryGetValue( getCurrentFolderName, _SystemList ) then Exit;
   if _SystemList = nil then Exit;

   _CountByName:= TDictionary<string, Integer>.Create;
   _CountByRom:= TDictionary<string, Integer>.Create;
   _CountByCrc:= TDictionary<string, Integer>.Create;
   _FirstOfGroupByName:= TDictionary<string, TGame>.Create;
   _FirstOfGroupByRom:= TDictionary<string, TGame>.Create;
   _FirstOfGroupByCrc:= TDictionary<string, TGame>.Create;
   try
      for _Game in _SystemList do begin
         if _CountByName.ContainsKey( _Game.Name ) then
            _CountByName[_Game.Name]:= _CountByName[_Game.Name] + 1
         else
            _CountByName.Add( _Game.Name, 1 );

         if _CountByRom.ContainsKey( ExtractFileName( _Game.PhysicalRomPath ) ) then
            _CountByRom[ExtractFileName( _Game.PhysicalRomPath )]:=
               _CountByRom[ExtractFileName( _Game.PhysicalRomPath )] + 1
         else
            _CountByRom.Add( ExtractFileName( _Game.PhysicalRomPath ), 1 );

         _Crc:= _Game.Crc32;
         if not _Crc.IsEmpty then begin
            if _CountByCrc.ContainsKey( _Crc ) then
               _CountByCrc[_Crc]:= _CountByCrc[_Crc] + 1
            else
               _CountByCrc.Add( _Crc, 1 );
         end;
      end;

      //Highlight the duplicates in lbListRoms (by name, file or CRC).
      //The first game of each duplicate group is green, the following ones red,
      //so that several consecutive duplicate groups do not blend together.
      //Reset all colors first.
      for ii:= 0 to Pred( lbListRoms.Items.Count ) do begin
         _Game:= lbListRoms.Items.Objects[ii] as TGame;
         if _Game <> nil then _Game.Color:= -1;
      end;

      //Record the first game (in list order) of each duplicate group so it can
      //be highlighted in green while the other members are highlighted in red.
      for ii:= 0 to Pred( lbListRoms.Items.Count ) do begin
         _Game:= lbListRoms.Items.Objects[ii] as TGame;
         if _Game = nil then Continue;
         if ( _CountByName.ContainsKey( _Game.Name ) and
              ( _CountByName[_Game.Name] > 1 ) and
              ( not _FirstOfGroupByName.ContainsKey( _Game.Name ) ) ) then
            _FirstOfGroupByName.Add( _Game.Name, _Game );
         if ( _CountByRom.ContainsKey( ExtractFileName( _Game.PhysicalRomPath ) ) and
              ( _CountByRom[ExtractFileName( _Game.PhysicalRomPath )] > 1 ) and
              ( not _FirstOfGroupByRom.ContainsKey( ExtractFileName( _Game.PhysicalRomPath ) ) ) ) then
            _FirstOfGroupByRom.Add( ExtractFileName( _Game.PhysicalRomPath ), _Game );
         if ( not _Game.Crc32.IsEmpty ) and
            _CountByCrc.ContainsKey( _Game.Crc32 ) and
            ( _CountByCrc[_Game.Crc32] > 1 ) and
            ( not _FirstOfGroupByCrc.ContainsKey( _Game.Crc32 ) ) then
            _FirstOfGroupByCrc.Add( _Game.Crc32, _Game );
      end;

      //Mark the first (in list order) and the following members of each group.
      //A game can belong to several groups (name, rom file, crc); green (group
      //starter) takes precedence over red.
      for ii:= 0 to Pred( lbListRoms.Items.Count ) do begin
         _Game:= lbListRoms.Items.Objects[ii] as TGame;
         if _Game = nil then Continue;

         //Name group
         if ( _CountByName.ContainsKey( _Game.Name ) and
              ( _CountByName[_Game.Name] > 1 ) ) then begin
            if _Game.Color = -1 then _Game.Color:= clRed;
            if _FirstOfGroupByName.ContainsKey( _Game.Name ) and
               ( _FirstOfGroupByName[_Game.Name] = _Game ) then
               _Game.Color:= clGreen;
         end;

         //ROM file group
         if ( _CountByRom.ContainsKey( ExtractFileName( _Game.PhysicalRomPath ) ) and
              ( _CountByRom[ExtractFileName( _Game.PhysicalRomPath )] > 1 ) ) then begin
            if _Game.Color = -1 then _Game.Color:= clRed;
            if _FirstOfGroupByRom.ContainsKey( ExtractFileName( _Game.PhysicalRomPath ) ) and
               ( _FirstOfGroupByRom[ExtractFileName( _Game.PhysicalRomPath )] = _Game ) then
               _Game.Color:= clGreen;
         end;

         //CRC group
         if ( not _Game.Crc32.IsEmpty ) and
            _CountByCrc.ContainsKey( _Game.Crc32 ) and
            ( _CountByCrc[_Game.Crc32] > 1 ) then begin
            if _Game.Color = -1 then _Game.Color:= clRed;
            if _FirstOfGroupByCrc.ContainsKey( _Game.Crc32 ) and
               ( _FirstOfGroupByCrc[_Game.Crc32] = _Game ) then
               _Game.Color:= clGreen;
         end;
      end;
      lbListRoms.Invalidate;
      mLog.Lines.Add( 'Duplicates highlighted (by name / file / CRC)' );
   finally
      _CountByName.Free;
      _CountByRom.Free;
      _CountByCrc.Free;
      _FirstOfGroupByName.Free;
      _FirstOfGroupByRom.Free;
      _FirstOfGroupByCrc.Free;
   end;
end;

//Set all game pictures to the default image (from icDefault)
procedure TFrm_Editor.Btn_ChangeAllClick(Sender: TObject);
var
    ii: Integer;
    _Game: TGame;
    _Bmp: TBitmap;
begin
    _Bmp:= icDefault.GetBitmap( 'default',
                                Max( Img_Game.Width, 1 ),
                                Max( Img_Game.Height, 1 ) );

    ProgressBar.Visible:= True;
    ProgressBar.Max:= Pred( lbListRoms.Items.Count );
    ProgressBar.Position:= 0;
    for ii:= 0 to Pred( lbListRoms.Items.Count ) do begin
       _Game:= ( lbListRoms.Items.Objects[ii] as TGame );
       Img_Game.Picture.Assign( _Bmp );
       ApplyGameImage( _Game );
       ProgressBar.Position:= ( ProgressBar.Position + 1 );
    end;
    ProgressBar.Visible:= False;

    _Bmp.Free;
    LoadGamesList( getCurrentFolderName );
    lbListRoms.SetFocus;
end;

//Replaces the current image of the game (with another one or the default).
procedure TFrm_Editor.ChangeImage( const aPath: string; aGame: TGame );
var
    _Image: TPngImage;
    _ImageJpg: TJPEGImage;
begin
    if ( ExtractFileExt( aPath ) = '.png' ) then begin
       _Image:= TPngImage.Create;
       try
          _Image.LoadFromFile( aPath );
          Img_Game.Picture.Graphic:= _Image;
       finally
          _Image.Free;
       end;
    end else begin
       _ImageJpg:= TJPEGImage.Create;
       try
          _ImageJpg.LoadFromFile( aPath );
          Img_Game.Picture.Graphic:= _ImageJpg;
       finally
          _ImageJpg.Free;
       end;
    end;

    ApplyGameImage( aGame );
end;

procedure TFrm_Editor.ApplyGameImage( aGame: TGame );
var
    _Node: IXMLNode;
    _NodeAdded: Boolean;
    _ImageLink, _ImageFolder: string;
begin
    Screen.Cursor:= crHourGlass;

    _ImageFolder:= GetImageFolderPath;
    if not EnsureMediaFolder( _ImageFolder ) then Exit;

    Img_Game.Picture.SaveToFile( FRootPath + FCurrentFolder + _ImageFolder +
                                 '\' + aGame.RomNameWoExt + Cst_ImageSuffixPng );

    XMLDoc.LoadFromFile( FRootPath + FCurrentFolder + Cst_GameListFileName );

    _Node := XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );

    repeat
       if ( _Node.ChildNodes.Nodes[Cst_Path].Text = aGame.RomPath ) then Break;
       _Node := _Node.NextSibling;
    until not Assigned( _Node );

    _ImageLink:= _ImageFolder + aGame.RomNameWoExt + Cst_ImageSuffixPng;

    _NodeAdded:= False;
    if not Assigned( _Node.ChildNodes.FindNode( Cst_ImageLink ) ) then begin
       _Node.AddChild( Cst_ImageLink );
       _NodeAdded:= True;
    end;
    _Node.ChildNodes.Nodes[Cst_ImageLink].Text:= _ImageLink;

    if _NodeAdded then begin
       XMLDoc.XML.Text:= Xml.Xmldoc.FormatXMLData( XMLDoc.XML.Text );
       XMLDoc.Active:= True;
    end;
    XMLDoc.SaveToFile( FRootPath + FCurrentFolder + Cst_GameListFileName );
    XMLDoc.Active:= False;
    FGameListChanged:= True;

    aGame.ImagePath:= _ImageLink;
    aGame.PhysicalImagePath:= FRootPath + FCurrentFolder +
                              IncludeTrailingPathDelimiter( _ImageFolder ) +
                              aGame.RomNameWoExt + Cst_ImageSuffixPng;

    Screen.Cursor:= crDefault;
end;

// Replace the video of a game.
procedure TFrm_Editor.ChangeVideo( const aPath: string; aGame: TGame );
var
   _VideoLink, _VideoFolder: string;
   _Node: IXMLNode;
   _NodeAdded: Boolean;
begin
   _NodeAdded:= False;
   Screen.Cursor:= crHourGlass;

   StopGameVideo();

   _VideoFolder:= GetVideoFolderPath;

   // Create the video directory if not existing
   if not EnsureMediaFolder( _VideoFolder ) then Exit;

   // Copy the video to the rompath
   TFile.Copy(aPath, FRootPath + FCurrentFolder + _VideoFolder +
                     '\' + aGame.RomNameWoExt + Cst_VideoSuffixMp4, true );

   // Open the gamelist XML file
   XMLDoc.LoadFromFile( FRootPath + FCurrentFolder + Cst_GameListFileName );

   // Get the first game node
   _Node := XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );

   // And we loop to find the node with the right Id
   repeat
      if ( _Node.ChildNodes.Nodes[Cst_Path].Text = aGame.RomPath ) then Break;
      _Node := _Node.NextSibling;
   until not Assigned( _Node );

   // We write the path to the video
   _VideoLink:= _VideoFolder + aGame.RomNameWoExt + Cst_VideoSuffixMp4;

   if not Assigned( _Node.ChildNodes.FindNode( Cst_VideoLink ) ) then begin
      _Node.AddChild( Cst_VideoLink );
      _NodeAdded:= True;
   end;
   _Node.ChildNodes.Nodes[Cst_VideoLink].Text:= _VideoLink;

   // Save the file
   if _NodeAdded then begin
      XMLDoc.XML.Text:= Xml.Xmldoc.FormatXMLData( XMLDoc.XML.Text );
      XMLDoc.Active:= True;
   end;
   XMLDoc.SaveToFile( FRootPath + FCurrentFolder + Cst_GameListFileName );
   XMLDoc.Active:= False;
   FGameListChanged:= True;

   // And finally we update the associated TGame object
   aGame.VideoPath:= _VideoLink;
   aGame.PhysicalVideoPath:= FRootPath + FCurrentFolder +
                             IncludeTrailingPathDelimiter( _VideoFolder ) +
                             aGame.RomNameWoExt + Cst_VideoSuffixMp4;

   Screen.Cursor:= crDefault;
end;

//On clicking the delete picture button
procedure TFrm_Editor.Btn_RemovePictureClick(Sender: TObject);
begin
   DeleteGamePicture;
   lbListRoms.SetFocus;
end;

procedure TFrm_Editor.Btn_RemoveVideoClick(Sender: TObject);
begin
   DeleteGameVideo;
   lbListRoms.SetFocus;
end;

//Deletes a game's image (in the xml and physically)
procedure TFrm_Editor.DeleteGamePicture;
var
   _Game: TGame;
   _GameListPath: string;
   _Node: IXMLNode;
   _ImageReused: Boolean;
begin
   //start by retrieving the corresponding TGame object
   _Game:= ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame );

   //build the path to the gamelist.xml
   _GameListPath:= FRootPath + FCurrentFolder + Cst_GameListFileName;

   //Open the xml file
   XMLDoc.LoadFromFile( _GameListPath );

   // Find out if the image is used anywhere else other than in this game
   _ImageReused := false;
   _Node := XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );
   repeat
      if not ( _Node.ChildNodes.Nodes[Cst_Path].Text = _Game.RomPath ) then
         if ( _Node.ChildNodes.FindNode(Cst_ImageLink).Text = _Game.ImagePath ) then _ImageReused := true;
      _Node := _Node.NextSibling;
   until not Assigned( _Node ) or _ImageReused;

   //Retrieve the first "game" node
   _Node := XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );

   //And loop to find the right node
   repeat
      if ( _Node.ChildNodes.Nodes[Cst_Path].Text = _Game.RomPath ) then Break;
         _Node := _Node.NextSibling;
   until not Assigned( _Node );

   //remove the node from the xml file
   _Node.ChildNodes.FindNode( Cst_ImageLink ).Text:= '';
   XMLDoc.Active:= True;
   XMLDoc.SaveToFile( _GameListPath );
   XMLDoc.Active:= False;
   FGameListChanged:= True;

   //Delete the game image
   if not _ImageReused then
      DeleteFile( _Game.PhysicalImagePath );

   //clear the game image
   Img_Game.Picture.Graphic:= nil;

   //update the TGame object
   _Game.ImagePath:= '';

   //reload the game to reflect the changes
   LoadGame( _Game );
end;

// Remove the image from a game (in the XML and physically)
procedure TFrm_Editor.DeleteGameVideo;
var
   _Game: TGame;
   _GameListPath: string;
   _Node: IXMLNode;
   _VideoReused: Boolean;
begin
   Screen.Cursor:= crHourGlass;

   // Start by retrieving the corresponding TGame object
   _Game:= ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame );

   // Build the path to the gamelist.xml
   _GameListPath:= FRootPath + FCurrentFolder + Cst_GameListFileName;

   // We open the xml file
   XMLDoc.LoadFromFile( _GameListPath );

   // Find out if the video is used anywhere else other than in this game
   _VideoReused := false;
   _Node := XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );
   repeat
      if not ( _Node.ChildNodes.Nodes[Cst_Path].Text = _Game.RomPath ) then
         if ( _Node.ChildNodes.FindNode(Cst_VideoLink).Text = _Game.VideoPath ) then _VideoReused := true;
      _Node := _Node.NextSibling;
   until not Assigned( _Node ) or _VideoReused;

   // Get the first "game" node
   _Node := XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );

   // And we loop to find the right node
   repeat
      if ( _Node.ChildNodes.Nodes[Cst_Path].Text = _Game.RomPath ) then Break;
         _Node := _Node.NextSibling;
   until not Assigned( _Node );

   // Remove the node from the xml file
   _Node.ChildNodes.FindNode( Cst_VideoLink ).Text:= '';
   XMLDoc.Active:= True;
   XMLDoc.SaveToFile( _GameListPath );
   XMLDoc.Active:= False;
   FGameListChanged:= True;

   StopGameVideo();

   // Remove physical file
   if not _VideoReused then
      DeleteFile( _Game.PhysicalVideoPath );

   // Update the TGame object
   _Game.VideoPath:= '';

   Screen.Cursor:= crDefault;

   // Reload the game to reflect the changes
   LoadGame( _Game );
end;

//Retrieves the enum name of the system selected in the combobox
function TFrm_Editor.getSystemKind: TSystemKind;
begin
   Result:= TSystemKindObject( Cbx_Systems.Items.Objects[Cbx_Systems.ItemIndex] ).FSystemKind;
end;

//Retrieves the folder name of the system selected in the combobox
function TFrm_Editor.getCurrentFolderName: string;
begin
   if getSystemKind = skOther then
      Result:= Cbx_Systems.Text
   else
      Result:= Cst_SystemKindFolderNames[getSystemKind];
end;

//Retrieves the logo name of the selected system in the combobox
function TFrm_Editor.GetCurrentLogoName: string;
begin
   Result:= Cst_SystemKindImageNames[getSystemKind];
end;

//Retrieves the systemid of the selected system in the combobox
function TFrm_Editor.GetCurrentSystemId: string;
begin
   Result:= Cst_SystemKindId[getSystemKind];
end;

//Action on clicking the "save changes" button
procedure TFrm_Editor.Btn_SaveChangesClick( Sender: TObject );
begin
   if lbListRoms.SelCount > 1 then
      SaveBatchChangesToGamelist()
   else
      SaveChangesToGamelist( False, False, False, True );
      
   Btn_SaveChanges.Enabled:= False;
//   lbListRoms.SetFocus;
   if Assigned( FPrevWinControl ) then
      FPrevWinControl.SetFocus;
end;

//clearing the scrape fields
procedure TFrm_Editor.EmptyScrapeFields;
begin
   Edt_ScrapeGenre.Text:= '';
   Edt_ScrapeName.Text:= '';
   Edt_ScrapePlayers.Text:= '';
   Edt_ScrapeDate.Text:= '';
   Edt_ScrapeRegion.Text:= '';
   Edt_ScrapeDeveloper.Text:= '';
   Edt_ScrapePublisher.Text:= '';
   Edt_ScrapeRating.Text:= '';
   Mmo_ScrapeDescription.Text:= '';
   Img_Scrape.Picture.Graphic:= nil;
   Img_ScrapeBackground.Visible:= True;

   EnableScrapeComponents( False );

   FInfosList.Clear;
   FPictureLinks.Clear;
   FImgList.Clear;
end;


procedure TFrm_Editor.SaveBatchChangesToGamelist();

   //Ensures a node exists
   function NodeExists( aNode: IXMLNode; const aNodeName: string ): Boolean;
   begin
      Result:= False;
      if Assigned( aNode.ChildNodes.FindNode( aNodeName ) ) then
         Result:= True;
   end;

var
   _Node: IXMLNode;
   _Game: TGame;
   _GameListPath, _Date,
   Region, Rating, Developer, Players,
   Description, Publisher, Date, Genre: string;
   _NodeAdded: Boolean;
   _Index, ii, KidGame, Hidden, Favorite: Integer;
begin
   Screen.Cursor:= crHourGlass;

   try
      _NodeAdded:= False;

      //Retrieve the path to the gamelist.xml file
      _GameListPath:= FRootPath + FCurrentFolder + Cst_GameListFileName;

      _Index:= lbListRoms.ItemIndex;

      //Open the xml file
      XMLDoc.LoadFromFile( _GameListPath );

      Screen.Cursor:= crHourGlass;
      ProgressBar.Visible:= True;
      ProgressBar.Position:= 0;
      ProgressBar.Max:= lbListRoms.SelCount;

      Genre:= Edt_Genre.Text;
      Rating:= Edt_Rating.Text;
      Players:= Edt_NbPlayers.Text;
      Developer:= Edt_Developer.Text;
      Date:= Edt_ReleaseDate.Text;
      Publisher:= Edt_Publisher.Text;
      Description:= Mmo_Description.Text;
      Region:= Edt_Region.Text;
      KidGame:= Cbx_KidGame.ItemIndex;
      Hidden:= Cbx_Hidden.ItemIndex;
      Favorite:= Cbx_Favorite.ItemIndex;

      //loop over the selected games
      for ii:= 0 to Pred( lbListRoms.Items.Count ) do begin
        if ( lbListRoms.Selected[ii] ) then begin

          //Retrieve the corresponding game
          _Game:= ( lbListRoms.Items.Objects[ii] as TGame );         
        
          //Retrieve the first "game" node
          _Node := XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );
          
          //And loop to find the right node
          repeat
            if ( _Node.ChildNodes.Nodes[Cst_Path].Text = _Game.RomPath ) then Break;
            _Node := _Node.NextSibling;
          until not Assigned( _Node );

          //We can now update the info in the xml if needed
          if (Genre <> '') and not ( _Game.Genre.Equals( Genre ) ) then begin
            if not ( NodeExists( _Node, Cst_Genre ) ) then begin
               _Node.AddChild( Cst_Genre );
               _NodeAdded:= True;
            end;
            _Node.ChildNodes.Nodes[Cst_Genre].Text:= Genre;
            _Game.Genre:= Genre;
          end;

          if (Rating <> '') and not ( _Game.Rating.Equals( Rating ) ) then begin
            if not ( NodeExists( _Node, Cst_Rating ) ) then begin
               _Node.AddChild( Cst_Rating );
               _NodeAdded:= True;
            end;
            _Node.ChildNodes.Nodes[Cst_Rating].Text:= Rating;
            _Game.Rating:= Rating;
          end;

          if (Players <> '') and not ( _Game.Players.Equals( Players ) ) then begin
            if not ( NodeExists( _Node, Cst_Players ) ) then begin
               _Node.AddChild( Cst_Players );
               _NodeAdded:= True;
            end;
            _Node.ChildNodes.Nodes[Cst_Players].Text:= Players;
            _Game.Players:= Players;
          end;

          if (Developer <> '') and not ( _Game.Developer.Equals( Developer ) ) then begin
            if not ( NodeExists( _Node, Cst_Developer ) ) then begin
               _Node.AddChild( Cst_Developer );
               _NodeAdded:= True;
            end;
            _Node.ChildNodes.Nodes[Cst_Developer].Text:= Developer;
            _Game.Developer:= Developer;
          end;

          if (Date <> '') and not ( _Game.ReleaseDate.Equals( Date ) ) then begin
            if not ( NodeExists( _Node, Cst_ReleaseDate ) ) then begin
               _Node.AddChild( Cst_ReleaseDate );
               _NodeAdded:= True;
            end;
            _Date:= FormatDateFromString( Date, True );
            if not _Date.IsEmpty then
               _Game.ReleaseDate:= Date
            else begin
               _Game.ReleaseDate:= '';
            end;
            _Node.ChildNodes.Nodes[Cst_ReleaseDate].Text:= _Date;
          end;
                   
          if (Publisher <> '') and not ( _Game.Publisher.Equals( Publisher ) ) then begin
            if not ( NodeExists( _Node, Cst_Publisher ) ) then begin
               _Node.AddChild( Cst_Publisher );
               _NodeAdded:= True;
            end;
            _Node.ChildNodes.Nodes[Cst_Publisher].Text:= Publisher;
            _Game.Publisher:= Publisher;
          end;

          if (Description <> '') and not ( _Game.Description.Equals( Description ) ) then begin
            if not ( NodeExists( _Node, Cst_Description ) ) then begin
               _Node.AddChild( Cst_Description );
               _NodeAdded:= True;
            end;
            _Node.ChildNodes.Nodes[Cst_Description].Text:= Description;
            _Game.Description:= Description;
          end;

          if (Region <> '') and not ( _Game.Region.Equals( Region ) ) then begin
            if not ( NodeExists( _Node, Cst_Region ) ) then begin
               _Node.AddChild( Cst_Region );
               _NodeAdded:= True;
            end;
            _Node.ChildNodes.Nodes[Cst_Region].Text:= Region;
            _Game.Region:= Region;
          end;

          if (KidGame <> -1) and not ( _Game.KidGame = KidGame ) then begin
            if not ( NodeExists( _Node, Cst_KidGame ) ) then begin
               _Node.AddChild( Cst_KidGame );
               _NodeAdded:= True;
            end;
            if ( Cbx_KidGame.ItemIndex = 0 ) then _Node.ChildNodes.Nodes[Cst_KidGame].Text:= Cst_False
            else _Node.ChildNodes.Nodes[Cst_KidGame].Text:= Cst_True;
            _Game.KidGame:= KidGame;
          end;

          if (Hidden <> -1) and not ( _Game.Hidden = Hidden ) then begin
            if not ( NodeExists( _Node, Cst_Hidden ) ) then begin
               _Node.AddChild( Cst_Hidden );
               _NodeAdded:= True;
            end;
            if ( Cbx_Hidden.ItemIndex = 0 ) then _Node.ChildNodes.Nodes[Cst_Hidden].Text:= Cst_False
            else _Node.ChildNodes.Nodes[Cst_Hidden].Text:= Cst_True;
            _Game.Hidden:= Hidden;
          end;

          if (Favorite <> -1) and not ( _Game.Favorite = Favorite ) then begin
            if not ( NodeExists( _Node, Cst_Favorite ) ) then begin
               _Node.AddChild( Cst_Favorite );
               _NodeAdded:= True;
            end;
            if ( Cbx_Favorite.ItemIndex = 0 ) then _Node.ChildNodes.Nodes[Cst_Favorite].Text:= Cst_False
            else _Node.ChildNodes.Nodes[Cst_Favorite].Text:= Cst_True;
            _Game.Favorite:= Favorite;
          end;

          ProgressBar.Position:= ProgressBar.Position + 1;
        end;
      end;

      ProgressBar.Visible:= False;

      //And finally save the file (formatting correctly if a node was added)
      if _NodeAdded then begin
         XMLDoc.XML.Text:= Xml.Xmldoc.FormatXMLData( XMLDoc.XML.Text );
         XMLDoc.Active:= True;
      end;
      XMLDoc.SaveToFile( _GameListPath );
      XMLDoc.Active:= False;

      //mark the current gamelist as modified if something actually changed
      if _NodeAdded then
         FGameListChanged:= True;

      //refresh the list
      LoadGamesList( getCurrentFolderName );

      if ( lbListRoms.Count > 0 ) then lbListRoms.Selected[0]:= False;

      //and restore the selection on the right item if possible
      if ( lbListRoms.Count = 0 ) then
         lbListRoms.ItemIndex:= -1
      else if ( lbListRoms.Count > 0 ) then begin
         if ( _Index >= lbListRoms.Count ) then begin
            lbListRoms.ItemIndex:= Pred( lbListRoms.Count );
         end else
         lbListRoms.ItemIndex:= _Index;
      end;

      if ( lbListRoms.Count > 0 ) then begin
         lbListRoms.Selected[lbListRoms.ItemIndex]:= True;
         LoadGame( ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame ) );
      end;

   finally
      Screen.Cursor:= crDefault;
   end;
end;


//Saves the changes made for the game in the .xml file
//and refreshes the listbox if needed
procedure TFrm_Editor.SaveChangesToGamelist( aScrape, aSaveVideo, aSavePic, aSaveInfos: Boolean );

   //Ensures a node exists
   function NodeExists( aNode: IXMLNode; const aNodeName: string ): Boolean;
   begin
      Result:= False;
      if Assigned( aNode.ChildNodes.FindNode( aNodeName ) ) then
         Result:= True;
   end;

var
   _Node: IXMLNode;
   _Game: TGame;
   _GameListPath, _Date, _NewName, _ImageLink, _VideoLink,
   Name, Region, Rating, Developer, Players,
   Description, Publisher, Date, Genre, VideoPath,
   _ImageFolder, _VideoFolder: string;
   _NodeAdded, _NameChanged: Boolean;
   _Index: Integer;
begin
   Screen.Cursor:= crHourGlass;

   try
      _NodeAdded:= False;
      _NameChanged:= False;

      //Retrieve the path to the gamelist.xml file
      _GameListPath:= FRootPath + FCurrentFolder + Cst_GameListFileName;

      //Retrieve the TGame object we want to modify
      if aScrape then _Game:= FScrapedGame
      else _Game:= ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame );

      _Index:= lbListRoms.ItemIndex;

      //Open the xml file
      XMLDoc.LoadFromFile( _GameListPath );

      //Retrieve the first "game" node
      _Node := XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );
      if not Assigned( _Node) then Exit;

      //And loop to find the right node
      repeat
         if ( _Node.ChildNodes.Nodes[Cst_Path].Text = _Game.RomPath ) then Break;
         _Node:= _Node.NextSibling;
      until not Assigned( _Node );

      //A game that was added by "Scan for ROMs" is in memory but has no node
      //in the gamelist.xml yet. Create one so the scraped/saved data is written
      //instead of silently discarding it.
      if not Assigned( _Node ) then begin
         _Node:= XMLDoc.DocumentElement.AddChild( Cst_Game );
         _Node.AddChild( Cst_Path ).Text:= _Game.RomPath;
         _Node.AddChild( Cst_Name ).Text:= _Game.Name;
         _NodeAdded:= True;
      end;

      if aSaveInfos then begin
         //We can now update the info in the xml if needed
         if aScrape then Name:= Edt_ScrapeName.Text
         else Name:= Edt_Name.Text;
         if not ( _Game.Name.Equals( Name ) ) then begin
            _Node.ChildNodes.Nodes[Cst_Name].Text:= Name;
            _Game.Name:= Name;
            lbListRoms.Items[lbListRoms.ItemIndex]:= Name;
            _NameChanged:= True;
            _NewName:= Name;
         end;

         if aScrape then Genre:= Edt_ScrapeGenre.Text
         else Genre:= Edt_Genre.Text;
         if not ( _Game.Genre.Equals( Genre ) ) then begin
            if not ( NodeExists( _Node, Cst_Genre ) ) then begin
               _Node.AddChild( Cst_Genre );
               _NodeAdded:= True;
            end;
            _Node.ChildNodes.Nodes[Cst_Genre].Text:= Genre;
            _Game.Genre:= Genre;
         end;

         if aScrape then Rating:= Edt_ScrapeRating.Text
         else Rating:= Edt_Rating.Text;
         if not ( _Game.Rating.Equals( Rating ) ) then begin
            if not ( NodeExists( _Node, Cst_Rating ) ) then begin
               _Node.AddChild( Cst_Rating );
               _NodeAdded:= True;
            end;
            _Node.ChildNodes.Nodes[Cst_Rating].Text:= Rating;
            _Game.Rating:= Rating;
         end;

         if aScrape then Players:= Edt_ScrapePlayers.Text
         else Players:= Edt_NbPlayers.Text;
         if not ( _Game.Players.Equals( Players ) ) then begin
            if not ( NodeExists( _Node, Cst_Players ) ) then begin
               _Node.AddChild( Cst_Players );
               _NodeAdded:= True;
            end;
            _Node.ChildNodes.Nodes[Cst_Players].Text:= Players;
            _Game.Players:= Players;
         end;

         if aScrape then Developer:= Edt_ScrapeDeveloper.Text
         else Developer:= Edt_Developer.Text;
         if not ( _Game.Developer.Equals( Developer ) ) then begin
            if not ( NodeExists( _Node, Cst_Developer ) ) then begin
               _Node.AddChild( Cst_Developer );
               _NodeAdded:= True;
            end;
            _Node.ChildNodes.Nodes[Cst_Developer].Text:= Developer;
            _Game.Developer:= Developer;
         end;

         if aScrape then Date:= Edt_ScrapeDate.Text
         else Date:= Edt_ReleaseDate.Text;
         if not ( _Game.ReleaseDate.Equals( Date ) ) then begin
            if not ( NodeExists( _Node, Cst_ReleaseDate ) ) then begin
               _Node.AddChild( Cst_ReleaseDate );
               _NodeAdded:= True;
            end;
            _Date:= FormatDateFromString( Date, True );
            if not _Date.IsEmpty then
               _Game.ReleaseDate:= Date
            else begin
               _Game.ReleaseDate:= '';
               if aScrape then Edt_ScrapeDate.Text:= ''
               else Edt_ReleaseDate.Text:= '';
            end;
            _Node.ChildNodes.Nodes[Cst_ReleaseDate].Text:= _Date;
         end;

         if aScrape then Publisher:= Edt_ScrapePublisher.Text
         else Publisher:= Edt_Publisher.Text;
         if not ( _Game.Publisher.Equals( Publisher ) ) then begin
            if not ( NodeExists( _Node, Cst_Publisher ) ) then begin
               _Node.AddChild( Cst_Publisher );
               _NodeAdded:= True;
            end;
            _Node.ChildNodes.Nodes[Cst_Publisher].Text:= Publisher;
            _Game.Publisher:= Publisher;
         end;

         if aScrape then Description:= Mmo_ScrapeDescription.Text
         else Description:= Mmo_Description.Text;
         if not ( _Game.Description.Equals( Description ) ) then begin
            if not ( NodeExists( _Node, Cst_Description ) ) then begin
               _Node.AddChild( Cst_Description );
               _NodeAdded:= True;
            end;
            _Node.ChildNodes.Nodes[Cst_Description].Text:= Description;
            _Game.Description:= Description;
         end;

         if aScrape then Region:= Edt_ScrapeRegion.Text
         else Region:= Edt_Region.Text;
         if not ( _Game.Region.Equals( Region ) ) then begin
            if not ( NodeExists( _Node, Cst_Region ) ) then begin
               _Node.AddChild( Cst_Region );
               _NodeAdded:= True;
            end;
            _Node.ChildNodes.Nodes[Cst_Region].Text:= Region;
            _Game.Region:= Region;
         end;

         if not aScrape then begin
            if not ( _Game.KidGame = Cbx_KidGame.ItemIndex ) then begin
               if not ( NodeExists( _Node, Cst_KidGame ) ) then begin
                  _Node.AddChild( Cst_KidGame );
                  _NodeAdded:= True;
               end;
               if ( Cbx_KidGame.ItemIndex = 0 ) then _Node.ChildNodes.Nodes[Cst_KidGame].Text:= Cst_False
               else _Node.ChildNodes.Nodes[Cst_KidGame].Text:= Cst_True;
               _Game.KidGame:= Cbx_KidGame.ItemIndex;
            end;

            if not ( _Game.Hidden = Cbx_Hidden.ItemIndex ) then begin
               if not ( NodeExists( _Node, Cst_Hidden ) ) then begin
                  _Node.AddChild( Cst_Hidden );
                  _NodeAdded:= True;
               end;
               if ( Cbx_Hidden.ItemIndex = 0 ) then _Node.ChildNodes.Nodes[Cst_Hidden].Text:= Cst_False
               else _Node.ChildNodes.Nodes[Cst_Hidden].Text:= Cst_True;
               _Game.Hidden:= Cbx_Hidden.ItemIndex;
            end;

            if not ( _Game.Favorite = Cbx_Favorite.ItemIndex ) then begin
               if not ( NodeExists( _Node, Cst_Favorite ) ) then begin
                  _Node.AddChild( Cst_Favorite );
                  _NodeAdded:= True;
               end;
               if ( Cbx_Favorite.ItemIndex = 0 ) then _Node.ChildNodes.Nodes[Cst_Favorite].Text:= Cst_False
               else _Node.ChildNodes.Nodes[Cst_Favorite].Text:= Cst_True;
               _Game.Favorite:= Cbx_Favorite.ItemIndex;
            end;
         end;
      end;

      if ( aSavePic ) and ( Img_Scrape.Picture.Graphic <> nil ) then begin
         _ImageFolder:= GetImageFolderPath;
         if not EnsureMediaFolder( _ImageFolder ) then Exit;

         Img_Scrape.Picture.SaveToFile( FRootPath + FCurrentFolder + _ImageFolder +
                                        '\' + FScrapedGame.RomNameWoExt + Cst_ImageSuffixPng );

         _ImageLink:= _ImageFolder + FScrapedGame.RomNameWoExt + Cst_ImageSuffixPng;

         if not Assigned( _Node.ChildNodes.FindNode( Cst_ImageLink ) ) then begin
            _Node.AddChild( Cst_ImageLink );
            _NodeAdded:= True;
         end;
         _Node.ChildNodes.Nodes[Cst_ImageLink].Text:= _ImageLink;
         _Game.ImagePath := _ImageLink;
         _Game.PhysicalImagePath := GetPhysicalMediaPath(_ImageLink);
      end;

      if ( aSaveVideo ) and ( FVideoScrapeLink <> '' ) then begin
         _VideoFolder:= GetVideoFolderPath;
         if not EnsureMediaFolder( _VideoFolder ) then Exit;

         VideoPath := FRootPath + FCurrentFolder + _VideoFolder +
                           '\' + FScrapedGame.RomNameWoExt + Cst_VideoSuffixMp4;
         SaveLinkToFile ( FVideoScrapeLink, VideoPath );

         _VideoLink:= _VideoFolder + FScrapedGame.RomNameWoExt + Cst_VideoSuffixMp4;

         if not Assigned( _Node.ChildNodes.FindNode( Cst_VideoLink ) ) then begin
            _Node.AddChild( Cst_VideoLink );
            _NodeAdded:= True;
         end;
         _Node.ChildNodes.Nodes[Cst_VideoLink].Text:= _VideoLink;
         _Game.VideoPath := _VideoLink;
         _Game.PhysicalVideoPath := GetPhysicalMediaPath(_VideoLink);
      end;

      //And finally save the file (formatting correctly if a node was added)
      if _NodeAdded then begin
         Screen.Cursor:= crHourGlass;
         XMLDoc.XML.Text:= Xml.Xmldoc.FormatXMLData( XMLDoc.XML.Text );
         Screen.Cursor:= crDefault;
         XMLDoc.Active:= True;
      end;
      XMLDoc.SaveToFile( _GameListPath );
      XMLDoc.Active:= False;

      //mark the current gamelist as modified if something actually changed
      if ( _NameChanged ) or ( _NodeAdded ) then
         FGameListChanged:= True;

      //refresh the list
      LoadGamesList( getCurrentFolderName );

      if ( lbListRoms.Count > 0 ) then lbListRoms.Selected[0]:= False;

      //and restore the selection on the right item if possible
      if ( lbListRoms.Count = 0 ) then
         lbListRoms.ItemIndex:= -1
      else if ( lbListRoms.Count > 0 ) then begin
         if _NameChanged then begin
            if ( lbListRoms.Items.IndexOf( _NewName ) >=0 ) then
               lbListRoms.ItemIndex:= lbListRoms.Items.IndexOf( _NewName )
            else
            lbListRoms.ItemIndex:= Pred( _Index );
         end else if ( _Index >= lbListRoms.Count ) then begin
            lbListRoms.ItemIndex:= Pred( lbListRoms.Count );
         end else
         lbListRoms.ItemIndex:= _Index;
      end;

      if aScrape then begin
         Pgc_Editor.ActivePage:= Tbs_Main;
         Tbs_ScrapeHide( nil );
      end;

      if ( lbListRoms.Count > 0 ) then begin
         lbListRoms.Selected[lbListRoms.ItemIndex]:= True;
         LoadGame( ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame ) );
      end;

   finally
      Screen.Cursor:= crDefault;
   end;
end;

procedure TFrm_Editor.SaveGamelist(const FileName: string;
  aGameList: TObjectList<TGame>);

  //Adds a child node to aNode only when aValue is not empty, so that no empty
  //tags (e.g. <video></video>) are written. Some consoles (e.g. the R36H) do
  //not show descriptions and pictures when such empty tags are present.
  procedure AddNonEmptyChild( aNode: IXMLNode; const aTag, aValue: string );
  begin
     if not aValue.IsEmpty then
        aNode.AddChild( aTag ).Text:= aValue;
  end;

  //Returns aValue prefixed with "./" (required by the console for relative
  //image/video paths) unless it is empty or already prefixed.
  function WithLinkPrefix( const aValue: string ): string;
  begin
     Result:= aValue;
     if ( not Result.IsEmpty ) and ( Copy( Result, 1, 2 ) <> './' ) then
        Result:= './' + Result;
  end;

var
  XMLDoc: IXMLDocument;
  RootNode, GameNode: IXMLNode;
  i: Integer;
  Game: TGame;
begin
  XMLDoc := TXMLDocument.Create(nil);
  try
    XMLDoc.Active := True;
    XMLDoc.Version := '1.0';
    XMLDoc.Encoding := 'utf-8';
    XMLDoc.Options := XMLDoc.Options + [doNodeAutoIndent];
    RootNode := XMLDoc.AddChild('gameList');

    for i := 0 to aGameList.Count - 1 do
    begin
      Game := TGame(aGameList[i]);

      GameNode := RootNode.AddChild(Cst_game);

      GameNode.AddChild(Cst_Path).Text := Game.RomPath;
      AddNonEmptyChild( GameNode, Cst_Name, Game.Name );
      AddNonEmptyChild( GameNode, Cst_Description, Game.Description );
      AddNonEmptyChild( GameNode, Cst_ImageLink, WithLinkPrefix( Game.ImagePath ) );
      AddNonEmptyChild( GameNode, Cst_VideoLink, WithLinkPrefix( Game.VideoPath ) );
      AddNonEmptyChild( GameNode, Cst_Genre, Game.Genre );
      AddNonEmptyChild( GameNode, Cst_Rating, Game.Rating );
      AddNonEmptyChild( GameNode, Cst_Players, Game.Players );
      AddNonEmptyChild( GameNode, Cst_Developer, Game.Developer );
      AddNonEmptyChild( GameNode, Cst_ReleaseDate, Game.ReleaseDate );
      AddNonEmptyChild( GameNode, Cst_Publisher, Game.Publisher );
    end;

    XMLDoc.SaveToFile(FileName);
  finally
    XMLDoc := nil;
  end;
end;

procedure TFrm_Editor.pm_SaveGameListClick(Sender: TObject);
var
  gameList: TObjectList<TGame>;
begin
  GSystemList.TryGetValue( getCurrentFolderName, gameList);
  SaveGamelist( IncludeTrailingPathDelimiter( FRootPath + getCurrentFolderName )+Cst_GameListFileName, gameList);
  FGameListChanged:= False;
end;

//Sets the name of every selected game to its rom file name (without extension)
procedure TFrm_Editor.FileNameToGameName;
var
   _Node: IXMLNode;
   _Game: TGame;
   _GameListPath: string;
   _FileName: string;
   _Changed: Boolean;
   ii: Integer;
begin
   if ( lbListRoms.SelCount = 0 ) then Exit;

   Screen.Cursor:= crHourGlass;
   ProgressBar.Visible:= True;
   ProgressBar.Position:= 0;
   ProgressBar.Max:= lbListRoms.SelCount;
   _Changed:= False;

   //build the path to the gamelist.xml
   _GameListPath:= FRootPath + FCurrentFolder + Cst_GameListFileName;

   //Open the xml file
   XMLDoc.LoadFromFile( _GameListPath );

   //loop over the selected games
   for ii:= 0 to Pred( lbListRoms.Items.Count ) do begin
      if not lbListRoms.Selected[ii] then Continue;

      _Game:= ( lbListRoms.Items.Objects[ii] as TGame );
      if _Game = nil then Continue;

      //the file name without its extension becomes the new game name
      _FileName:= _Game.RomNameWoExt;
      if _FileName.IsEmpty then Continue;
      if _Game.Name.Equals( _FileName ) then Continue;

      //Retrieve the first "game" node and find the matching one
      _Node:= XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );
      repeat
         if ( _Node.ChildNodes.Nodes[Cst_Path].Text = _Game.RomPath ) then Break;
         _Node:= _Node.NextSibling;
      until not Assigned( _Node );
      if not Assigned( _Node ) then Continue;

      //update the in-memory game and the xml node
      _Game.Name:= _FileName;
      if not Assigned( _Node.ChildNodes.FindNode( Cst_Name ) ) then
         _Node.AddChild( Cst_Name );
      _Node.ChildNodes.Nodes[Cst_Name].Text:= _FileName;

      //refresh the displayed list item text
      lbListRoms.Items[ii]:= _FileName;

      _Changed:= True;
      ProgressBar.Position:= ProgressBar.Position + 1;
   end;

   if _Changed then begin
      XMLDoc.SaveToFile( _GameListPath );
      FGameListChanged:= True;
      if ( lbListRoms.Count > 0 ) and ( lbListRoms.ItemIndex >= 0 ) then
         LoadGame( ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame ) );
   end;

   XMLDoc.Active:= False;
   ProgressBar.Visible:= False;
   Screen.Cursor:= crDefault;
   lbListRoms.SetFocus;
end;

//on the "Use file name as game name" context menu item
procedure TFrm_Editor.Mnu_FileNameToGameNameClick(Sender: TObject);
begin
   FileNameToGameName;
end;

//Finds an image for the selected games in the system subfolders.
procedure TFrm_Editor.pm_FindImageClick(Sender: TObject);
begin
   FindImageInSubfolders;
end;

//Finds a video for the selected games in the system subfolders.
procedure TFrm_Editor.pm_FindVideoClick(Sender: TObject);
begin
   FindVideoInSubfolders;
end;

//Prompts the user to save the gamelist if it was modified.
//Returns True if the caller may proceed (system switch or close),
//False if the user cancelled.
function TFrm_Editor.ConfirmSaveGameList( aOnSwitch: Boolean ): Boolean;
var
   gameList: TObjectList<TGame>;
begin
   Result:= True;
   if not FGameListChanged then Exit;

   case MyMessageDlg( Rst_SaveChanges, mtConfirmation,
                      [mbYes, mbNo, mbCancel], [Rst_Yes, Rst_No, Rst_Cancel], Rst_Info ) of
      mrYes:
         begin
            if GSystemList.TryGetValue( getCurrentFolderName, gameList ) and
               Assigned( gameList ) then
               SaveGamelist( IncludeTrailingPathDelimiter( FRootPath + getCurrentFolderName ) +
                             Cst_GameListFileName, gameList );
            FGameListChanged:= False;
         end;
      mrNo:
         FGameListChanged:= False;
      mrCancel:
         Result:= False;
   end;
end;

procedure TFrm_Editor.pm_ScanForROMsClick(Sender: TObject);
begin
  FindGameRoms(getCurrentFolderName);
  AddRomList(lbRoms.Items);
  LoadGamesList( getCurrentFolderName );  
end;

//Updates the state of the media controls context menu before displaying
procedure TFrm_Editor.pmPicturePopup(Sender: TObject);
begin
   pm_ChangeImage.Enabled:= Btn_ChangeImage.Enabled;
   pm_RemovePicture.Enabled:= Btn_RemovePicture.Enabled;
   pm_SetDefaultPicture.Enabled:= Btn_SetDefaultPicture.Enabled;
end;

procedure TFrm_Editor.pmVideoPopup(Sender: TObject);
begin
   pm_ChangeVideo.Enabled:= Btn_ChangeVideo.Enabled;
   pm_RemoveVideo.Enabled:= Btn_RemoveVideo.Enabled;
end;

procedure TFrm_Editor.SaveLinkToFile ( aLink, aPath: string );
var
   Stream: TBytesStream;
begin
   Stream:= TBytesStream.Create;
   try
      try
         Net_HTTPClient.Get( aLink, Stream );
         if ( Stream.Size = 0 ) then begin
            WarnUser( Rst_StreamError );
            Exit;
         end;
         Stream.Position:= 0;
      except
         on E : Exception do
         begin
            WarnUserWithSafeUrl( Rst_ServerError8, E.Message, aLink );
            Exit;
         end;
      end;

      Stream.SaveToFile(aPath);

   finally
      Stream.Free;
   end;
end;

//Scrapes all the selected games and directly applies the results to the
//gamelist (name, description and best picture). Only games for which the
//scrape returns usable data are modified, so the user just has to save.
procedure TFrm_Editor.ScrapeAndApplySelectedGames;
var
   _Game: TGame;
   _Node: IXMLNode;
   _GameListPath, _ImageLink, _ImageFolder, _Ext, _PhysPath, _Name, _Desc: string;
   _NodeAdded, _Changed: Boolean;
   _Applied, ii: Integer;
   _BestPic: TMediaInfo;
   _PreviewImg: TImage;
begin
   if lbListRoms.SelCount <= 1 then Exit;

   Screen.Cursor:= crHourGlass;
   FSuppressDialogs:= True;
   ProgressBarScrape.Visible:= True;
   ProgressBarScrape.Position:= 0;
   ProgressBarScrape.Max:= lbListRoms.SelCount;
   _Applied:= 0;
   _Changed:= False;

   //Switch to the Scrape tab so the user can watch the batch scraping progress.
   Pgc_Editor.ActivePage:= Tbs_Scrape;

   try
      for ii:= 0 to Pred( lbListRoms.Items.Count ) do begin
         if not lbListRoms.Selected[ii] then Continue;

         _Game:= ( lbListRoms.Items.Objects[ii] as TGame );

         //reset per-game scrape data
         FScrapedGame:= _Game;
         FInfosList.Clear;
         FPictureLinks.Clear;
         FImgList.Clear;
         FVideoScrapeLink:= '';

         if not GetGameXml( GetCurrentSystemId, _Game ) then begin
            ProgressBarScrape.Position:= ProgressBarScrape.Position + 1;
            Continue;
         end;

         ParseXml;
         if ( FInfosList.Count = 0 ) then begin
            ProgressBarScrape.Position:= ProgressBarScrape.Position + 1;
            Continue;
         end;

         //fill the scrape fields from the parsed data
         FillFields;
         _Name:= Edt_ScrapeName.Text;
         _Desc:= Mmo_ScrapeDescription.Text;
         //Let the UI repaint so the current game's scraped data is visible
         //before the (blocking) picture download below.
         Application.ProcessMessages;

         _BestPic:= nil;
         if ( FPictureLinks.Count > 0 ) then
            _BestPic:= FPictureLinks[0];

         _GameListPath:= FRootPath + FCurrentFolder + Cst_GameListFileName;
         XMLDoc.LoadFromFile( _GameListPath );
         _Node:= XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );
         while Assigned( _Node ) do begin
            if ( _Node.ChildNodes.Nodes[Cst_Path].Text = _Game.RomPath ) then Break;
            _Node:= _Node.NextSibling;
         end;
         if not Assigned( _Node ) then begin
            XMLDoc.Active:= False;
            ProgressBarScrape.Position:= ProgressBarScrape.Position + 1;
            Continue;
         end;

         _NodeAdded:= False;

         //apply name if it changed
         if ( not _Name.IsEmpty ) and ( not _Game.Name.Equals( _Name ) ) then begin
            if not Assigned( _Node.ChildNodes.FindNode( Cst_Name ) ) then begin
               _Node.AddChild( Cst_Name );
               _NodeAdded:= True;
            end;
            _Node.ChildNodes.Nodes[Cst_Name].Text:= _Name;
            _Game.Name:= _Name;
         end;

         //apply description if it changed
         if ( not _Desc.IsEmpty ) and ( not _Game.Description.Equals( _Desc ) ) then begin
            if not Assigned( _Node.ChildNodes.FindNode( Cst_Description ) ) then begin
               _Node.AddChild( Cst_Description );
               _NodeAdded:= True;
            end;
            _Node.ChildNodes.Nodes[Cst_Description].Text:= _Desc;
            _Game.Description:= _Desc;
         end;

         //download and apply the best picture
         if Assigned( _BestPic ) then begin
            _ImageFolder:= GetImageFolderPath;
            if EnsureMediaFolder( _ImageFolder ) then begin
               _Ext:= _BestPic.FileExt;
               if _Ext.IsEmpty then _Ext:= Cst_PngExt;
               if ( _Ext[1] <> '.' ) then _Ext:= '.' + _Ext;

               _PhysPath:= FRootPath + FCurrentFolder +
                           StringReplace( _ImageFolder, '/', '\', [rfReplaceAll] ) +
                           '\' + _Game.RomNameWoExt + _Ext;

               SaveLinkToFile( _BestPic.FileLink, _PhysPath );

               if FileExists( _PhysPath ) then begin
                  _ImageLink:= _ImageFolder + _Game.RomNameWoExt + _Ext;
                  if not Assigned( _Node.ChildNodes.FindNode( Cst_ImageLink ) ) then begin
                     _Node.AddChild( Cst_ImageLink );
                     _NodeAdded:= True;
                  end;
                  _Node.ChildNodes.Nodes[Cst_ImageLink].Text:= _ImageLink;
                  _Game.ImagePath:= _ImageLink;
                  _Game.PhysicalImagePath:= GetPhysicalMediaPath( _ImageLink );
end;
             end;
          end;

          //Preview the scraped picture on the Scrape tab for the current game.
          FImgList.Clear;
          if FileExists( _PhysPath ) then begin
             _PreviewImg:= TImage.Create( nil );
             try
                _PreviewImg.Picture.LoadFromFile( _PhysPath );
                _PreviewImg.AutoSize:= True;
                _PreviewImg.Proportional:= True;
                _PreviewImg.Center:= True;
                _PreviewImg.Visible:= False;
                FImgList.Add( _PreviewImg );
             except
                on E: Exception do
                   _PreviewImg.Free;
             end;
          end;
          DisplayPictures;

          if _NodeAdded then begin
             XMLDoc.XML.Text:= Xml.Xmldoc.FormatXMLData( XMLDoc.XML.Text );
             XMLDoc.Active:= True;
          end;
          XMLDoc.SaveToFile( _GameListPath );
          XMLDoc.Active:= False;

         _Changed:= True;
         Inc( _Applied );
         ProgressBarScrape.Position:= ProgressBarScrape.Position + 1;
         //Process pending paint/input messages so the progress bar and the
         //current game's scrape results are actually repainted on screen.
         Application.ProcessMessages;
      end;
   finally
      FSuppressDialogs:= False;
      ProgressBarScrape.Visible:= False;
      Screen.Cursor:= crDefault;
   end;

   if _Changed then begin
      FGameListChanged:= True;
      LoadGamesList( getCurrentFolderName );
   end;

   Pgc_Editor.ActivePage:= Tbs_Main;

   MyMessageDlg( Format( Rst_ScrapeBatchDone, [ _Applied ] ), mtInformation,
                 [mbOK], [Rst_Ok], Rst_Info );
end;

//Searches the whole system folder (and its subfolders) for an image file whose
//name matches each selected game's rom name, and applies it when a game has no
//image yet.
procedure TFrm_Editor.FindImageInSubfolders;

   //Recursively looks for <romName>.<png|jpg|jpeg> under aDir.
   function SearchForImage( const aDir, aRomNameWoExt: string ): string;
   var
      SR: TSearchRec;
      FullPath, Ext: string;
   begin
      Result:= '';
      //check the current folder first
      if ( FindFirst( aDir + aRomNameWoExt + '.*', faAnyFile, SR ) = 0 ) then begin
         repeat
            Ext:= AnsiLowerCase( ExtractFileExt( SR.Name ) );
            if ( Ext = Cst_ImageSuffixPng ) or ( Ext = Cst_ImageSuffixJpg ) or
               ( Ext = Cst_ImageSuffixJpeg ) then begin
               Result:= aDir + SR.Name;
               FindClose( SR );
               Exit;
            end;
         until ( FindNext( SR ) <> 0 );
         FindClose( SR );
      end;

      //then recurse into subfolders
      if ( FindFirst( aDir + '*', faDirectory, SR ) = 0 ) then begin
         repeat
            if ( SR.Name <> '.' ) and ( SR.Name <> '..' ) then begin
               FullPath:= IncludeTrailingPathDelimiter( aDir + SR.Name );
               Result:= SearchForImage( FullPath, aRomNameWoExt );
               if not Result.IsEmpty then begin
                  FindClose( SR );
                  Exit;
               end;
            end;
         until ( FindNext( SR ) <> 0 );
         FindClose( SR );
      end;
   end;

var
   _Game: TGame;
   _Node: IXMLNode;
   _GameListPath, _ImageLink, _Root, _FoundPath: string;
   _Changed: Boolean;
   _Applied, ii: Integer;
begin
   if lbListRoms.SelCount = 0 then Exit;

   _Root:= FRootPath + FCurrentFolder;

   Screen.Cursor:= crHourGlass;
   ProgressBar.Visible:= True;
   ProgressBar.Position:= 0;
   ProgressBar.Max:= lbListRoms.SelCount;
   _Applied:= 0;
   _Changed:= False;

   try
      for ii:= 0 to Pred( lbListRoms.Items.Count ) do begin
         if not lbListRoms.Selected[ii] then Continue;

         _Game:= ( lbListRoms.Items.Objects[ii] as TGame );

         //skip games that already have a physical image
         if FileExists( _Game.PhysicalImagePath ) then begin
            ProgressBar.Position:= ProgressBar.Position + 1;
            Continue;
         end;

         //search the whole system folder tree for <romname>.(png|jpg|jpeg)
         _FoundPath:= SearchForImage( _Root, _Game.RomNameWoExt );
         if _FoundPath.IsEmpty then begin
            ProgressBar.Position:= ProgressBar.Position + 1;
            Continue;
         end;

         //relative link (with forward slashes) for the gamelist
         _ImageLink:= ExtractRelativePath( _Root, _FoundPath );
         _ImageLink:= StringReplace( _ImageLink, '\', '/', [rfReplaceAll] );
         //consoles (e.g. the R36H) require a leading "./" on relative paths
         if Copy( _ImageLink, 1, 2 ) <> './' then
            _ImageLink:= './' + _ImageLink;

         _GameListPath:= _Root + Cst_GameListFileName;
         XMLDoc.LoadFromFile( _GameListPath );
         _Node:= XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );
         while Assigned( _Node ) do begin
            if ( _Node.ChildNodes.Nodes[Cst_Path].Text = _Game.RomPath ) then Break;
            _Node:= _Node.NextSibling;
         end;
         if not Assigned( _Node ) then begin
            XMLDoc.Active:= False;
            ProgressBar.Position:= ProgressBar.Position + 1;
            Continue;
         end;

         if not Assigned( _Node.ChildNodes.FindNode( Cst_ImageLink ) ) then
            _Node.AddChild( Cst_ImageLink );
         _Node.ChildNodes.Nodes[Cst_ImageLink].Text:= _ImageLink;

         XMLDoc.SaveToFile( _GameListPath );
         XMLDoc.Active:= False;

         _Game.ImagePath:= _ImageLink;
         _Game.PhysicalImagePath:= GetPhysicalMediaPath( _ImageLink );

         _Changed:= True;
         Inc( _Applied );
         ProgressBar.Position:= ProgressBar.Position + 1;
      end;
   finally
      ProgressBar.Visible:= False;
      Screen.Cursor:= crDefault;
   end;

   if _Changed then begin
      FGameListChanged:= True;
      LoadGamesList( getCurrentFolderName );
   end;

   MyMessageDlg( Format( Rst_FindImageDone, [ _Applied ] ), mtInformation,
                 [mbOK], [Rst_Ok], Rst_Info );
end;

//Searches the whole system folder (and its subfolders) for a video file whose
//name matches each selected game's rom name, and applies it when a game has no
//video yet.
procedure TFrm_Editor.FindVideoInSubfolders;

   //Recursively looks for <romName>.mp4 under aDir.
   function SearchForVideo( const aDir, aRomNameWoExt: string ): string;
   var
      SR: TSearchRec;
      FullPath, Ext: string;
   begin
      Result:= '';
      //check the current folder first
      if ( FindFirst( aDir + aRomNameWoExt + '.*', faAnyFile, SR ) = 0 ) then begin
         repeat
            Ext:= AnsiLowerCase( ExtractFileExt( SR.Name ) );
            if ( Ext = Cst_VideoSuffixMp4 ) then begin
               Result:= aDir + SR.Name;
               FindClose( SR );
               Exit;
            end;
         until ( FindNext( SR ) <> 0 );
         FindClose( SR );
      end;

      //then recurse into subfolders
      if ( FindFirst( aDir + '*', faDirectory, SR ) = 0 ) then begin
         repeat
            if ( SR.Name <> '.' ) and ( SR.Name <> '..' ) then begin
               FullPath:= IncludeTrailingPathDelimiter( aDir + SR.Name );
               Result:= SearchForVideo( FullPath, aRomNameWoExt );
               if not Result.IsEmpty then begin
                  FindClose( SR );
                  Exit;
               end;
            end;
         until ( FindNext( SR ) <> 0 );
         FindClose( SR );
      end;
   end;

var
   _Game: TGame;
   _Node: IXMLNode;
   _GameListPath, _VideoLink, _Root, _FoundPath: string;
   _Changed: Boolean;
   _Applied, ii: Integer;
begin
   if lbListRoms.SelCount = 0 then Exit;

   _Root:= FRootPath + FCurrentFolder;

   Screen.Cursor:= crHourGlass;
   ProgressBar.Visible:= True;
   ProgressBar.Position:= 0;
   ProgressBar.Max:= lbListRoms.SelCount;
   _Applied:= 0;
   _Changed:= False;

   try
      for ii:= 0 to Pred( lbListRoms.Items.Count ) do begin
         if not lbListRoms.Selected[ii] then Continue;

         _Game:= ( lbListRoms.Items.Objects[ii] as TGame );

         //skip games that already have a physical video
         if FileExists( _Game.PhysicalVideoPath ) then begin
            ProgressBar.Position:= ProgressBar.Position + 1;
            Continue;
         end;

         //search the whole system folder tree for <romname>.mp4
         _FoundPath:= SearchForVideo( _Root, _Game.RomNameWoExt );
         if _FoundPath.IsEmpty then begin
            ProgressBar.Position:= ProgressBar.Position + 1;
            Continue;
         end;

         //relative link (with forward slashes) for the gamelist
         _VideoLink:= ExtractRelativePath( _Root, _FoundPath );
         _VideoLink:= StringReplace( _VideoLink, '\', '/', [rfReplaceAll] );
         //consoles (e.g. the R36H) require a leading "./" on relative paths
         if Copy( _VideoLink, 1, 2 ) <> './' then
            _VideoLink:= './' + _VideoLink;

         _GameListPath:= _Root + Cst_GameListFileName;
         XMLDoc.LoadFromFile( _GameListPath );
         _Node:= XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );
         while Assigned( _Node ) do begin
            if ( _Node.ChildNodes.Nodes[Cst_Path].Text = _Game.RomPath ) then Break;
            _Node:= _Node.NextSibling;
         end;
         if not Assigned( _Node ) then begin
            XMLDoc.Active:= False;
            ProgressBar.Position:= ProgressBar.Position + 1;
            Continue;
         end;

         if not Assigned( _Node.ChildNodes.FindNode( Cst_VideoLink ) ) then
            _Node.AddChild( Cst_VideoLink );
         _Node.ChildNodes.Nodes[Cst_VideoLink].Text:= _VideoLink;

         XMLDoc.SaveToFile( _GameListPath );
         XMLDoc.Active:= False;

         _Game.VideoPath:= _VideoLink;
         _Game.PhysicalVideoPath:= GetPhysicalMediaPath( _VideoLink );

         _Changed:= True;
         Inc( _Applied );
         ProgressBar.Position:= ProgressBar.Position + 1;
      end;
   finally
      ProgressBar.Visible:= False;
      Screen.Cursor:= crDefault;
   end;

   if _Changed then begin
      FGameListChanged:= True;
      LoadGamesList( getCurrentFolderName );
   end;

   MyMessageDlg( Format( Rst_FindVideoDone, [ _Applied ] ), mtInformation,
                 [mbOK], [Rst_Ok], Rst_Info );
end;
procedure TFrm_Editor.Mnu_SetFavoriteClick(Sender: TObject);
begin
   SetFavOrHidden( True, True );
end;

procedure TFrm_Editor.Mnu_SetHiddenClick(Sender: TObject);
begin
   SetFavOrHidden( False, True );
end;

procedure TFrm_Editor.Mnu_SetNoFavoriteClick(Sender: TObject);
begin
   SetFavOrHidden( True, False );
end;

procedure TFrm_Editor.Mnu_SetNoHiddenClick(Sender: TObject);
begin
   SetFavOrHidden( False, False );
end;

//Toggles the selection to favorites or hidden (and back)
procedure TFrm_Editor.SetFavOrHidden( aFav, aValue: Boolean );

   //Ensures a node exists
   function NodeExists( aNode: IXMLNode; const aNodeName: string ): Boolean;
   begin
      Result:= False;
      if Assigned( aNode.ChildNodes.FindNode( aNodeName ) ) then
         Result:= True;
   end;

var
   _Node: IXMLNode;
   _GameListPath: string;
   _NodeAdded: Boolean;
   _Game: TGame;
   ii: Integer;
begin
   _NodeAdded:= False;
   //Retrieve the path to the gamelist.xml file
   _GameListPath:= FRootPath + FCurrentFolder + Cst_GameListFileName;

   //Open the xml file
   XMLDoc.LoadFromFile( _GameListPath );

   Screen.Cursor:= crHourGlass;
   ProgressBar.Visible:= True;
   ProgressBar.Position:= 0;
   ProgressBar.Max:= lbListRoms.SelCount;

   //loop over the selected games
   for ii:= 0 to Pred( lbListRoms.Items.Count ) do begin
      if ( lbListRoms.Selected[ii] ) then begin

         //Retrieve the corresponding game
         _Game:= ( lbListRoms.Items.Objects[ii] as TGame );

         //Retrieve the first "game" node
         _Node := XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );

         //And loop to find the right node
         repeat
            if ( _Node.ChildNodes.Nodes[Cst_Path].Text = _Game.RomPath ) then Break;
            _Node := _Node.NextSibling;
         until not Assigned( _Node );

         if aFav then begin
            if not ( NodeExists( _Node, Cst_Favorite ) ) then begin
               _Node.AddChild( Cst_Favorite );
               _NodeAdded:= True;
            end;
            if aValue then _Node.ChildNodes.Nodes[Cst_Favorite].Text:= Cst_True
            else _Node.ChildNodes.Nodes[Cst_Favorite].Text:= Cst_False;
            _Game.Favorite:= Ord( aValue );
         end else begin
            if not ( NodeExists( _Node, Cst_Hidden ) ) then begin
               _Node.AddChild( Cst_Hidden );
               _NodeAdded:= True;
            end;
            if aValue then _Node.ChildNodes.Nodes[Cst_Hidden].Text:= Cst_True
            else _Node.ChildNodes.Nodes[Cst_Hidden].Text:= Cst_False;
            _Game.Hidden:= Ord( aValue );
         end;

         ProgressBar.Position:= ProgressBar.Position + 1;

      end;
   end;

   ProgressBar.Visible:= False;

   if _NodeAdded then begin
      XMLDoc.XML.Text:= Xml.Xmldoc.FormatXMLData( XMLDoc.XML.Text );
      XMLDoc.Active:= True;
   end;
XMLDoc.SaveToFile( _GameListPath );
      XMLDoc.Active:= False;

      //mark the current gamelist as modified if something actually changed
      if _NodeAdded then
         FGameListChanged:= True;

      //refresh the list
      LoadGamesList( getCurrentFolderName );

   Screen.Cursor:= crDefault;
end;

//Action on clicking the delete this game button
procedure TFrm_Editor.Btn_DeleteClick(Sender: TObject);
var
   _GamesToDelete: TList<TGame>;
   _aGame: TGame;
   _Index, ii: Integer;
begin
   if FDelWoPrompt or
      ( MyMessageDlg( Rst_DeleteWarning, mtInformation,
                    [mbYes, mbNo], [Rst_Yes, Rst_No], Rst_Info ) = mrYes ) then begin

      //remember the listbox index to restore at the end
      _Index:= lbListRoms.ItemIndex;

      if lbListRoms.SelCount > 1 then begin
         Screen.Cursor:= crHourGlass;
         ProgressBar.Visible:= True;
         ProgressBar.Position:= 0;

         // Step 1: Capture list of games to delete
         _GamesToDelete := TList<TGame>.Create;
         try
            for ii := Pred(lbListRoms.Items.Count) downto 0 do begin
              if lbListRoms.Selected[ii] then
                _GamesToDelete.Add(lbListRoms.Items.Objects[ii] as TGame);
            end;
            ProgressBar.Max:= Pred( _GamesToDelete.Count );

            // Step 2: Loop over the list of games to delete and delete them
            for _aGame in _GamesToDelete do begin
              DeleteGame(_aGame, False );
              ProgressBar.Position := ProgressBar.Position + 1;
            end;
         finally
            _GamesToDelete.Free;
         end;
         LoadGamesList( getCurrentFolderName );
         ProgressBar.Visible:= False;
         Screen.Cursor:= crDefault;
      end else begin
         //delete the game
         DeleteGame( ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame ) );
      end;

      //and restore the selection on the game before the deleted one (if possible)
      if ( ( _Index = 0 ) and ( lbListRoms.Count = 0 ) ) or
         ( ( _Index > 1 ) and ( lbListRoms.Count > 1 ) ) then
         lbListRoms.ItemIndex:= Pred( _Index )
      else lbListRoms.ItemIndex:= _Index;
      //and load the game info (if list not empty)
      if ( lbListRoms.Count > 0 ) then
         LoadGame( ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame ) );
      lbListRoms.SetFocus;
      lbListRoms.Selected[lbListRoms.ItemIndex]:= True;
      if ( lbListRoms.ItemIndex > 0 ) then lbListRoms.Selected[0]:= False;
   end;
end;

//On clicking the delete orphans menu item
procedure TFrm_Editor.Mnu_DeleteOrphansClick(Sender: TObject);
var
   _List: TObjectList<TGame>;
   ii: Integer;
begin
   //loop over the games in the list to delete the orphans.
   GSystemList.TryGetValue( getCurrentFolderName, _List );
   Screen.Cursor:= crHourGlass;
   ProgressBar.Visible:= True;
   ProgressBar.Max:= Pred( _List.Count );
   ProgressBar.Position:= 0;
   for ii:= Pred( _List.Count ) downto 0 do begin
      if _List.Items[ii].IsOrphan then
         DeleteGame( _List.Items[ii] );
      ProgressBar.Position:= ( ProgressBar.Position + 1);
   end;
   ProgressBar.Visible:= False;
   Screen.Cursor:= crDefault;
end;

//Deletes a game from the gamelist and physically from the disk (or SD card or key...)
procedure TFrm_Editor.DeleteGame( aGame: TGame; reloadGameList: Boolean = True );
var
   _Node: IXMLNode;
   _GameListPath: string;
   _List: TObjectList<TGame>;
   _ImageReused: Boolean;
   _VideoReused: Boolean;
begin
   //build the path to the gamelist.xml
   _GameListPath:= FRootPath + FCurrentFolder + Cst_GameListFileName;

   //get the corresponding game list
   GSystemList.TryGetValue( getCurrentFolderName, _List );

    //Open the xml file
    XMLDoc.LoadFromFile( _GameListPath );

   // Find out if the image or video are used anywhere else other than in this game
   _ImageReused := false;
   _VideoReused := false;
   _Node := XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );
   repeat
      if not ( _Node.ChildNodes.Nodes[Cst_Path].Text = aGame.RomPath ) then begin
         if ( Assigned ( _Node.ChildNodes.FindNode(Cst_ImageLink) ) and
              (_Node.ChildNodes.FindNode(Cst_ImageLink).Text = aGame.ImagePath) )
              then _ImageReused := true;
         if ( Assigned ( _Node.ChildNodes.FindNode(Cst_VideoLink) ) and
              (_Node.ChildNodes.FindNode(Cst_VideoLink).Text = aGame.VideoPath) )
              then _VideoReused := true;
      end;
      _Node := _Node.NextSibling;
   until not Assigned( _Node );

    //Retrieve the first "game" node
    _Node := XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );

    //And loop to find the right node
    repeat
       if ( _Node.ChildNodes.Nodes[Cst_Path].Text = aGame.RomPath ) then Break;
       _Node := _Node.NextSibling;
    until not Assigned( _Node );

    //remove the node from the xml file
    XMLDoc.DocumentElement.ChildNodes.Remove( _Node );
    XMLDoc.Active:= True;
    XMLDoc.SaveToFile( _GameListPath );
    XMLDoc.Active:= False;
    FGameListChanged:= True;

    //Delete the game image
    if not _ImageReused then
       DeleteFile( aGame.PhysicalImagePath );

    // Delete video
    if not _VideoReused then
       DeleteFile( aGame.PhysicalVideoPath );

    //delete the game physically (special action for PSX)
    if ( getSystemKind = skPS ) then begin
       DeleteFile( StringReplace( aGame.PhysicalRomPath, '.cue', '.bin', [rfReplaceAll] ) );
       DeleteFile( StringReplace( aGame.PhysicalRomPath, '.bin', '.cue', [rfReplaceAll] ) );
    end else
       DeleteFile( aGame.PhysicalRomPath );

    //Delete the game from its parent list
    _List.Remove( aGame );

    //and update the listbox display to take the deletion into account
    if reloadGameList then
      LoadGamesList( getCurrentFolderName );
end;

//on clicking the delete duplicates menu item
procedure TFrm_Editor.Mnu_DeleteDuplicatesClick(Sender: TObject);
begin
   DeleteDuplicates( getCurrentFolderName );
end;

//Delete duplicates in the gamelist.xml
procedure TFrm_Editor.DeleteDuplicates( const aSystem: string );
var
   _NodeList: IXMLNodeList;
   _Node1, _Node2: IXMLNode;
   Node1Path, Node2Path: IXMLNode;
   ii, jj, Count: Integer;
   _List: TObjectList<TGame>;
   _GameListPath: string;
begin
   //start by clearing the fields
   lbListRoms.Clear;
   ClearAllFields;

   //build the path to the gamelist.xml
   _GameListPath:= FRootPath + FCurrentFolder + Cst_GameListFileName;

   //Open the xml file
   XMLDoc.LoadFromFile( _GameListPath );

   //activate it
   XMLDoc.Active:= True;

   //Retrieve the list of "game" nodes
   _NodeList:= XMLDoc.DocumentElement.ChildNodes;
   Count:= _NodeList.Count;

   //activate the progressbar
   Screen.Cursor:= crHourGlass;
   ProgressBar.Visible:= True;
   ProgressBar.Max:= Pred( Count );
   ProgressBar.Position:= 0;

   //loop over all the nodes to check for duplicates
   //and delete them if that is the case
   for ii:= Pred( Count ) downto 0 do begin
      _Node1:= _NodeList.Nodes[ii];
      Node1Path := _Node1.ChildNodes.FindNode(Cst_Path);
      if Node1Path <> nil then begin
         for jj:= 0 to Pred( ii ) do begin
            _Node2:= _NodeList.Nodes[jj];
            Node2Path := _Node2.ChildNodes.FindNode(Cst_Path);
            if (Node2Path <> nil) and (Node1Path.Text = Node2Path.Text) then begin
               _NodeList.Remove( _Node1 );
               Break;
            end;
         end;
      end;
      ProgressBar.Position:= ( ProgressBar.Position + 1 );
   end;

   //disable the progressbar
   ProgressBar.Visible:= False;

   //then save the cleaned gamelist
   XMLDoc.SaveToFile( _GameListPath );
   XMLDoc.Active:= False;

   //remove the game list from the general systems list
   //and we rebuild and re-add it
   GSystemList.Remove( aSystem );
   _List:= BuildGamesList( _GameListPath );
   GSystemList.Add( aSystem, _List );

   //reload the game list
   LoadGamesList( aSystem );
   Screen.Cursor:= crDefault;
end;

//Clearing of all the fields and the image
procedure TFrm_Editor.ClearAllFields;
begin
   //Disable the events on the changes in the fields
   FIsLoading:= True;

   Edt_Name.Text:= '';
   Edt_Rating.Text:= '';
   Edt_ReleaseDate.Text:= '';
   Edt_Publisher.Text:= '';
   Edt_Developer.Text:= '';
   Edt_NbPlayers.Text:= '';
   Edt_Genre.Text:= '';
   Edt_Region.Text:= '';
   Edt_RomPath.Text:= '';
   Mmo_Description.Text:= '';
   Img_Game.Picture.Graphic:= nil;
   Cbx_KidGame.ItemIndex:= -1;
   Cbx_Hidden.ItemIndex:= -1;
   Cbx_Favorite.ItemIndex:= -1;

   //re-enable the events on the fields
   FIsLoading:= False;
end;

//On clicking the "list by rom name" checkbox
procedure TFrm_Editor.Chk_FullRomNameClick(Sender: TObject);
begin
   LoadGamesList( getCurrentFolderName );
end;

procedure TFrm_Editor.Chk_ListByRomClick(Sender: TObject);
begin
   Chk_FullRomName.Enabled:= Chk_ListByRom.Checked;
   LoadGamesList( getCurrentFolderName );
end;

//On clicking the godmode menuitem we change the visibility of the delete button
procedure TFrm_Editor.Mnu_GodModeClick(Sender: TObject);
begin
   Btn_Delete.Visible:= Mnu_GodMode.Checked;
   FGodMode:= Mnu_GodMode.Checked;
   Mnu_DeleteWoPrompt.Enabled:= FGodMode;
   if not FGodMode then begin
      Mnu_DeleteWoPrompt.Checked:= False;
      FDelWoPrompt:= False;
   end;
end;

procedure TFrm_Editor.Mnu_GenesisClick(Sender: TObject);
var
   ii: Integer;
begin
   FGenesisLogo:= Mnu_Genesis.Checked;

   //loop over the combo items to find the right one and change its name
   for ii:= 0 to Pred( Cbx_Systems.Items.Count ) do begin
      if ( ( Cbx_Systems.Items.Objects[ii] as TSystemKindObject).FSystemKind = skMegadrive ) then begin
         if FGenesisLogo then
            Cbx_Systems.Items[ii]:= Cst_SystemKindStr[skGenesis]
         else if not FGenesisLogo then
            Cbx_Systems.Items[ii]:= Cst_SystemKindStr[skMegaDrive];
         Break;
      end;
   end;

   //and reload the list
   Cbx_Systems.ItemIndex:= ii;
   LoadGamesList( getCurrentFolderName );
end;

//On clicking the autohash menuitem
procedure TFrm_Editor.Mnu_AutoHashClick(Sender: TObject);
begin
   FAutoHash:= Mnu_AutoHash.Checked;
end;

procedure TFrm_Editor.Mnu_AutoLoadOnStartClick(Sender: TObject);
begin
  Mnu_AutoLoadOnStart.Checked := not Mnu_AutoLoadOnStart.Checked;
  FAutoLoadOnStart := Mnu_AutoLoadOnStart.Checked;
end;

//On clicking the Del Without Prompt menu item
procedure TFrm_Editor.Mnu_DeleteWoPromptClick(Sender: TObject);
begin
   FDelWoPrompt:= Mnu_DeleteWoPrompt.Checked;
end;

//On clicking the export to txt file menu item
procedure TFrm_Editor.Mnu_ExportTxtClick(Sender: TObject);
begin
   ExportToTxt;
end;

//Allows exporting the game list of the current system to a txt file
//sorted alphabetically with a delimiter per letter
procedure TFrm_Editor.ExportToTxt;
var
   FirstCharRef, FirstCharCurrent: string;
   SortedList, FormatedList: TStringList;
   SystemList: TObjectList<TGame>;
   Game: TGame;
   ii: Integer;
begin
   //retrieve the list of the current system
   GSystemList.TryGetValue( getCurrentFolderName, SystemList );

   //Create the sorted stringlist and fill it with the game names.
   SortedList:= TStringList.Create;
   SortedList.Sorted:= True;
   SortedList.Duplicates:= dupAccept;
   //create the final formatted list for export
   FormatedList:= TStringList.Create;
   try
      for Game in SystemList do begin
         if Chk_ListByRom.Checked then SortedList.Add( Game.RomName )
         else SortedList.Add( Game.Name );
      end;

      //get the first character of the first element of the sorted list
      FirstCharRef:= SortedList[0][1];
      FormatedList.Add( '---------- ' + AnsiUpperCase( FirstCharRef ) + ' ----------' );
      FormatedList.Add( sLineBreak );
      //here we loop over the sorted list to fill the formatted list
      for ii:= 0 to Pred( SortedList.Count ) do begin
         FirstCharCurrent:= SortedList[ii][1];
         if ( FirstCharCurrent = FirstCharRef ) then
            FormatedList.Add( SortedList[ii] )
         else begin
            FirstCharRef:= FirstCharCurrent;
            FormatedList.Add( sLineBreak );
            FormatedList.Add( '---------- ' + AnsiUpperCase( FirstCharRef ) + ' ----------' );
            FormatedList.Add( sLineBreak );
            FormatedList.Add( SortedList[ii] );
         end;
      end;

      //and ask the user where to save and with which name
      if SaveDialog.Execute then
         FormatedList.SaveToFile( SaveDialog.FileName + Cst_TxtExtension );

   finally
      //and finally free all that little world
      SortedList.Free;
      FormatedList.Free;
   end;
end;

//on clicking the configure SSH menu item
procedure TFrm_Editor.Mnu_ConfigSSHClick(Sender: TObject);
var
   Frm_ConfigSSH: TFrm_ConfigureSSH;
begin
   //show the window to enter the SSH connection ids
   Frm_ConfigSSH:= TFrm_ConfigureSSH.Create( nil );
   try
      Frm_ConfigSSH.Execute( FRecalLogin, FRecalPwd, FRetroLogin, FRetroPwd );
   finally
      Frm_ConfigSSH.Free;
   end;
end;

//On clicking the configure network menu item
procedure TFrm_Editor.Mnu_ConfigureNetworkClick(Sender: TObject);
var
   Frm_Network: TFrm_Network;
begin
   //show the window to enter the screenscraper and proxy ids
   Frm_Network:= TFrm_Network.Create( nil );
   try
      Frm_Network.Execute( FSSLogin, FSSPwd, FProxyUser, FProxyPwd,
                           FProxyServer, FProxyPort, FProxyUse );
   finally
      Frm_Network.Free;
   end;
   ReloadIni;
end;

//allows reloading some info from the ini file
procedure TFrm_Editor.ReloadIni;
var
   FileIni: TIniFile;
begin
   FileIni:= TIniFile.Create( ExtractFilePath( Application.ExeName ) + Cst_IniFilePath );
   try
      FSSLogin:= FileIni.ReadString( Cst_IniOptions, Cst_IniSSUser, '');
      FSSPwd:= FileIni.ReadString( Cst_IniOptions, Cst_IniSSPwd, '');
      FProxyUser:= FileIni.ReadString( Cst_IniOptions, Cst_IniProxyUser, '');
      FProxyPwd:= FileIni.ReadString( Cst_IniOptions, Cst_IniProxyPwd, '');
      FProxyServer:= FileIni.ReadString( Cst_IniOptions, Cst_IniProxyServer, '');
      FProxyPort:= FileIni.ReadString( Cst_IniOptions, Cst_IniProxyPort, '');
      FProxyUse:= FileIni.ReadBool( Cst_IniOptions, Cst_IniProxyUse, False);
   finally
      FileIni.Free;
   end;
end;

//On clicking the convert to lower or upper case menu item (system)
procedure TFrm_Editor.ChangeCaseClick(Sender: TObject);
var
   _Game: TGame;
   ii: Integer;
   _List: TObjectList<TGame>;
begin
   GSystemList.TryGetValue( getCurrentFolderName, _List );

   Screen.Cursor:= crHourGlass;
   ProgressBar.Visible:= True;
   ProgressBar.Max:= Pred( _List.Count );
   ProgressBar.Position:= 0;
   for ii:= 0 to Pred( _List.Count ) do begin
      _Game:= ( lbListRoms.Items.Objects[ii] as TGame );
      if ( ( sender as TMenuItem ).Tag = 10 ) then
         ConvertFieldsCase( _Game )
      else if ( ( sender as TMenuItem ).Tag = 11 ) then
         ConvertFieldsCase( _Game, False, True );
      ProgressBar.Position:= ( ProgressBar.Position + 1 );
   end;
   LoadGamesList( getCurrentFolderName );
   ProgressBar.Visible:= False;
   Screen.Cursor:= crDefault;
end;

//On clicking the convert to lower or upper case menu item (game)
procedure TFrm_Editor.ChangeCaseGameClick(Sender: TObject);
var
   _Game: TGame;
begin
   _Game:= ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame );
   if ( ( sender as TMenuItem ).Tag = 12 ) then
      ConvertFieldsCase( _Game, True )
   else if ( ( sender as TMenuItem ).Tag = 13 ) then
      ConvertFieldsCase( _Game, True, True );
end;

//Allows converting the fields to upper or lower case depending
// of the passed parameters (works per system or per game)
procedure TFrm_Editor.ConvertFieldsCase( aGame: TGame; aUnique: Boolean = False;
                                          aUp: Boolean = False );

   //refreshes the data of the EDIT fields in case of modifying a single game
   procedure RefreshDisplay( aGame: TGame );
   begin
      Edt_Name.Text:= aGame.Name;
      Edt_Genre.Text:= aGame.Genre;
      Edt_Region.Text:= aGame.Region;
      Edt_Publisher.Text:= aGame.Publisher;
      Edt_Developer.Text:= aGame.Developer;
      Mmo_Description.Text:= aGame.Description;
      lbListRoms.Items[lbListRoms.ItemIndex]:= Edt_Name.Text;
   end;

   //code factorisation
   function ConvertUpOrLow( aNode: IXMLNode; const aNodeName: string; aUp: Boolean; const aField: string ): string;
   begin
      if aUp then begin
         Result:= AnsiUpperCase( aField );
      end else begin
         Result:= AnsiLowerCase( aField );
      end;
      if Assigned( aNode.ChildNodes.FindNode( aNodeName ) ) then
         aNode.ChildNodes.Nodes[aNodeName].Text:= Result;
   end;

var
   _Node: IXMLNode;
   _GameListPath: string;
begin
   //build the path to the gamelist.xml
   _GameListPath:= FRootPath + FCurrentFolder + Cst_GameListFileName;

   //Open the xml file
   XMLDoc.LoadFromFile( _GameListPath );

   //activate it
   XMLDoc.Active:= True;

   //Retrieve the first node corresponding to the game
   _Node := XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );

   //And loop to find the right node
   repeat
      if ( _Node.ChildNodes.Nodes[Cst_Path].Text = aGame.RomPath ) then Break;
         _Node := _Node.NextSibling;
   until not Assigned( _Node );

   //update the xml and the game object
   aGame.Name:= ConvertUpOrLow( _Node, Cst_Name, aUp, aGame.Name );
   aGame.Region:= ConvertUpOrLow( _Node, Cst_Region, aUp, aGame.Region );
   aGame.Developer:= ConvertUpOrLow( _Node, Cst_Developer, aUp, aGame.Developer );
   aGame.Publisher:= ConvertUpOrLow( _Node, Cst_Publisher, aUp, aGame.Publisher );
   aGame.Genre:= ConvertUpOrLow( _Node, Cst_Genre, aUp, aGame.Genre );
   aGame.Description:= ConvertUpOrLow( _Node, Cst_Description, aUp, aGame.Description );

   //if update of a single game, update the game display
   if aUnique then RefreshDisplay( aGame );

   //save the xml file
   XMLDoc.SaveToFile( _GameListPath );
   XMLDoc.Active:= False;
   FGameListChanged:= True;
end;

//Action on clicking the About menu item
procedure TFrm_Editor.Mnu_AboutClick(Sender: TObject);
var
   Frm_About: TFrm_About;
begin
   //Shows the "About" window
   Frm_About:= TFrm_About.Create(nil);
   try
      Frm_About.Execute;
   finally
      Frm_About.Free;
   end;
end;

//on clicking the Help menu item
procedure TFrm_Editor.Mnu_HelpClick(Sender: TObject);
var
   Frm_Help: TFrm_Help;
begin
   //Shows the "Help" window
   Frm_Help:= TFrm_Help.Create(nil);
   Frm_Help.Chk_ShowTips.Visible:= False;
   try
      FShowTips:= Frm_Help.Execute( FShowTips);
   finally
      Frm_Help.Free;
   end;
end;

//on clicking the disable pi prompts menu item
procedure TFrm_Editor.Mnu_PiPromptsClick(Sender: TObject);
begin
   FPiPrompts:= Mnu_PiPrompts.Checked;
end;

//Without that no Ctrl+A in the memo...(it is sad in 2017)
procedure TFrm_Editor.Mmo_DescriptionKeyPress(Sender: TObject; var Key: Char);
begin
   if ( Key = ^A ) then begin
      (Sender as TMemo).SelectAll;
       Key:= #0;
   end;
end;

//Click on the more infos button to show the additional info window
//on the selected game
procedure TFrm_Editor.Btn_MoreInfosClick(Sender: TObject);
var
   _Game: TGame;
   MoreInfos: TFrm_MoreInfos;
begin
   //retrieve the selected game
   _Game:= TGame( lbListRoms.Items.Objects[lbListRoms.ItemIndex] );

   //Add the hashes if needed.
   if ( ( _Game.Md5.IsEmpty ) or
        ( _Game.Sha1.IsEmpty ) or
        ( _Game.Crc32.IsEmpty ) ) then begin
      if FAutoHash or
         ( ( not FAutoHash ) and ( MyMessageDlg( Rst_HashWarning, mtInformation,
         [mbYes, mbNo], [Rst_Yes, Rst_No], Rst_Info ) = mrYes ) ) then begin

         _Game.Md5:= _Game.CalculateMd5( _Game.PhysicalRomPath );
         _Game.Sha1:= _Game.CalculateSha1( _Game.PhysicalRomPath );
         _Game.Crc32:= _Game.CalculateCrc32( _Game.PhysicalRomPath );
      end;
   end;

   //and show the window
   MoreInfos:= TFrm_MoreInfos.Create( nil );
   try
      MoreInfos.Execute( _Game );
   finally
      MoreInfos.Free;
   end;
   lbListRoms.SetFocus;
end;

//click on the remove region from games names menu item
procedure TFrm_Editor.Mnu_RemoveRegionClick(Sender: TObject);
var
   ii, _Pos: Integer;
   _List: TObjectList<TGame>;
   _Game: TGame;
begin
   //get the game list
   GSystemList.TryGetValue( getCurrentFolderName, _List );

   Screen.Cursor:= crHourGlass;
   ProgressBar.Visible:= True;
   ProgressBar.Max:= Pred( _List.Count );
   ProgressBar.Position:= 0;

   //loop over the games in the list
   for ii:= 0 to Pred( _List.Count ) do begin
      _Game:= ( lbListRoms.Items.Objects[ii] as TGame );
      _Pos:= Pos( '[', _Game.Name );

      //if we find the character, we process it
      if not ( _Pos = 0 ) then
         RemoveRegionFromGameName( _Game, Pred( _Pos ) );
      ProgressBar.Position:= ( ProgressBar.Position + 1 );
   end;
   LoadGamesList( getCurrentFolderName );
   ProgressBar.Visible:= False;
   Screen.Cursor:= crDefault;
   lbListRoms.SetFocus;
end;

//on clicking the ShowTips at start menu item
procedure TFrm_Editor.Mnu_ShowTipsClick(Sender: TObject);
begin
   FShowTips:= Mnu_ShowTips.Checked;
end;

//removes the region tag between [] in the game names
procedure TFrm_Editor.pm_RemoveFromListClick(Sender: TObject);
var
  gameList: TObjectList<TGame>;
  _Src: TListBox;
  _Game: TGame;
begin
  //The context menu is shared by lbListRoms. The source list is
  //the one that opened the menu: resolve it from the popup's PopupComponent
  //at click time (fall back to the value recorded on OnPopup).
  if pmGameList.PopupComponent is TListBox then
     _Src:= pmGameList.PopupComponent as TListBox
  else
     _Src:= FMenuSourceList;
  if _Src = nil then _Src:= lbListRoms;
  if _Src.ItemIndex < 0 then Exit;
  _Game:= _Src.Items.Objects[_Src.ItemIndex] as TGame;
  if _Game = nil then Exit;

  GSystemList.TryGetValue( getCurrentFolderName, gameList);
  if gameList = nil then Exit;
  //Remove the game object by reference (lbListRoms is sorted, so its index
  //does not match the gameList order).
  gameList.Remove( _Game );
  LoadGamesList( getCurrentFolderName );
end;

//Selects in the list all the stale records: games whose rom file is missing.
//They are selected so the user can review and delete them with the existing
//"Delete selected game(s)" command (they are useless without a rom).
procedure TFrm_Editor.pm_FindStaleClick(Sender: TObject);
var
  ii, _Count: Integer;
  _Game: TGame;
begin
  _Count:= 0;
  //Clear any existing selection first so only stale records stay selected.
  for ii:= 0 to Pred( lbListRoms.Items.Count ) do
     lbListRoms.Selected[ii]:= False;
  for ii:= 0 to Pred( lbListRoms.Items.Count ) do begin
     _Game:= lbListRoms.Items.Objects[ii] as TGame;
     if ( _Game <> nil ) and _Game.IsOrphan then begin
        lbListRoms.Selected[ii]:= True;
        Inc( _Count );
     end;
  end;

  lbListRoms.SetFocus;

  if _Count = 0 then
     MyMessageDlg( Rst_NoStaleRecord, mtInformation, [mbOK], [Rst_Ok], Rst_Info )
  else
     MyMessageDlg( Format( Rst_FindStaleDone, [ _Count ] ), mtInformation,
                   [mbOK], [Rst_Ok], Rst_Info );
end;

//Sets the source list of the shared context menu (lbListRoms)
//from the popup that fired (Sender is the TPopupMenu itself).
procedure TFrm_Editor.pmGameListPopup(Sender: TObject);
var
   _Comp: TComponent;
begin
   _Comp:= ( Sender as TPopupMenu ).PopupComponent;
   if _Comp is TListBox then
      FMenuSourceList:= _Comp as TListBox
   else
      FMenuSourceList:= nil;
end;

procedure TFrm_Editor.RemoveRegionFromGameName( aGame: TGame; aStartPos: Integer );
var
   _Node: IXMLNode;
   _GameListPath, _Name: string;
   _EndPos: Integer;
begin
   //build the path to the gamelist.xml
   _GameListPath:= FRootPath + FCurrentFolder + Cst_GameListFileName;

   //Open the xml file
   XMLDoc.LoadFromFile( _GameListPath );

   //activate it
   XMLDoc.Active:= True;

   //Retrieve the first node corresponding to the game
   _Node := XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );

   //And loop to find the right node
   repeat
      if ( _Node.ChildNodes.Nodes[Cst_Path].Text = aGame.RomPath ) then Break;
         _Node := _Node.NextSibling;
   until not Assigned( _Node );

   //locate the position of the ] character
   _EndPos:= Pos( ']', aGame.Name );

    //Update the TGame object
    _Name:= aGame.Name;
    Delete( _Name, aStartPos,  Succ( _EndPos - aStartPos ) );
    aGame.Name:= _Name;

   //change the text in the xml
   _Node.ChildNodes.FindNode( Cst_Name ).Text:= aGame.Name;

   //save the xml file
   XMLDoc.SaveToFile( _GameListPath );
   XMLDoc.Active:= False;
   FGameListChanged:= True;
end;

//theme selection
procedure TFrm_Editor.Mnu_ThemeClick(Sender: TObject);
begin
  Pgc_Editor.ActivePage := Tbs_Main;
   TStyleManager.TrySetStyle( Cst_ThemeNameStr[GetThemeEnum( ( Sender as TMenuItem).MenuIndex )] );
   FThemeNumber:= ( Sender as TMenuItem ).MenuIndex;
end;

//Language selection
procedure TFrm_Editor.Mnu_LangClick(Sender: TObject);
var
   index, index2, index3, index4: Integer;
   _TmpList: TObjectList<TGame>;
begin
   index:= Cbx_Filter.ItemIndex;
   index2:= Cbx_Hidden.ItemIndex;
   index3:= Cbx_Favorite.ItemIndex;
   index4:= Cbx_KidGame.ItemIndex;
   UseLanguage( Cst_LangNameStr[GetLangEnum( ( Sender as TMenuItem).Tag )] );
   FLanguage:= ( Sender as TMenuItem ).Tag;
   RetranslateComponent( Self );
   Cbx_Filter.ItemIndex:= index;
   Cbx_Hidden.ItemIndex:= index2;
   Cbx_Favorite.ItemIndex:= index3;
   Cbx_KidGame.ItemIndex:= index4;

   //Show the number of found games
   //I am forced to redo this here otherwise the label stays in the old language
   //as long as we have not changed system (found no other way)
   if ( Cbx_Systems.ItemIndex <> -1 ) then begin
      Lbl_NbGamesFound.Caption:= '';
      GSystemList.TryGetValue( getCurrentFolderName, _TmpList );
      if Cbx_Filter.ItemIndex = 0 then
         Lbl_NbGamesFound.Caption:= IntToStr( lbListRoms.Items.Count ) + Rst_GamesFound
      else
         Lbl_NbGamesFound.Caption:= IntToStr( lbListRoms.Items.Count ) + ' / ' +
                                    IntToStr( _TmpList.Count ) + Rst_GamesFound;
   end;

   //To change the scrape language live if we are on the scrape tab
   if ( Pgc_Editor.ActivePage = Tbs_Scrape ) then FillFields;
end;

//On clicking the Advanced name editor menu item
procedure TFrm_Editor.Mnu_NameEditorClick(Sender: TObject);
var
   FrmNameEditor: TFrm_AdvNameEditor;
   RemChars, AddChars, ChangeCase: Boolean;
   NbStart, NbEnd, CaseIndex, ii: Integer;
   StringStart, StringEnd, Preview: string;
begin
   for ii:= 0 to Pred( lbListRoms.Items.Count ) do begin
      if ( lbListRoms.Selected[ii] ) then begin
         Preview:= ( lbListRoms.Items.Objects[ii] as TGame).Name;
         Break;
      end;
   end;

   FrmNameEditor:= TFrm_AdvNameEditor.Create( nil );
   try
      if FrmNameEditor.Execute( RemChars, AddChars, ChangeCase, NbStart, NbEnd,
                                CaseIndex, StringStart, StringEnd, Preview ) then begin
         TransformGamesNames( RemChars, AddChars, ChangeCase, NbStart,
                                NbEnd, CaseIndex, StringStart, StringEnd );
         LoadGamesList( getCurrentFolderName );
      end;
   finally
      FrmNameEditor.Free;
   end;
end;

//Transforms the game names of the selection according to the options
//chosen in the advanced editor.
procedure TFrm_Editor.TransformGamesNames( aRemChars, aAddChars, aChangecase: Boolean;
                                           aNbStart, aNbEnd, aCaseIndex: Integer;
                                           const aStringStart, aStringEnd : string );
var
   _Node: IXMLNode;
   _GameListPath, TmpStr: string;
   _Game: TGame;
   ii: Integer;
begin
   //Retrieve the path to the gamelist.xml file
   _GameListPath:= FRootPath + FCurrentFolder + Cst_GameListFileName;

   //Open the xml file
   XMLDoc.LoadFromFile( _GameListPath );

   Screen.Cursor:= crHourGlass;
   ProgressBar.Visible:= True;
   ProgressBar.Position:= 0;
   ProgressBar.Max:= lbListRoms.SelCount;

   //loop over the selected games
   for ii:= 0 to Pred( lbListRoms.Items.Count ) do begin
      if ( lbListRoms.Selected[ii] ) then begin

         //Retrieve the corresponding game
         _Game:= ( lbListRoms.Items.Objects[ii] as TGame );
         TmpStr:= _Game.Name;

         if aRemChars then begin
            if ( aNbStart > 0 ) then
               TmpStr:= Copy( TmpStr, Succ( aNbStart ), ( TmpStr.Length - aNbStart ) );
            if ( aNbEnd > 0 ) then
               SetLength( TmpStr, TmpStr.Length - aNbEnd );
         end;

         if aChangeCase then begin
            case aCaseIndex of
               0: TmpStr[1]:= UpCase( TmpStr[1] );
               1: TmpStr:= UpperCase( TmpStr );
               2: TmpStr:= LowerCase( TmpStr );
            end;
         end;

         if aAddChars then begin
            if not ( aStringStart.IsEmpty ) then
               TmpStr:= aStringStart + TmpStr;
            if not ( aStringEnd.IsEmpty ) then
               TmpStr:= TmpStr + aStringEnd;
         end;

         //change the game name to the new one
         _Game.Name:= TmpStr;

         //Retrieve the first "game" node
         _Node := XMLDoc.DocumentElement.ChildNodes.FindNode( Cst_Game );

         //And loop to find the right node
         repeat
            if ( _Node.ChildNodes.Nodes[Cst_Path].Text = _Game.RomPath ) then Break;
            _Node := _Node.NextSibling;
         until not Assigned( _Node );

         //change the game name in the xml
         _Node.ChildNodes.Nodes[Cst_Name].Text:= TmpStr;

      end;
   end;

   ProgressBar.Visible:= False;

   //and save
   XMLDoc.SaveToFile( _GameListPath );
   XMLDoc.Active:= False;
   FGameListChanged:= True;

    Screen.Cursor:= crDefault;
end;

//Click on the "Quit" menuitem
procedure TFrm_Editor.Mnu_QuitClick(Sender: TObject);
begin
   //save the options in the ini
   SaveToIni;
   //if the folder was loaded at least once from the pi, we reboot
   if FPiLoadedOnce then begin
      //show or not the reboot info prompt
      if not FPiPrompts then
         MyMessageDlg( Rst_RebootRecal, mtInformation, [mbOK], [Rst_Ok], Rst_Info );
      if FSysIsRecal then StopOrStartES( False, True )
      else StopOrStartES( False, False );
   end;
   Application.Terminate;
end;



// Added by Benjamin.A on 13/11/2017 11:24:50 :
// From here all the methods used in the scrape tab
//******************************************************************************



// Added by Benjamin.A on 13/11/2017 11:26:29 :
//On displaying the Scrape tab
procedure TFrm_Editor.Tbs_ScrapeShow(Sender: TObject);
begin
   StopGameVideo;

   //if proxy, fill it in
   if FProxyUse then begin
      Net_HTTPClient.ProxySettings := TProxySettings.Create(
                                          FProxyServer,
                                          StrToInt( FProxyPort ),
                                          FProxyUser,
                                          FProxyPwd);
   end else begin
      Net_HTTPClient.ProxySettings := TProxySettings.Create('', 0, '', '');
   end;

   ClearScrapeMedia;

   //disable the mainmenu items that should not be used
   Mnu_Actions.Enabled:= False;
   Mnu_Theme.Enabled:= False;
end;

//When leaving the scrape tab, clear the lists
//And reload the game in case we modified some stuff
procedure TFrm_Editor.Tbs_ScrapeHide(Sender: TObject);
begin
   if Assigned( FScrapedGame ) and
      ( ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame ) =
      FScrapedGame ) then
      LoadGame( FScrapedGame )
   else
      UpdateVideo( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame );

   //re-enable the mainmenu items disabled when entering the tab
   Mnu_Actions.Enabled:= True;
   Mnu_Theme.Enabled:= True;
end;

procedure TFrm_Editor.ClearScrapeMedia;
begin
   // Clear the Save Picture and Save Video buttons until rescraping or
   // clicking another picture
   FVideoScrapeLink := '';
   Chk_ScrapePicture.Checked := False;
   Chk_ScrapePicture.Enabled := False;
   Chk_ScrapeVideo.Checked := False;
   Chk_ScrapeVideo.Enabled := False;
end;

//GET request to retrieve the XML of the game info.
function TFrm_Editor.GetGameXml( const aSysId: string; aGame: TGame ): Boolean;
var
   Query, Crc32, Size: String;
   Stream: TBytesStream;
begin
   Result:= False;
   //Calculation of the Crc and file size
   if Chk_ManualCRC.Checked then Crc32:= Edt_ManualCRC.Text
   else Crc32:= aGame.CalculateCrc32( aGame.PhysicalRomPath );

   Size:= GetFileSize( aGame.PhysicalRomPath );

   //building the API request for the game
   Query:= Cst_ScraperAddress + Cst_Category + Cst_ScrapeLogin + Cst_ScrapePwd +
           Cst_DevSoftName + Cst_Output;

   if ( not FSSLogin.IsEmpty ) and ( not FSSPwd.IsEmpty ) then
      Query:= Query + Cst_SSId + FSSLogin + Cst_SSPwd + FSSPwd;

   Query:= Query + Cst_Crc + Crc32 + Cst_SystemId + aSysId;

   if not ( Chk_ManualCRC.Checked ) then
      Query:= Query + Cst_RomName + TIdURI.ParamsEncode( aGame.RomName ) + Cst_RomSize + Size;

   //loading into a stream to avoid corrupting the encoding
   Stream:= TBytesStream.Create;
   try
      try
         Net_HTTPClient.Get( Query, Stream );
         if ( Stream.Size = 0 ) then begin
            WarnUser( Rst_StreamError );
            Exit;
         end;
         Stream.Position:= 0;
         XMLDoc.LoadFromStream( Stream );
         XMLDoc.SaveToFile( FTempXmlPath );
      except
         on E : Exception do
         begin
            // Legacy errors
            //   400: WarnUser( Rst_ServerError1 );
            //   401: WarnUser( Rst_ServerError2 );
            //   403: WarnUser( Rst_ServerError3 );
            //   404: WarnUser( Rst_ServerError4 );
            //   423: WarnUser( Rst_ServerError5 );
            //   426: WarnUser( Rst_ServerError6 );
            //   429: WarnUser( Rst_ServerError7 );
            WarnUserWithSafeUrl( Rst_ServerError8, E.Message, Query );
            Exit;
         end;
      end;
   finally
      Stream.Free;
   end;
   Result:= True;
end;

//parsing the Xml to retrieve everything: description, region, player count etc...
procedure TFrm_Editor.ParseXml;

   function CreateDict( aNodeList: IXMLNodeList; const aAttName: string ): TDictionary<string, string>;
   var
      ii: Integer;
   begin
      Result:= TDictionary<string, string>.Create;
      for ii:= 0 to Pred( aNodeList.Count ) do begin
         Result.AddOrSetValue( aNodeList[ii].Attributes[aAttName], aNodeList[ii].Text );
      end;
   end;

   function CreateGenreDict( aNodeList: IXMLNodeList; const aAttId, aAttLang: string ): TObjectDictionary<string, TDictionary<string, string>>;
   var
      ii: Integer;
      id: string;
      List: TDictionary<string, string>;
   begin
      Result:= TObjectDictionary<string, TDictionary<string, string>>.Create( [doOwnsValues] );
      List:= TDictionary<string, string>.Create;
      id:= aNodeList[0].Attributes[aAttId];
      for ii:= 0 to Pred( aNodeList.Count ) do begin
         if ( aNodeList[ii].Attributes[aAttId] = id ) then
            List.AddOrSetValue ( aNodeList[ii].Attributes[aAttLang], aNodeList[ii].Text )
         else begin
            Result.Add( id, List );
            id:= aNodeList[ii].Attributes[aAttId];
            List:= TDictionary<string, string>.Create;
            List.AddOrSetValue ( aNodeList[ii].Attributes[aAttLang], aNodeList[ii].Text );
         end;
      end;
      Result.Add( id, List );
   end;

   //Returns a numeric preference for a media region (higher = more preferred).
   //ScreenScraper returns one media node per region for the same type, so we
   //keep only the variant matching the preferred regions, in this order:
   //World, Screenscraper fallback, the user's language region, USA, Europe,
   //Japan, any other specific region, then the empty region.
   function GetRegionPriority( const aRegion: string ): Integer;
   begin
      Result:= 40;   //default for any specific region
      case GetCountryEnum( aRegion ) of
         cnWor: Result:= 100;
         cnUs:  Result:= 70;
         cnEu:  Result:= 60;
         cnJp:  Result:= 50;
      end;
      //the screenscraper generated fallback is second best
      if ( aRegion = 'ss' ) then Result:= 90;
      //the user's language region is preferred over the generic ones
      case GetLangEnum( FLanguage ) of
         lnFrench:        if ( aRegion = 'fr' ) then Result:= 80;
         lnGerman:        if ( aRegion = 'de' ) then Result:= 80;
         lnSpanish:       if ( aRegion = 'sp' ) then Result:= 80;
         lnPortuguese_BR: if ( aRegion = 'br' ) then Result:= 80;
         lnEnglish:       if ( ( aRegion = 'uk' ) or ( aRegion = 'us' ) ) then Result:= 80;
      end;
      //an empty region is the least preferred
      if ( aRegion = '' ) then Result:= 10;
   end;

   //Returns whether the media type is one of the selected image types
   function IsImageTypeSelected( const aType: string ): Boolean;
   begin
      Result:= ( ( aType = Cst_MediaBox2d ) and ( Chk_Box2D.Checked ) ) or
               ( ( aType = Cst_MediaScreenShot ) and ( Chk_Screenshot.Checked ) ) or
               ( ( aType = Cst_MediaSsTitle ) and ( Chk_Title.Checked ) ) or
               ( ( aType = Cst_MediaBox3d ) and ( Chk_Box3D.Checked ) ) or
               ( ( aType = Cst_MediaMix1 ) and ( Chk_Mix1.Checked ) ) or
               ( ( aType = Cst_MediaMix2 ) and ( Chk_Mix2.Checked ) ) or
               ( ( aType = Cst_MediaArcadeBox1 ) and ( Chk_ArcadeBox.Checked ) ) or
               ( ( aType = Cst_MediaWheel ) and ( Chk_Wheel.Checked ) );
   end;

var
   Nodes: IXMLNodeList;
   RootNode, Node: IXMLNode;
   ii: Integer;
   List: TStringList;
   Media: TMediaInfo;
   MediaBest: TDictionary<string, TMediaInfo>;
   MediaBestRegion: TDictionary<string, string>;
   aType: string;
begin
   //opening the xml file
   XMLDoc.LoadFromFile( FTempXmlPath );

   //Find the node we are interested in
   RootNode:= XMLDoc.ChildNodes[Cst_DataNode].ChildNodes[Cst_GameNode];

   Node:= RootNode.ChildNodes.FindNode(Cst_NamesNode);
   if Assigned( Node ) then begin
      Nodes:= Node.ChildNodes;
      if Assigned( Nodes ) then FInfosList.AddObject( Cst_NamesNode, CreateDict( Nodes, Cst_AttRegion ) );
   end else FInfosList.Add( '' );

   Node:= RootNode.ChildNodes.FindNode( Cst_RegionsNode );
   if Assigned( Node ) then begin
      Nodes:= Node.ChildNodes;
      if Assigned( Nodes ) then begin
         List:= TStringList.Create;
         for ii:= 0 to Pred( Nodes.Count ) do begin
            List.Add( Nodes[ii].Text );
         end;
         FInfosList.AddObject( Cst_RegionsNode, List );
      end;
   end else FInfosList.Add( '' );

   Node:= RootNode.ChildNodes.FindNode( Cst_SynopNode );
   if Assigned( Node ) then begin
      Nodes:= Node.ChildNodes;
      if Assigned( Nodes ) then FInfosList.AddObject( Cst_SynopNode, CreateDict( Nodes, Cst_AttLang ) );
   end else FInfosList.Add( '' );

   Node:= RootNode.ChildNodes.FindNode( Cst_DateNode );
   if Assigned( Node ) then begin
      Nodes:= Node.ChildNodes;
      if Assigned( Nodes ) then FInfosList.AddObject( Cst_DateNode, CreateDict( Nodes, Cst_AttRegion ) );
   end else FInfosList.Add( '' );

   Node:= RootNode.ChildNodes.FindNode( Cst_GenreNode );
   if Assigned( Node ) then begin
      Nodes:= Node.ChildNodes;
      if Assigned( Nodes ) then FInfosList.AddObject( Cst_GenreNode, CreateGenreDict( Nodes, Cst_AttId, Cst_AttLang ) );
   end else FInfosList.Add( '' );

   Node:= RootNode.ChildNodes.FindNode( Cst_EditNode );
   if Assigned( Node ) then FInfosList.Add( Node.Text )
   else FInfosList.Add( '' );

   Node:= RootNode.ChildNodes.FindNode( Cst_DevNode );
   if Assigned( Node ) then FInfosList.Add( Node.Text )
   else FInfosList.Add( '' );

   Node:= RootNode.ChildNodes.FindNode( Cst_PlayersNode );
   if Assigned( Node ) then FInfosList.Add( Node.Text )
   else FInfosList.Add( '' );

   Node:= RootNode.ChildNodes.FindNode( Cst_NoteNode );
   if Assigned( Node ) then FInfosList.Add( Node.Text )
   else FInfosList.Add( '' );

   Node:= RootNode.ChildNodes.FindNode( Cst_MediaNode );
   if Assigned( Node ) then begin
      Nodes:= Node.ChildNodes;
if Assigned( Nodes ) and ( Nodes.Count > 0 ) then begin
         //Video types enable the Save Video button and keep the link for later
          for ii:= 0 to Pred( Nodes.Count ) do begin
             if ( ( Nodes[ii].Attributes[Cst_AttType] = Cst_MediaVideo ) and
                  ( Chk_Video.Checked ) ) then begin
                FVideoScrapeLink:= Nodes[ii].Text;
                Chk_ScrapeVideo.Checked:= true;
                Chk_ScrapeVideo.Enabled:= true;
                Break;
             end;
          end;

          //For each selected image type, keep only the variant of the preferred
          //region instead of downloading every region variant of that type.
          MediaBest:= TDictionary<string, TMediaInfo>.Create;
          MediaBestRegion:= TDictionary<string, string>.Create;
          try
             for ii:= 0 to Pred( Nodes.Count ) do begin
                aType:= Nodes[ii].Attributes[Cst_AttType];
                if not IsImageTypeSelected( aType ) then Continue;
                if ( not MediaBest.ContainsKey( aType ) ) or
                   ( GetRegionPriority( Nodes[ii].Attributes[Cst_AttRegion] ) >
                     GetRegionPriority( MediaBestRegion[aType] ) ) then begin
                   if not MediaBest.ContainsKey( aType ) then begin
                      Media:= TMediaInfo.Create;
                      MediaBest.Add( aType, Media );
                      MediaBestRegion.Add( aType, Nodes[ii].Attributes[Cst_AttRegion] );
                   end else
                      MediaBestRegion[aType]:= Nodes[ii].Attributes[Cst_AttRegion];
                   MediaBest[aType].FileExt:= Nodes[ii].Attributes[Cst_AttFormat];
                   MediaBest[aType].FileLink:= Nodes[ii].Text;
                end;
             end;
             for Media in MediaBest.Values do
                FPictureLinks.Add( Media );
          finally
             MediaBest.Free;
             MediaBestRegion.Free;
          end;
       end;
    end;

   try
      RootNode:= XMLDoc.ChildNodes[Cst_DataNode].ChildNodes[Cst_UserNode];
      Node:= RootNode.ChildNodes.FindNode( Cst_ThreadNode );
      if Assigned( Node ) then begin
        if not TryStrToInt( Node.Text, FMaxThreads ) then
           FMaxThreads:= 1;
      end;
   except
      FMaxThreads:= 1;
   end;

   //delete the temporary xml file (no longer needed)
   DeleteFile( FTempXmlPath );
end;

//Creates the images from the global list of links.
//(starting the number of threads according to the screenscraper user)
procedure TFrm_Editor.GetPictures;
var
   ii: Integer;
begin
   //if there is no image to retrieve, we re-enable everything and exit
   if ( FPictureLinks.Count = 0 ) then begin
      Img_Loading.Visible:= False;
      FillFields;
      EnableScrapeComponents( True );
      Enabled:= True;
      Exit;
   end;

   FThreadCount:= 0;
   FStartCount:= FPictureLinks.Count;
   for ii:= 0 to Pred( FMaxthreads ) do begin
      if ( FPictureLinks.Count > 0 ) then
         GetPicture( FPictureLinks.Extract( FPictureLinks[0] ) );
   end;
end;

//Creates an image download thread
procedure TFrm_Editor.GetPicture( aMedia: TMediaInfo );
var
   Thread: TDOwnThread;
begin
   Thread:= TDOwnThread.Create;
   Thread.Url:= aMedia.FileLink;
   Thread.Ext:= aMedia.FileExt;
   Thread.OnTerminate:= ThreadTerminated;
   Thread.Start;
end;

//Action performed by a thread when it ends
procedure TFrm_Editor.ThreadTerminated( Sender: TObject );
begin
   //lock access to the thread counter
   CounterGuard.Acquire;

   Inc( FThreadCount );
   if ( FPictureLinks.Count > 0 ) then begin
      GetPicture( FPictureLinks.Extract( FPictureLinks[0] ) );
   end else if ( FThreadCount = FStartCount ) then begin
      DisplayPictures;
      Img_Loading.Visible:= False;
      FillFields;
      EnableScrapeComponents( True );
      Enabled:= True;
   end;

   //release the counter lock
   CounterGuard.Release;
end;

//Display of the retrieved images
procedure TFrm_Editor.DisplayPictures;

   //Adds the current image of the game (if any) as an extra selectable picture,
   //so the user can keep the existing image instead of a downloaded one.
   procedure AddExistingImage;
   var
      ExistingImg: TImage;
   begin
      if Assigned( FScrapedGame ) and
         ( not FScrapedGame.PhysicalImagePath.IsEmpty ) and
         FileExists( FScrapedGame.PhysicalImagePath ) then begin
         ExistingImg:= TImage.Create( nil );
         try
            ExistingImg.Picture.LoadFromFile( FScrapedGame.PhysicalImagePath );
            ExistingImg.AutoSize:= True;
            ExistingImg.Proportional:= True;
            ExistingImg.Center:= True;
            ExistingImg.Visible:= False;
            FImgList.Add( ExistingImg );
         except
            on E: Exception do
               ExistingImg.Free;
         end;
      end;
   end;

var
   ii, Left, Count: Integer;
begin
   AddExistingImage;

   Count:= FImgList.Count;
   if ( Count = 0 ) then Exit;

   case Count of
      1: Left:= 430;
      2: Left:= 250;
      else Left:= 50;
   end;

   for ii:= 0 to Pred( Count ) do begin
      FImgList.Items[ii].Parent:= Scl_Pictures;
      FImgList.Items[ii].Top:= 0;
      FImgList.Items[ii].Left:= Left;
      FImgList.Items[ii].Constraints.MinHeight:= 300;
      FImgList.Items[ii].Constraints.MaxHeight:= 300;
      FImgList.Items[ii].Constraints.MaxWidth:= 300;
      FImgList.Items[ii].OnClick:= ImgScrapedClick;
      FImgList.Items[ii].Center:= True;
      FImgList.Items[ii].Visible:= True;
      Left:= Left + FImgList.Items[ii].Width + 50;
   end;

   //to force the scrollbox to correctly display the scrollbar...
   Scl_Pictures.Realign;

   //Select the first picture by default so a scrape can be saved right away
   //without the user having to click one of the thumbnails.
   ImgScrapedClick( FImgList.Items[0] );
end;

//Filling the fields with the scraped info
procedure TFrm_Editor.FillFields;

   function GetFormatedDate( const aStr: string ): string;
   var
      Day, Month, Year: string;
   begin
      //if the string is 4 characters long
      if ( Length( aStr) = 4 ) then
         Result:= aStr;
      
      //if the string is 7 characters long
      if ( Length( aStr) = 7 ) then begin
         Month:= Copy( aStr, 6, 2 );
         Year:= Copy( aStr, 1, 4 );
         Result:= Month + '/' + Year;
      end;
      
      //if the string is 10 characters long
      if ( Length( aStr) = 10 ) then begin
         Day:= Copy( aStr, 9, 2 );
         Month:= Copy( aStr, 6, 2 );
         Year:= Copy( aStr, 1, 4 );
         Result:= Day + '/' + Month + '/' + Year;
      end;      
   end;
   
var
   LangStr, TmpStr: string;
   ii, Count: Integer;
   Dict: TDictionary<string, string>;
   ObjectDict: TObjectDictionary<string, TDictionary<string, string>>;
   Item: TPair<string, TDictionary<string, string>>;
   List: TStringList;
begin
   //Get the string corresponding to the "current" language
   LangStr:= Copy( Cst_LangNameStr[GetLangEnum( FLanguage )], 1 , 2 );

   if ( FInfosList.Count = 0 ) then Exit;

   //nom
   if ( not FInfosList[0].IsEmpty ) then begin
      Dict:= ( FInfosList.Objects[0] as TDictionary<string, string> );
      if Dict.TryGetValue( LangStr, TmpStr ) or
         Dict.TryGetValue( Cst_CountryName[cnEu], TmpStr ) or
         Dict.TryGetValue( Cst_CountryName[cnWor], TmpStr ) or
         Dict.TryGetValue( 'ss', TmpStr ) then
         Edt_ScrapeName.Text:= TmpStr
      else Edt_ScrapeName.Text:= '';
   end else Edt_ScrapeName.Text:= '';

   //region
   if not FInfosList[1].IsEmpty then begin
      List:= ( FInfosList.Objects[1] as TStringList );
      Edt_ScrapeRegion.Text:= '';
      for ii:= 0 to Pred( List.Count ) do begin
         Edt_ScrapeRegion.Text:= Edt_ScrapeRegion.Text +
                                 Cst_CountryNameFull[GetCountryEnum( List[ii] )][Succ(FLanguage)];
         if ( ii < Pred( List.Count ) ) then
         Edt_ScrapeRegion.Text:= Edt_ScrapeRegion.Text + ' - ';
      end;
   end else Edt_ScrapeRegion.Text:= '';

   //description
   if ( not FInfosList[2].IsEmpty )  then begin
      Dict:= ( FInfosList.Objects[2] as TDictionary<string, string> );
      if Dict.TryGetValue( LangStr, TmpStr ) or
         Dict.TryGetValue( Cst_LangNameStr[lnEnglish], TmpStr ) or
         Dict.TryGetValue( Cst_LangNameStr[lnGerman], TmpStr ) or
         Dict.TryGetValue( Cst_LangNameStr[lnSpanish], TmpStr ) or
         Dict.TryGetValue( Copy( Cst_LangNameStr[lnPortuguese_BR], 1, 2 ), TmpStr ) then
         Mmo_ScrapeDescription.Text:= TmpStr
      else Mmo_ScrapeDescription.Text:= '';
   end else Mmo_ScrapeDescription.Text:= '';

   //date
   if ( not FInfosList[3].IsEmpty )  then begin
      Dict:= ( FInfosList.Objects[3] as TDictionary<string, string> );
      if Dict.TryGetValue( LangStr, TmpStr ) or
         Dict.TryGetValue( Cst_CountryName[cnEu], TmpStr ) or
         Dict.TryGetValue( Cst_CountryName[cnWor], TmpStr ) or
         Dict.TryGetValue( Cst_CountryName[cnUs], TmpStr ) or
         Dict.TryGetValue( Cst_CountryName[cnJp], TmpStr )then
         Edt_ScrapeDate.Text:= GetFormatedDate( TmpStr )
      else Edt_ScrapeDate.Text:= '';
   end else Edt_ScrapeDate.Text:= '';

   //genre
   if ( not FInfosList[4].IsEmpty )  then begin
      ObjectDict:= ( FInfosList.Objects[4] as TObjectDictionary<string, TDictionary<string, string>> );
      Edt_ScrapeGenre.Text:= '';
      Count:= 0;
      for Item in ObjectDict do begin
         Inc( Count );
         if ( Item.Value.TryGetValue( LangStr, TmpStr ) ) or
            ( Item.Value.TryGetValue( Cst_LangNameStr[lnEnglish], TmpStr ) ) or
            ( Item.Value.TryGetValue( Cst_LangNameStr[lnGerman], TmpStr ) ) or
            ( Item.Value.TryGetValue( Cst_LangNameStr[lnSpanish], TmpStr ) ) or
            ( Item.Value.TryGetValue( Copy( Cst_LangNameStr[lnPortuguese_BR], 1, 2 ), TmpStr ) ) then
            Edt_ScrapeGenre.Text:= Edt_ScrapeGenre.Text + TmpStr
         else Edt_ScrapeGenre.Text:= Edt_ScrapeGenre.Text + '';
         if ( Count < ObjectDict.Count ) then Edt_ScrapeGenre.Text:= Edt_ScrapeGenre.Text + ' - ';
      end;
   end else Edt_ScrapeGenre.Text:= '';

   //editeur
   Edt_ScrapePublisher.Text:= FInfosList[5];

   //developpeur
   Edt_ScrapeDeveloper.Text:= FInfosList[6];

   //players
   Edt_ScrapePlayers.Text:= FInfosList[7];

   //note
   Edt_ScrapeRating.Text:= FInfosList[8];

end;

procedure TFrm_Editor.FindGameRoms(const aSystem: string);

  function FindFiles(const Path, Mask: string): TStringList;
  var
    Masks: TArray<string>;
    CurrentMask: string;
    SearchRec: TSearchRec;
    FullPath: string;
    Found: Integer;
    UniqueFiles: TDictionary<string, Boolean>;
  begin
    Result := TStringList.Create;
    if not DirectoryExists(Path) then Exit;

    UniqueFiles := TDictionary<string, Boolean>.Create;
    try
      // ��������� ����������� ����� �� ��������� �����
      Masks := Mask.Split([';'], TStringSplitOptions.ExcludeEmpty);

      for CurrentMask in Masks do
      begin
        // �������� ����� �� ������� �����
        Found := FindFirst(IncludeTrailingPathDelimiter(Path) + CurrentMask, faAnyFile, SearchRec);
        try
          while Found = 0 do
          begin
            // ���������� ��������� ����� � ����������
            if (SearchRec.Name <> '.') and
               (SearchRec.Name <> '..') and
               ((SearchRec.Attr and faDirectory) = 0) then
            begin
              FullPath := IncludeTrailingPathDelimiter(Path) + SearchRec.Name;

              // ��������� ������ ���������� �����
              if not UniqueFiles.ContainsKey(FullPath) then
              begin
                Result.Add( ExtractFileName(FullPath));
                UniqueFiles.Add(FullPath, True);
              end;
            end;
            Found := FindNext(SearchRec);
          end;
        finally
          FindClose(SearchRec);
        end;
      end;
    finally
      UniqueFiles.Free;
    end;
  end;
  
var
  rom: Integer;
  game: Integer;
  newGame: TGame;
  gamePath: String;
  romFiles : TStringList;
  gameList: TObjectList<TGame>;
begin
  gamePath:=IncludeTrailingPathDelimiter( FRootPath + aSystem );
  romFiles := FindFiles(gamePath, leROMext.Text);
  mLog.Lines.Add(IntToStr(romFiles.Count) +' files found');

  GSystemList.TryGetValue( getCurrentFolderName, gameList );

  for game := 0 to Pred( gameList.Count ) do begin
    for rom := 0 to Pred( romFiles.Count ) do begin
      if romFiles[rom] = ExtractFileName((gameList[game]).RomName) then begin
        mLog.Lines.Add({'G'+IntToStr(game) + '= R'+IntToStr(rom)+ ' '+}romFiles[rom]+' is '+ gameList[game].Name);
        romFiles.Delete(rom);
        break;
      end;
    end;
  end;

  lbRoms.Clear;
  lbRoms.Items.Assign(romFiles);

  mLog.Lines.Add(IntToStr(lbRoms.Items.Count) +' new games found');

  { DONE -oRaJa -cFeature : Add missing ROMs to GameList }
  { TODO -oRaJa -cFeature : Join gamelists: Add gamelist file to active gamelist }
  { TODO -oRaJa -cFeature : Find Video in Media folder }
  { TODO -oRaJa -cFeature : Find Image in Media folder }
  { TODO -oRaJa -cFeature : Delete Selected Records from GameList }
end;

//converts the scrape fields to upper or lower case
procedure TFrm_Editor.ConvertScrapeToUpOrLow( aUp: Boolean = False );
begin
   Edt_ScrapeGenre.Text:=  IfThen( aUp, AnsiUpperCase( Edt_ScrapeGenre.Text ),
                                        AnsiLowerCase( Edt_ScrapeGenre.Text ) );
   Edt_ScrapeName.Text:= IfThen( aUp, AnsiUpperCase( Edt_ScrapeName.Text ),
                                      AnsiLowerCase( Edt_ScrapeName.Text ) );
   Edt_ScrapeRegion.Text:= IfThen( aUp, AnsiUpperCase( Edt_ScrapeRegion.Text ),
                                        AnsiLowerCase( Edt_ScrapeRegion.Text ) );
   Edt_ScrapeDeveloper.Text:= IfThen( aUp, AnsiUpperCase( Edt_ScrapeDeveloper.Text ),
                                           AnsiLowerCase( Edt_ScrapeDeveloper.Text ) );
   Edt_ScrapeRating.Text:= IfThen( aUp, AnsiUpperCase( Edt_ScrapeRating.Text ),
                                        AnsiLowerCase( Edt_ScrapeRating.Text ) );
   Edt_ScrapePlayers.Text:= IfThen( aUp, AnsiUpperCase( Edt_ScrapePlayers.Text ),
                                         AnsiLowerCase( Edt_ScrapePlayers.Text ) );
   Edt_ScrapePublisher.Text:= IfThen( aUp, AnsiUpperCase( Edt_ScrapePublisher.Text ),
                                           AnsiLowerCase( Edt_ScrapePublisher.Text ) );
   Mmo_ScrapeDescription.Text:= IfThen( aUp, AnsiUpperCase( Mmo_ScrapeDescription.Text ),
                                             AnsiLowerCase( Mmo_ScrapeDescription.Text ) );
end;

//activates the components of the scrape window
procedure TFrm_Editor.EnableScrapeComponents( aValue: Boolean );
begin
   Edt_ScrapeGenre.Enabled:= aValue;
   Edt_ScrapeDate.Enabled:= aValue;
   Edt_ScrapeName.Enabled:= aValue;
   Edt_ScrapeRegion.Enabled:= aValue;
   Edt_ScrapeDeveloper.Enabled:= aValue;
   Edt_ScrapeRating.Enabled:= aValue;
   Edt_ScrapePlayers.Enabled:= aValue;
   Edt_ScrapePublisher.Enabled:= aValue;
   Mmo_ScrapeDescription.Enabled:= aValue;

   Lbl_ScrapeDate.Enabled:= aValue;
   Lbl_ScrapeGenre.Enabled:= aValue;
   Lbl_ScrapeName.Enabled:= aValue;
   Lbl_ScrapeRegion.Enabled:= aValue;
   Lbl_ScrapeDeveloper.Enabled:= aValue;
   Lbl_ScrapeRating.Enabled:= aValue;
   Lbl_ScrapePlayers.Enabled:= aValue;
   Lbl_ScrapePublisher.Enabled:= aValue;
   Lbl_ScrapeDescription.Enabled:= aValue;

   Btn_ScrapeSave.Enabled:= aValue;
   Btn_ScrapeLower.Enabled:= aValue;
   Btn_ScrapeUpper.Enabled:= aValue;

   Chk_ScrapeInfos.Enabled:= aValue;
end;

//To warn the user if problem or no media found
procedure TFrm_Editor.WarnUser( const aMessage: string );
begin
   //During a silent batch operation, do not interrupt the user with a modal
   //dialog for each failure; the batch reports a summary at the end instead.
   if FSuppressDialogs then Exit;
   Screen.Cursor:= crDefault;
   ShowMessage( aMessage );
end;

procedure TFrm_Editor.WarnUserWithSafeUrl( const aMessage, aMessage2, aUrl: string );
var
   aSafeUrl : string;
begin
   // Fix & that otherwise would not show, and remove password
   aSafeUrl :=  aUrl.Replace('&','&&').Replace(Cst_ScrapePwd, Cst_ScrapePwdSafe);

   // If the URL is too long, split in two lines
   if aSafeUrl.Length > 160 then aSafeUrl.Insert(120, sLineBreak);

   WarnUser( aMessage + sLineBreak +
             aMessage2 + sLineBreak + sLineBreak +
             aSafeUrl);
end;

//To retrieve the file size of the game
function TFrm_Editor.GetFileSize( const aPath: string ): string;
var
   Reader: TFileStream;
begin
   Reader:= TFile.OpenRead( aPath );
   try
      Result:= IntToStr( Reader.Size );
   finally
      Reader.Free;
   end;
end;

//On clicking the Scraper button
procedure TFrm_Editor.Btn_ScrapeClick( Sender: TObject );
begin
   //Clean the lists and fields to start
   Pgc_Editor.ActivePage := Tbs_Scrape;
   EmptyScrapeFields;
   ClearScrapeMedia;

   //When several games are selected, scrape them all and apply the results
   //directly to the gamelist (the user only has to save it afterwards).
   if ( lbListRoms.SelCount > 1 ) then begin
      ScrapeAndApplySelectedGames;
      Exit;
   end;

   //disable to avoid stray clicks during loading
   Img_Loading.Visible:= True;
   Refresh;
   Enabled:= False;
   if ( lbListRoms.Count > 0 ) then begin
      FScrapedGame:= ( lbListRoms.Items.Objects[lbListRoms.ItemIndex] as TGame );
      if GetGameXml( GetCurrentSystemId, FScrapedGame ) then begin
         ParseXml;
         GetPictures;
      end else begin
         Img_Loading.Visible:= False;
         Enabled:= True;
      end;
   end;
end;

//on clicking the save changes scrape button
procedure TFrm_Editor.Btn_ScrapeSaveClick(Sender: TObject);
begin
   SaveChangesToGamelist( True, Chk_ScrapeVideo.Checked, Chk_ScrapePicture.Checked, Chk_ScrapeInfos.Checked );
end;

//on clicking the scrape tab checkboxes (to save the changes)
procedure TFrm_Editor.Chk_ScrapeClick(Sender: TObject);
begin
   Btn_ScrapeSave.Enabled:= ( Chk_ScrapeInfos.Checked ) or ( Chk_ScrapePicture.Checked ) or ( Chk_ScrapeVideo.Checked );
end;

//on clicking the convert all text to uppercase button
procedure TFrm_Editor.Btn_ScrapeUpperClick(Sender: TObject);
begin
   ConvertScrapeToUpOrLow( True );
end;

//on clicking the convert all text to lowercase button
procedure TFrm_Editor.Btn_ScrapeLowerClick(Sender: TObject);
begin
   ConvertScrapeToUpOrLow;
end;

//horizontal scroll with mouse
procedure TFrm_Editor.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
          MousePos: TPoint; var Handled: Boolean);
begin
   if ( Pgc_Editor.ActivePage = Tbs_Scrape ) then
      Scl_Pictures.Perform(WM_HSCROLL,1,0);
end;

//horizontal scroll with mouse
procedure TFrm_Editor.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
          MousePos: TPoint; var Handled: Boolean);
begin
   if ( Pgc_Editor.ActivePage = Tbs_Scrape ) then
      Scl_Pictures.Perform(WM_HSCROLL,0,0);
end;

procedure TFrm_Editor.ImgScrapedClick(Sender: TObject);
begin
   Img_ScrapeBackground.Visible:= False;
   Img_Scrape.Picture.Graphic:= ( Sender as TImage ).Picture.Graphic;
   Chk_ScrapePicture.Enabled:= True;
   Chk_ScrapePicture.Checked:= True;
end;

procedure TFrm_Editor.Chk_ManualCRCClick(Sender: TObject);
begin
   Edt_ManualCRC.Enabled:= Chk_ManualCRC.Checked;
end;


//******************************************************************************
//Just before closing the program, save the options in the .INI
procedure TFrm_Editor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   //save the options in the ini
   SaveToIni;
   //if the folder was loaded at least once from the pi, we reboot
   if FPiLoadedOnce then begin
      //show or not the reboot info prompt
      if not FPiPrompts then
         MyMessageDlg( Rst_RebootRecal, mtInformation, [mbOK], [Rst_Ok], Rst_Info );
      if FSysIsRecal then StopOrStartES( False, True )
      else StopOrStartES( False, False );
   end;
end;

// Stop video to prevent crashing the app on closing
procedure TFrm_Editor.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   //ask the user to save the gamelist if it was modified before closing
   if FGameListChanged then
      CanClose:= ConfirmSaveGameList( False );

   if not CanClose then Exit;

   if not FIsWine then
   begin
      Wmp_Video.controls.stop;
   end;
end;

//Memory cleanup at program shutdown
procedure TFrm_Editor.FormDestroy(Sender: TObject);
begin
   //All the lists being "owner" of their objects
   //a simple Free on this list will automatically clear the others
   GSystemList.Free;

   FFilteredGames.Free;
   //Free all the scrape lists
   FImgList.Free;
   FInfosList.Free;
   FPictureLinks.Free;
   FRomsStatusMap.Free;
   if not FIsWine then
      Wmp_Video.Free;

   //release the thread counter lock object
   CounterGuard.Free;
end;

end.
