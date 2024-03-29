{ ****************************************************************************** }
{ * MixedLibrary,writen by QQ 600585@qq.com                                    * }
{ * https://github.com/PassByYou888/CoreCipher                                 * }
(* https://github.com/PassByYou888/ZServer4D *)
{ ***************************************************************************** }

{ ****************************************************************************** }
{ ***************************************************************
  *
  * Unit Name: MixedLibrary
  * Purpose  : mixed Low Level Function Library
  *
  **************************************************************** }

(*
  update history
  2017-11-26 fixed UmlMD5Stream and umlMD5 calculate x64 and x86,ARM platform more than 4G memory Support QQ600585
*)

unit UnicodeMixedLib;

{$I zDefine.inc}

interface

uses SysUtils, Types, Variants,
  PascalStrings,
  CoreClasses;

const
  umlAddressLength = SizeOf(Pointer);

  umlIntegerLength  = 4;
  umlInt64Length    = 8;
  umlUInt64Length   = 8;
  umlSingleLength   = 4;
  umlDoubleLength   = 8;
  umlExtendedLength = 10;
  umlSmallIntLength = 2;
  umlByteLength     = 1;
  umlShortIntLength = 1;
  umlWordLength     = 2;
  umlDWORDLength    = 4;
  umlCardinalLength = 4;
  umlBooleanLength  = 1;
  umlBoolLength     = 1;
  umlMD5Length      = 16;
  umlDESLength      = 8;

  umlMaxSearchRec = 1024;

  umlMaxFileRecSize = $F000;

  umlSeekError       = -910;
  umlFileWriteError  = -909;
  umlFileReadError   = -908;
  umlFileHandleError = -907;
  umlCloseFileError  = -906;
  umlOpenFileError   = -905;
  umlNotOpenFile     = -904;
  umlCreateFileError = -903;
  umlFileIsActive    = -902;
  umlNotFindFile     = -901;
  umlNotError        = -900;

  FixedLengthStringSize       = 64;
  FixedLengthStringHeaderSize = 1;

  PrepareReadCacheSize = 512;

type
  umlSystemString   = SystemString;
  umlString         = TPascalString;
  umlPString        = ^umlString;
  umlChar           = SystemChar;
  umlStringDynArray = array of string;

  umlBytes = TBytes;

  TSR = TSearchRec;

  TMixedStream = TCoreClassStream;

  TIOHnd = record
    IsOnlyRead: Boolean;
    OpenFlags: Boolean;
    AutoFree: Boolean;
    Handle: TMixedStream;
    Time: TDateTime;
    Attrib: Integer;
    Size: Int64;
    Position: Int64;
    Name: umlString;
    FlushBuff: TMixedStream;
    PrepareReadPosition: Int64;
    PrepareReadBuff: TMixedStream;
    WriteFlag: Boolean;
    Data: Pointer;
    Return: Integer;
  end;

  umlArraySystemString = array of string;
  umlArrayString       = array of umlString;
  pumlArrayString      = ^umlArrayString;

  FixedLengthString = packed record
    len: Byte;
    Data: packed array [0 .. FixedLengthStringSize] of Byte;
  end;

function umlBytesOf(S: umlString): TBytes; inline;
function umlStringOf(S: TBytes): umlString; overload; inline;

function FixedLengthString2Pascal(var S: FixedLengthString): TPascalString; inline;
function Pascal2FixedLengthString(var S: TPascalString): FixedLengthString; inline;

function umlComparePosStr(const S: umlString; Offset: Integer; t: umlString): Boolean;
function umlPos(SubStr, Str: umlString; const Offset: Integer = 1): Integer;

function umlSameVarValue(const v1, v2: Variant): Boolean;

function umlRandomRange(aMin, aMax: Integer): Integer;
function umlRandomRangeF(aMin, aMax: Single): Single;
function umlRandomRangeD(aMin, aMax: Double): Double;
function umlDefaultTime: Double; inline;
function umlDefaultAttrib: Integer;
function umlBoolToStr(Value: Boolean): umlString;
function umlStrToBool(Value: umlString): Boolean;

function umlFileExists(FileName: umlString): Boolean;
function umlDirectoryExists(DirectoryName: umlString): Boolean;
function umlCreateDirectory(DirectoryName: umlString): Boolean;
function umlCurrentDirectory: umlString;
function umlCurrentPath: umlString;

function umlFindFirstFile(FileName: umlString; var SR: TSR): Boolean;
function umlFindNextFile(var SR: TSR): Boolean;
function umlFindFirstDir(DirName: umlString; var SR: TSR): Boolean;
function umlFindNextDir(var SR: TSR): Boolean;
procedure umlFindClose(var SR: TSR);

function umlGetFileList(FullPath: umlString; _AsList: TCoreClassStrings): Integer;
function umlGetDirList(FullPath: umlString; _AsList: TCoreClassStrings): Integer;

function umlGetFileListWithFullPath(FullPath: umlString): umlStringDynArray;
function umlGetDirListWithFullPath(FullPath: umlString): umlStringDynArray;

function umlCombinePath(s1, s2: umlString): umlString;
function umlCombineFileName(pathName, FileName: umlString): umlString;
function umlGetFileName(S: umlString): umlString;
function umlGetFilePath(S: umlString): umlString;
function umlChangeFileExt(S, ext: umlString): umlString;
function umlGetFileExt(S: umlString): umlString;

procedure InitIOHnd(var IOHnd: TIOHnd); inline;
function umlFileCreateAsStream(Name: umlString; Stream: TMixedStream; var IOHnd: TIOHnd): Boolean; inline;
function umlFileOpenAsStream(Name: umlString; Stream: TMixedStream; var IOHnd: TIOHnd; _OnlyRead: Boolean): Boolean; inline;
function umlFileCreate(Name: umlString; var IOHnd: TIOHnd): Boolean; inline;
function umlFileOpen(Name: umlString; var IOHnd: TIOHnd; _OnlyRead: Boolean): Boolean; inline;
function umlFileClose(var IOHnd: TIOHnd): Boolean; inline;
function umlFileUpdate(var IOHnd: TIOHnd): Boolean; inline;
function umlFileTest(var IOHnd: TIOHnd): Boolean; inline;

procedure umlResetPrepareRead(var IOHnd: TIOHnd); inline;
function umlFilePrepareRead(var IOHnd: TIOHnd; Size: Int64; var Buffers): Boolean; inline;
function umlFileRead(var IOHnd: TIOHnd; Size: Int64; var Buffers): Boolean; inline;

function umlFileBeginWrite(var IOHnd: TIOHnd): Boolean; inline;
function umlFileEndWrite(var IOHnd: TIOHnd): Boolean; inline;
function umlFileWrite(var IOHnd: TIOHnd; Size: Int64; var Buffers): Boolean; inline;

function umlFileWriteStr(var IOHnd: TIOHnd; var Value: umlString): Boolean; inline;
function umlFileReadStr(var IOHnd: TIOHnd; var Value: umlString): Boolean; inline;

function umlFileSeek(var IOHnd: TIOHnd; APos: Int64): Boolean; inline;
function umlFileGetPOS(var IOHnd: TIOHnd): Int64; inline;
function umlFileGetSize(var IOHnd: TIOHnd): Int64; inline;

function umlGetFileTime(FileName: umlString): TDateTime;
procedure umlSetFileTime(FileName: umlString; newTime: TDateTime);

function umlGetFileSize(FileName: umlString): Int64;

function umlGetFileCount(FileName: umlString): Integer;
function umlGetFileDateTime(FileName: umlString): TDateTime;
function umlDeleteFile(FileName: umlString; const _VerifyCheck: Boolean = False): Boolean;
function umlCopyFile(SourFile, DestFile: umlString): Boolean;
function umlRenameFile(OldName, NewName: umlString): Boolean;

{ umlString }
procedure umlSetLength(var aStr: umlString; NewStrLength: Integer); overload;
procedure umlSetLength(var aStr: umlBytes; NewStrLength: Integer); overload;
procedure umlSetLength(var aStr: umlArrayString; NewStrLength: Integer); overload;

function umlGetLength(aStr: umlString): Integer; overload;
function umlGetLength(var aStr: umlBytes): Integer; overload;
function umlGetLength(aStr: umlArrayString): Integer; overload;

function umlUpperCase(Str: umlString): umlString; inline;
function umlLowerCase(Str: umlString): umlString; inline;
function umlCopyStr(aStr: umlString; MainPosition, LastPosition: Integer): umlString; inline;
function umlSameText(s1, s2: umlString): Boolean; inline;

function umlGetStrIndexPos(IgnoreCase: Boolean; StartIndex: Integer; Str, SubStr: umlString): Integer;
function umlDeleteChar(_Text, _Char: umlString): umlString; overload;
function umlDeleteChar(_Text: umlString; const SomeCharsets: TOrdChars): umlString; overload;
function umlGetNumberCharInText(n: umlString): umlString;

function umlGetLimitCharPos(CharValue: umlChar; LimitValue: umlString): Integer; inline;
function umlMatchLimitChar(CharValue: umlChar; LimitValue: umlPString): Boolean; overload; inline;
function umlMatchLimitChar(CharValue: umlChar; LimitValue: umlString): Boolean; overload; inline;
function umlExistsLimitChar(StrValue: umlString; LimitValue: umlString): Boolean; inline;
function umlExistsChar(StrValue: umlString; LimitValue: umlString): Boolean; inline;
function umlDelLimitChar(StrValue: umlString; LimitValue: umlString): umlString; inline;
function umlGetLimitCharCount(StrValue: umlString; LimitValue: umlString): Integer; inline;
function umlTrimChar(S: umlString; SpaceStr: umlString): umlString; inline;

function umlGetFirstStr(aStr: umlString; SpaceStr: umlString): umlString; inline;
function umlGetLastStr(aStr: umlString; SpaceStr: umlString): umlString; inline;
function umlDeleteFirstStr(aStr: umlString; SpaceStr: umlString): umlString; inline;
function umlDeleteLastStr(aStr: umlString; SpaceStr: umlString): umlString; inline;
function umlGetIndexStrCount(aStr: umlString; SpaceStr: umlString): Integer; inline;
function umlGetIndexStr(aStr: umlString; SpaceStr: umlString; Index: Integer): umlString; inline;

procedure umlGetSplitArray(_SourText: umlString; var _DestArray: umlArrayString; _SplitChar: umlString); inline;
function umlArrayStringToText(var _Ary: umlArrayString; _SplitChar: umlString): umlString; inline;
function umlStringsToText(_List: TCoreClassStrings; _SplitChar: umlString): umlString; inline;

function umlGetFirstStr_M(aStr: umlString; SpaceStr: umlString): umlString;
function umlDeleteFirstStr_M(aStr: umlString; SpaceStr: umlString): umlString;
function umlGetLastStr_M(aStr: umlString; SpaceStr: umlString): umlString;
function umlDeleteLastStr_M(aStr: umlString; SpaceStr: umlString): umlString;
function umlGetIndexStrCount_M(aStr: umlString; SpaceStr: umlString): Integer;
function umlGetIndexStr_M(aStr: umlString; SpaceStr: umlString; Index: Integer): umlString;

function umlGetFirstTextPos(S: umlString; ATextList: array of umlString; var OutText: umlString): Integer;
function umlDeleteText(ASourText: umlString; ABeginFlag, AEndFlag: array of umlString; ANeedBegin, ANeedEnd: Boolean): umlString;
function umlGetTextContent(ASourText: umlString; ABeginFlag, AEndFlag: array of umlString): umlString;

type
  TTextType = (ntBool, ntInt, ntInt64, ntUInt64, ntWord, ntByte, ntSmallInt, ntShortInt, ntUInt,
    ntSingle, ntDouble, ntCurrency, ntUnknow);
  TTextTypes = set of TTextType;
function umlGetNumTextType(S: umlString): TTextType;

function umlIsHex(aStr: umlString): Boolean;
function umlIsNumber(aStr: umlString): Boolean;
function umlIsIntNumber(aStr: umlString): Boolean;
function umlIsFloatNumber(aStr: umlString): Boolean;
function umlIsBool(aStr: umlString): Boolean;
function umlNumberCount(aStr: umlString): Integer;

function umlPercentageToFloat(OriginMax, OriginMin, ProcressParameter: Double): Double;
function umlPercentageToInt(OriginParameter, ProcressParameter: Integer): Integer;
function umlPercentageToStr(OriginParameter, ProcressParameter: Integer): umlString;
function umlSmartSizeToStr(Size: Int64): umlString;
function umlIntToStr(Parameter: Double): umlString; overload;
function umlIntToStr(Parameter: Int64): umlString; overload;
function umlSizeToStr(Parameter: Int64): umlString;
function umlTimeToStr(TimeInteger: Integer): umlString;
function umlDateToStr(TimeInteger: Integer): umlString;
function umlFloatToStr(f: Double): umlString;

function umlStrToInt(_V: umlString): Integer; overload;
function umlStrToInt(_V: umlString; _Def: Integer): Integer; overload;
function umlStrToInt(_V: umlString; _Def: Double): Integer; overload;
function umlStrToFloat(_V: umlString; _Def: Double): Double; overload;

function umlMultipleMatch(IgnoreCase: Boolean; SourceStr, TargetStr, umlMultipleString, umlMultipleCharacter: umlString): Boolean; overload; inline;
function umlMultipleMatch(IgnoreCase: Boolean; SourceStr, TargetStr: umlString): Boolean; overload; inline;
function umlMultipleMatch(const SourceStr, TargetStr: umlString): Boolean; overload; inline;
function umlMultipleMatch(const ValueCheck: umlArrayString; Value: umlString): Boolean; overload; inline;
function umlSearchMatch(const SourceStr, TargetStr: umlString): Boolean; overload; inline;
function umlSearchMatch(ValueCheck: umlArrayString; Value: umlString): Boolean; overload; inline;

{ De Time Double Code }
function umlDeTimeCodeToStr(NowDateTime: TDateTime): umlString;

{ StringReplace replaces occurances of <oldpattern> with <newpattern> in a
  given umlString.  Assumes the umlString may contain Multibyte characters }
function umlStringReplace(S, OldPattern, NewPattern: umlString; IgnoreCase: Boolean): umlString;
function umlCharReplace(S: umlString; OldPattern, NewPattern: umlChar): umlString;

function umlEncodeText2HTML(psSrc: umlString): umlString;

procedure umlBase64EncodeBytes(var Sour, Dest: TBytes); overload;
procedure umlBase64EncodeBytes(var Sour: TBytes; var Dest: umlString); overload;

procedure umlBase64DecodeBytes(var Sour, Dest: TBytes); overload;
procedure umlBase64DecodeBytes(Sour: umlString; var Dest: TBytes); overload;

procedure umlDecodeLineBASE64(Buffer: umlString; var Output: umlString);
procedure umlEncodeLineBASE64(Buffer: umlString; var Output: umlString);
procedure umlDecodeStreamBASE64(Buffer: umlString; Output: TCoreClassStream);
procedure umlEncodeStreamBASE64(Buffer: TCoreClassStream; var Output: umlString);
procedure umlDivisionBase64Text(Buffer: umlString; width: Integer; DivisionAsPascalString: Boolean; var Output: umlString);

type
  PMD5 = ^TMD5;
  TMD5 = array [0 .. 15] of Byte;

const
  NullMD5: TMD5 = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

function umlMD5(const BuffPtr: PBYTE; const BuffSize: NativeUInt): TMD5;
function umlMD5Char(const BuffPtr: PBYTE; const BuffSize: NativeUInt): umlString;
function umlMD5String(const BuffPtr: PBYTE; const BuffSize: NativeUInt): umlString;
function umlStreamMD5(Stream: TCoreClassStream; StartPos, EndPos: Int64): TMD5; overload;
function umlStreamMD5(Stream: TCoreClassStream): TMD5; overload;
function umlStreamMD5Char(Stream: TCoreClassStream): umlString; overload;
function umlStreamMD5String(Stream: TCoreClassStream): umlString; overload;
function umlStringMD5(const Value: umlString): TMD5; overload;
function umlStringMD5Char(const Value: umlString): umlString; overload;
function umlMD52Str(md5: TMD5): umlString;
function umlMD52String(md5: TMD5): umlString;
function umlMD5Compare(const m1, m2: TMD5): Boolean; inline;
function umlCompareMD5(const m1, m2: TMD5): Boolean; inline;

const
  CRC16Table: array [0 .. 255] of Word = (
    $0000, $C0C1, $C181, $0140, $C301, $03C0, $0280, $C241, $C601, $06C0, $0780,
    $C741, $0500, $C5C1, $C481, $0440, $CC01, $0CC0, $0D80, $CD41, $0F00, $CFC1,
    $CE81, $0E40, $0A00, $CAC1, $CB81, $0B40, $C901, $09C0, $0880, $C841, $D801,
    $18C0, $1980, $D941, $1B00, $DBC1, $DA81, $1A40, $1E00, $DEC1, $DF81, $1F40,
    $DD01, $1DC0, $1C80, $DC41, $1400, $D4C1, $D581, $1540, $D701, $17C0, $1680,
    $D641, $D201, $12C0, $1380, $D341, $1100, $D1C1, $D081, $1040, $F001, $30C0,
    $3180, $F141, $3300, $F3C1, $F281, $3240, $3600, $F6C1, $F781, $3740, $F501,
    $35C0, $3480, $F441, $3C00, $FCC1, $FD81, $3D40, $FF01, $3FC0, $3E80, $FE41,
    $FA01, $3AC0, $3B80, $FB41, $3900, $F9C1, $F881, $3840, $2800, $E8C1, $E981,
    $2940, $EB01, $2BC0, $2A80, $EA41, $EE01, $2EC0, $2F80, $EF41, $2D00, $EDC1,
    $EC81, $2C40, $E401, $24C0, $2580, $E541, $2700, $E7C1, $E681, $2640, $2200,
    $E2C1, $E381, $2340, $E101, $21C0, $2080, $E041, $A001, $60C0, $6180, $A141,
    $6300, $A3C1, $A281, $6240, $6600, $A6C1, $A781, $6740, $A501, $65C0, $6480,
    $A441, $6C00, $ACC1, $AD81, $6D40, $AF01, $6FC0, $6E80, $AE41, $AA01, $6AC0,
    $6B80, $AB41, $6900, $A9C1, $A881, $6840, $7800, $B8C1, $B981, $7940, $BB01,
    $7BC0, $7A80, $BA41, $BE01, $7EC0, $7F80, $BF41, $7D00, $BDC1, $BC81, $7C40,
    $B401, $74C0, $7580, $B541, $7700, $B7C1, $B681, $7640, $7200, $B2C1, $B381,
    $7340, $B101, $71C0, $7080, $B041, $5000, $90C1, $9181, $5140, $9301, $53C0,
    $5280, $9241, $9601, $56C0, $5780, $9741, $5500, $95C1, $9481, $5440, $9C01,
    $5CC0, $5D80, $9D41, $5F00, $9FC1, $9E81, $5E40, $5A00, $9AC1, $9B81, $5B40,
    $9901, $59C0, $5880, $9841, $8801, $48C0, $4980, $8941, $4B00, $8BC1, $8A81,
    $4A40, $4E00, $8EC1, $8F81, $4F40, $8D01, $4DC0, $4C80, $8C41, $4400, $84C1,
    $8581, $4540, $8701, $47C0, $4680, $8641, $8201, $42C0, $4380, $8341, $4100,
    $81C1, $8081, $4040
    );

function umlCRC16(const Value: PBYTE; const Count: NativeUInt): Word; inline;
function umlStringCRC16(const Value: umlString): Word; inline;
function umlStreamCRC16(Stream: TMixedStream; StartPos, EndPos: Int64): Word; overload; inline;
function umlStreamCRC16(Stream: TMixedStream): Word; overload; inline;

const
  CRC32Table: array [0 .. 255] of Cardinal = (
    $00000000, $77073096, $EE0E612C, $990951BA, $076DC419, $706AF48F, $E963A535,
    $9E6495A3, $0EDB8832, $79DCB8A4, $E0D5E91E, $97D2D988, $09B64C2B, $7EB17CBD,
    $E7B82D07, $90BF1D91, $1DB71064, $6AB020F2, $F3B97148, $84BE41DE, $1ADAD47D,
    $6DDDE4EB, $F4D4B551, $83D385C7, $136C9856, $646BA8C0, $FD62F97A, $8A65C9EC,
    $14015C4F, $63066CD9, $FA0F3D63, $8D080DF5, $3B6E20C8, $4C69105E, $D56041E4,
    $A2677172, $3C03E4D1, $4B04D447, $D20D85FD, $A50AB56B, $35B5A8FA, $42B2986C,
    $DBBBC9D6, $ACBCF940, $32D86CE3, $45DF5C75, $DCD60DCF, $ABD13D59, $26D930AC,
    $51DE003A, $C8D75180, $BFD06116, $21B4F4B5, $56B3C423, $CFBA9599, $B8BDA50F,
    $2802B89E, $5F058808, $C60CD9B2, $B10BE924, $2F6F7C87, $58684C11, $C1611DAB,
    $B6662D3D, $76DC4190, $01DB7106, $98D220BC, $EFD5102A, $71B18589, $06B6B51F,
    $9FBFE4A5, $E8B8D433, $7807C9A2, $0F00F934, $9609A88E, $E10E9818, $7F6A0DBB,
    $086D3D2D, $91646C97, $E6635C01, $6B6B51F4, $1C6C6162, $856530D8, $F262004E,
    $6C0695ED, $1B01A57B, $8208F4C1, $F50FC457, $65B0D9C6, $12B7E950, $8BBEB8EA,
    $FCB9887C, $62DD1DDF, $15DA2D49, $8CD37CF3, $FBD44C65, $4DB26158, $3AB551CE,
    $A3BC0074, $D4BB30E2, $4ADFA541, $3DD895D7, $A4D1C46D, $D3D6F4FB, $4369E96A,
    $346ED9FC, $AD678846, $DA60B8D0, $44042D73, $33031DE5, $AA0A4C5F, $DD0D7CC9,
    $5005713C, $270241AA, $BE0B1010, $C90C2086, $5768B525, $206F85B3, $B966D409,
    $CE61E49F, $5EDEF90E, $29D9C998, $B0D09822, $C7D7A8B4, $59B33D17, $2EB40D81,
    $B7BD5C3B, $C0BA6CAD, $EDB88320, $9ABFB3B6, $03B6E20C, $74B1D29A, $EAD54739,
    $9DD277AF, $04DB2615, $73DC1683, $E3630B12, $94643B84, $0D6D6A3E, $7A6A5AA8,
    $E40ECF0B, $9309FF9D, $0A00AE27, $7D079EB1, $F00F9344, $8708A3D2, $1E01F268,
    $6906C2FE, $F762575D, $806567CB, $196C3671, $6E6B06E7, $FED41B76, $89D32BE0,
    $10DA7A5A, $67DD4ACC, $F9B9DF6F, $8EBEEFF9, $17B7BE43, $60B08ED5, $D6D6A3E8,
    $A1D1937E, $38D8C2C4, $4FDFF252, $D1BB67F1, $A6BC5767, $3FB506DD, $48B2364B,
    $D80D2BDA, $AF0A1B4C, $36034AF6, $41047A60, $DF60EFC3, $A867DF55, $316E8EEF,
    $4669BE79, $CB61B38C, $BC66831A, $256FD2A0, $5268E236, $CC0C7795, $BB0B4703,
    $220216B9, $5505262F, $C5BA3BBE, $B2BD0B28, $2BB45A92, $5CB36A04, $C2D7FFA7,
    $B5D0CF31, $2CD99E8B, $5BDEAE1D, $9B64C2B0, $EC63F226, $756AA39C, $026D930A,
    $9C0906A9, $EB0E363F, $72076785, $05005713, $95BF4A82, $E2B87A14, $7BB12BAE,
    $0CB61B38, $92D28E9B, $E5D5BE0D, $7CDCEFB7, $0BDBDF21, $86D3D2D4, $F1D4E242,
    $68DDB3F8, $1FDA836E, $81BE16CD, $F6B9265B, $6FB077E1, $18B74777, $88085AE6,
    $FF0F6A70, $66063BCA, $11010B5C, $8F659EFF, $F862AE69, $616BFFD3, $166CCF45,
    $A00AE278, $D70DD2EE, $4E048354, $3903B3C2, $A7672661, $D06016F7, $4969474D,
    $3E6E77DB, $AED16A4A, $D9D65ADC, $40DF0B66, $37D83BF0, $A9BCAE53, $DEBB9EC5,
    $47B2CF7F, $30B5FFE9, $BDBDF21C, $CABAC28A, $53B39330, $24B4A3A6, $BAD03605,
    $CDD70693, $54DE5729, $23D967BF, $B3667A2E, $C4614AB8, $5D681B02, $2A6F2B94,
    $B40BBE37, $C30C8EA1, $5A05DF1B, $2D02EF8D
    );

function umlCRC32(const Value: PBYTE; const Count: NativeUInt): Cardinal; inline;
function umlString2CRC32(const Value: umlString): Cardinal; inline;
function umlStreamCRC32(Stream: TMixedStream; StartPos, EndPos: Int64): Cardinal; overload; inline;
function umlStreamCRC32(Stream: TMixedStream): Cardinal; overload; inline;

type
  TDESKey = array [0 .. 7] of Byte;
  PDESKey = ^TDESKey;

const
  NullDES: TDESKey = (0, 0, 0, 0, 0, 0, 0, 0);

  { TRUE to encrypt, FALSE to decrypt }
procedure umlDES(const Input: TDESKey; var Output: TDESKey; const Key: TDESKey; Encrypt: Boolean); overload;
procedure umlDES(DataPtr: Pointer; Size: Cardinal; const Key: TDESKey; Encrypt: Boolean); overload;
procedure umlDES(DataPtr: Pointer; Size: Cardinal; const Key: umlString; Encrypt: Boolean); overload;
procedure umlDES(Input, Output: TMixedStream; const Key: TDESKey; Encrypt: Boolean); overload;
procedure umlDES(Input, Output: TMixedStream; const Key: umlString; Encrypt: Boolean); overload;
function umlDESCompare(const d1, d2: TDESKey): Boolean; inline;

procedure umlFastSymbol(DataPtr: Pointer; Size: Cardinal; const Key: TDESKey; Encrypt: Boolean); overload; inline;
procedure umlFastSymbol(DataPtr: Pointer; Size: Cardinal; const Key: umlString; Encrypt: Boolean); overload; inline;

function umlTrimSpace(S: umlString): umlString;

function umlSeparatorText(AText: umlString; Dest: TCoreClassStrings; SeparatorChar: umlString): Integer;
function umlStringsMatchText(OriginValue: TCoreClassStrings; DestValue: umlString; IgnoreCase: Boolean = True): Boolean;

function umlStringsInExists(Dest: TCoreClassStrings; _Text: umlString; IgnoreCase: Boolean = True): Boolean;
function umlTextInStrings(_Text: umlString; Dest: TCoreClassStrings; IgnoreCase: Boolean = True): Boolean;

function umlAddNewStrTo(SourceStr: umlString; Dest: TCoreClassStrings; IgnoreCase: Boolean = True): Boolean;
function umlDeleteStrings(_Text: umlString; Dest: TCoreClassStrings; IgnoreCase: Boolean = True): Integer;
function umlDeleteStringsNot(_Text: umlString; Dest: TCoreClassStrings; IgnoreCase: Boolean = True): Integer;
function umlMergeStrings(Source, Dest: TCoreClassStrings; IgnoreCase: Boolean = True): Integer;

function umlConverStrToFileName(Value: umlString): umlString;

function umlLimitTextMatch(_Text, _Limit, _MatchText: umlString; _IgnoreCase: Boolean): Boolean;
function umlLimitTextTrimSpaceMatch(_Text, _Limit, _MatchText: umlString; _IgnoreCase: Boolean): Boolean;
function umlLimitDeleteText(_Text, _Limit, _MatchText: umlString; _IgnoreCase: Boolean): umlString;
function umlLimitTextAsList(_Text, _Limit: umlString; _AsList: TCoreClassStrings): Boolean;
function umlLimitTextAsListAndTrimSpace(_Text, _Limit: umlString; _AsList: TCoreClassStrings): Boolean;
function umlListAsLimitText(_List: TCoreClassStrings; _Limit: umlString): umlString;

function umlUpdateComponentName(Name: umlString): umlString;
function umlMakeComponentName(OWner: TCoreClassComponent; RefrenceName: umlString): umlString;

procedure umlReadComponent(Stream: TCoreClassStream; comp: TCoreClassComponent);
procedure umlWriteComponent(Stream: TCoreClassStream; comp: TCoreClassComponent);
procedure umlCopyComponentDataTo(comp, copyto: TCoreClassComponent);

function umlProcessCycleValue(CurrentVal, DeltaVal, StartVal, OverVal: Single; var EndFlag: Boolean): Single;

implementation

uses MemoryStream64;

function umlBytesOf(S: umlString): TBytes;
begin
  Result := BytesOfPascalString(S);
end;

function umlStringOf(S: TBytes): umlString;
begin
  Result := PascalStringOfBytes(S);
end;

function FixedLengthString2Pascal(var S: FixedLengthString): TPascalString;
var
  B: TBytes;
begin
  SetLength(B, FixedLengthStringSize);
  move(S.Data, B[0], FixedLengthStringSize);
  SetLength(B, S.len);
  Result.Bytes := B;
  SetLength(B, 0);
end;

function Pascal2FixedLengthString(var S: TPascalString): FixedLengthString;
var
  bb: TBytes;
begin
  bb := S.Bytes;
  Result.len := Length(bb);
  if Result.len > FixedLengthStringSize then
      Result.len := FixedLengthStringSize
  else
      FillByte(Result.Data[0], FixedLengthStringSize, 0);
  move(bb[0], Result.Data[0], Result.len);
end;

function umlComparePosStr(const S: umlString; Offset: Integer; t: umlString): Boolean;
begin
  Result := S.ComparePos(Offset, @t);
end;

function umlPos(SubStr, Str: umlString; const Offset: Integer = 1): Integer;
begin
  Result := Str.GetPos(SubStr, Offset);
end;

function umlSameVarValue(const v1, v2: Variant): Boolean;
begin
  try
      Result := VarSameValue(v1, v2);
  except
      Result := False;
  end;
end;

function umlRandomRange(aMin, aMax: Integer): Integer;
begin
  if aMin > aMax then
      Inc(aMin)
  else
      Inc(aMax);

  if aMin > aMax then
      Result := Random(aMin - aMax) + aMax
  else
      Result := Random(aMax - aMin) + aMin;
end;

function umlRandomRangeF(aMin, aMax: Single): Single;
begin
  Result := (umlRandomRange(Trunc(aMin * 1000), Trunc(aMax * 1000))) * 0.001;
end;

function umlRandomRangeD(aMin, aMax: Double): Double;
begin
  Result := (umlRandomRange(Trunc(aMin * 10000), Trunc(aMax * 10000))) * 0.0001;
end;

function umlDefaultTime: Double;
begin
  Result := Now;
end;

function umlDefaultAttrib: Integer;
begin
  Result := 0;
end;

function umlBoolToStr(Value: Boolean): umlString;
begin
  if Value then
      Result := 'YES'
  else
      Result := 'NO';
end;

function umlStrToBool(Value: umlString): Boolean;
var
  NewValue: umlString;
begin
  NewValue := umlUpperCase(Value);
  if NewValue = 'YES' then
      Result := True
  else if NewValue = 'NO' then
      Result := False
  else if NewValue = 'TRUE' then
      Result := True
  else if NewValue = 'FALSE' then
      Result := False
  else if NewValue = '1' then
      Result := True
  else if NewValue = '0' then
      Result := False
  else
      Result := False;
end;

function umlFileExists(FileName: umlString): Boolean;
begin
  if FileName.len > 0 then
      Result := FileExists(FileName.Text)
  else
      Result := False;
end;

function umlDirectoryExists(DirectoryName: umlString): Boolean;
begin
  Result := DirectoryExists(DirectoryName.Text);
end;

function umlCreateDirectory(DirectoryName: umlString): Boolean;
begin
  Result := umlDirectoryExists(DirectoryName);
  if not Result then
      Result := ForceDirectories(DirectoryName.Text);
end;

function umlCurrentDirectory: umlString;
begin
  Result.Text := GetCurrentDir;
end;

function umlCurrentPath: umlString;
begin
  Result.Text := GetCurrentDir;
  case CurrentPlatform of
    epWin32, epWin64: if (Result.len = 0) or (Result.Last <> '\') then
          Result := Result.Text + '\';
    else
      if (Result.len = 0) or (Result.Last <> '/') then
          Result := Result.Text + '/';
  end;
end;

function umlFindFirstFile(FileName: umlString; var SR: TSR): Boolean;
label SearchPoint;
begin
  if FindFirst(FileName.Text, faAnyFile, SR) <> 0 then
    begin
      Result := False;
      Exit;
    end;
  if ((SR.Attr and faDirectory) <> faDirectory) then
    begin
      Result := True;
      Exit;
    end;
SearchPoint:
  if FindNext(SR) <> 0 then
    begin
      Result := False;
      Exit;
    end;
  if ((SR.Attr and faDirectory) <> faDirectory) then
    begin
      Result := True;
      Exit;
    end;
  goto SearchPoint;
end;

function umlFindNextFile(var SR: TSR): Boolean;
label SearchPoint;
begin
SearchPoint:
  if FindNext(SR) <> 0 then
    begin
      Result := False;
      Exit;
    end;
  if ((SR.Attr and faDirectory) <> faDirectory) then
    begin
      Result := True;
      Exit;
    end;
  goto SearchPoint;
end;

function umlFindFirstDir(DirName: umlString; var SR: TSR): Boolean;
label SearchPoint;
begin
  if FindFirst(DirName.Text, faAnyFile, SR) <> 0 then
    begin
      Result := False;
      Exit;
    end;
  if ((SR.Attr and faDirectory) = faDirectory) and (SR.Name <> '.') and (SR.Name <> '..') then
    begin
      Result := True;
      Exit;
    end;
SearchPoint:
  if FindNext(SR) <> 0 then
    begin
      Result := False;
      Exit;
    end;
  if ((SR.Attr and faDirectory) = faDirectory) and (SR.Name <> '.') and (SR.Name <> '..') then
    begin
      Result := True;
      Exit;
    end;
  goto SearchPoint;
end;

function umlFindNextDir(var SR: TSR): Boolean;
label SearchPoint;
begin
SearchPoint:
  if FindNext(SR) <> 0 then
    begin
      Result := False;
      Exit;
    end;
  if ((SR.Attr and faDirectory) = faDirectory) and (SR.Name <> '.') and (SR.Name <> '..') then
    begin
      Result := True;
      Exit;
    end;
  goto SearchPoint;
end;

procedure umlFindClose(var SR: TSR);
begin
  FindClose(SR);
end;

function umlGetFileList(FullPath: umlString; _AsList: TCoreClassStrings): Integer;
var
  _SR: TSR;
begin
  Result := 0;
  if umlFindFirstFile(umlCombineFileName(FullPath, '*'), _SR) then
    begin
      repeat
        _AsList.Add(_SR.Name);
        Inc(Result);
      until not umlFindNextFile(_SR);
    end;
  umlFindClose(_SR);
end;

function umlGetDirList(FullPath: umlString; _AsList: TCoreClassStrings): Integer;
var
  _SR: TSR;
begin
  Result := 0;
  if umlFindFirstDir(umlCombineFileName(FullPath, '*'), _SR) then
    begin
      repeat
        _AsList.Add(_SR.Name);
        Inc(Result);
      until not umlFindNextDir(_SR);
    end;
  umlFindClose(_SR);
end;

function umlGetFileListWithFullPath(FullPath: umlString): umlStringDynArray;
var
  ph: umlString;
  ns: TCoreClassStrings;
  i : Integer;
begin
  ph := FullPath;
  ns := TCoreClassStringList.Create;
  umlGetFileList(FullPath, ns);
  SetLength(Result, ns.Count);
  for i := 0 to ns.Count - 1 do
      Result[i] := umlCombineFileName(ph, ns[i]).Text;
  DisposeObject(ns);
end;

function umlGetDirListWithFullPath(FullPath: umlString): umlStringDynArray;
var
  ph: umlString;
  ns: TCoreClassStrings;
  i : Integer;
begin
  ph := FullPath;
  ns := TCoreClassStringList.Create;
  umlGetDirList(FullPath, ns);
  SetLength(Result, ns.Count);
  for i := 0 to ns.Count - 1 do
      Result[i] := umlCombinePath(ph, ns[i]).Text;
  DisposeObject(ns);
end;

function umlCombinePath(s1, s2: umlString): umlString;
var
  n: umlString;
begin
  s1 := umlTrimSpace(s1);
  s2 := umlTrimSpace(s2);
  case CurrentPlatform of
    epWin32, epWin64:
      begin
        s1 := umlCharReplace(s1, '/', '\');
        s2 := umlCharReplace(s2, '/', '\');

        if (s2.len > 0) and (s2.First = '\') then
            s2.DeleteFirst;

        if s1.len > 0 then
          begin
            if s1.Last = '\' then
                Result := s1.Text + s2.Text
            else
                Result := s1.Text + '\' + s2.Text;
          end
        else
            Result := s2;

        repeat
          n := Result;
          Result := umlStringReplace(Result, '\\', '\', True);
        until Result.Same(n);
        if (Result.len > 0) and (Result.Last <> '\') then
            Result.Append('\');
      end;
    else
      begin
        s1 := umlCharReplace(s1, '\', '/');
        s2 := umlCharReplace(s2, '\', '/');

        if (s2.len > 0) and (s2.First = '/') then
            s2.DeleteFirst;

        if s1.len > 0 then
          begin
            if s1.Last = '/' then
                Result := s1.Text + s2.Text
            else
                Result := s1.Text + '/' + s2.Text;
          end
        else
            Result := s2;

        repeat
          n := Result;
          Result := umlStringReplace(Result, '//', '/', True);
        until Result.Same(n);
        if (Result.len > 0) and (Result.Last <> '/') then
            Result.Append('/');
      end;
  end;
end;

function umlCombineFileName(pathName, FileName: umlString): umlString;
var
  n: umlString;
begin
  pathName := umlTrimSpace(pathName);
  FileName := umlTrimSpace(FileName);
  case CurrentPlatform of
    epWin32, epWin64:
      begin
        pathName := umlCharReplace(pathName, '/', '\');
        FileName := umlCharReplace(FileName, '/', '\');

        if (FileName.len > 0) and (FileName.First = '\') then
            FileName.DeleteFirst;
        if (FileName.len > 0) and (FileName.Last = '\') then
            FileName.DeleteLast;

        if pathName.len > 0 then
          begin
            if pathName.Last = '\' then
                Result := pathName.Text + FileName.Text
            else
                Result := pathName.Text + '\' + FileName.Text;
          end
        else
            Result := FileName;

        repeat
          n := Result;
          Result := umlStringReplace(Result, '\\', '\', True);
        until Result.Same(n);

        if Result.Last = '\' then
            Result.Delete(Result.len, 1);
      end;
    else
      begin
        pathName := umlCharReplace(pathName, '\', '/');
        FileName := umlCharReplace(FileName, '\', '/');

        if (FileName.len > 0) and (FileName.First = '/') then
            FileName.DeleteFirst;
        if (FileName.len > 0) and (FileName.Last = '/') then
            FileName.DeleteLast;

        if pathName.len > 0 then
          begin
            if pathName.Last = '/' then
                Result := pathName.Text + FileName.Text
            else
                Result := pathName.Text + '/' + FileName.Text;
          end
        else
            Result := FileName;

        repeat
          n := Result;
          Result := umlStringReplace(Result, '//', '/', True);
        until Result.Same(n);
      end;
  end;
end;

function umlGetFileName(S: umlString): umlString;
begin
  S := umlTrimSpace(S);
  case CurrentPlatform of
    epWin32, epWin64:
      begin
        S := umlCharReplace(S, '/', '\');
        if S.Exists('\') then
            Result := umlGetLastStr(S, '\')
        else
            Result := S;
      end;
    else
      begin
        S := umlCharReplace(S, '\', '/');
        if S.Exists('/') then
            Result := umlGetLastStr(S, '/')
        else
            Result := S;
      end;
  end;
end;

function umlGetFilePath(S: umlString): umlString;
begin
  S := umlTrimSpace(S);
  case CurrentPlatform of
    epWin32, epWin64:
      begin
        S := umlCharReplace(S, '/', '\');
        if (S.Last <> '\') and (S.Exists('\')) then
            Result := umlDeleteLastStr(S, '\')
        else
            Result := S;
      end;
    else
      begin
        S := umlCharReplace(S, '\', '/');
        if (S.Last <> '/') and (S.Exists('/')) then
            Result := umlDeleteLastStr(S, '/')
        else
            Result := S;
      end;
  end;
end;

function umlChangeFileExt(S, ext: umlString): umlString;
begin
  if (ext.len > 0) and (ext.First <> '.') then
      ext.Text := '.' + ext.Text;
  if umlExistsLimitChar(S, '.') then
      Result := umlDeleteLastStr(S, '.') + ext
  else
      Result := S + ext;
end;

function umlGetFileExt(S: umlString): umlString;
begin
  if umlExistsLimitChar(S, '.') then
      Result := '.' + umlGetLastStr(S, '.')
  else
      Result := '';
end;

procedure InitIOHnd(var IOHnd: TIOHnd);
begin
  IOHnd.IsOnlyRead := True;
  IOHnd.OpenFlags := False;
  IOHnd.AutoFree := False;
  IOHnd.Handle := nil;
  IOHnd.Time := 0;
  IOHnd.Attrib := 0;
  IOHnd.Size := 0;
  IOHnd.Position := 0;
  IOHnd.Name := '';
  IOHnd.FlushBuff := nil;
  IOHnd.PrepareReadPosition := -1;
  IOHnd.PrepareReadBuff := nil;
  IOHnd.WriteFlag := False;
  IOHnd.Data := nil;
  IOHnd.Return := umlNotError;
end;

function umlFileCreateAsStream(Name: umlString; Stream: TMixedStream; var IOHnd: TIOHnd): Boolean;
begin
  if IOHnd.OpenFlags = True then
    begin
      IOHnd.Return := umlFileIsActive;
      Result := False;
      Exit;
    end;
  Stream.Position := 0;
  IOHnd.Handle := Stream;
  IOHnd.Return := umlNotError;
  IOHnd.Size := 0;
  IOHnd.Position := 0;
  IOHnd.Time := umlDefaultTime;
  IOHnd.Attrib := umlDefaultAttrib;
  IOHnd.Name := name;
  IOHnd.OpenFlags := True;
  IOHnd.IsOnlyRead := False;
  IOHnd.AutoFree := False;
  Result := True;
end;

function umlFileOpenAsStream(Name: umlString; Stream: TMixedStream; var IOHnd: TIOHnd; _OnlyRead: Boolean): Boolean;
begin
  if IOHnd.OpenFlags = True then
    begin
      IOHnd.Return := umlFileIsActive;
      Result := False;
      Exit;
    end;
  Stream.Position := 0;
  IOHnd.Handle := Stream;
  IOHnd.IsOnlyRead := _OnlyRead;
  IOHnd.Return := umlNotError;
  IOHnd.Size := Stream.Size;
  IOHnd.Position := 0;
  IOHnd.Time := umlDefaultTime;
  IOHnd.Attrib := 0;
  IOHnd.Name := name;
  IOHnd.OpenFlags := True;
  IOHnd.AutoFree := False;
  Result := True;
end;

function umlFileCreate(Name: umlString; var IOHnd: TIOHnd): Boolean;
begin
  if IOHnd.OpenFlags = True then
    begin
      IOHnd.Return := umlFileIsActive;
      Result := False;
      Exit;
    end;
  try
      IOHnd.Handle := TCoreClassFileStream.Create(name.Text, fmCreate);
  except
    IOHnd.Handle := nil;
    IOHnd.Return := umlCreateFileError;
    Result := False;
    Exit;
  end;
  IOHnd.Return := umlNotError;
  IOHnd.Size := 0;
  IOHnd.Position := 0;
  IOHnd.Time := Now;
  IOHnd.Attrib := umlDefaultAttrib;
  IOHnd.Name := name;
  IOHnd.OpenFlags := True;
  IOHnd.IsOnlyRead := False;
  IOHnd.AutoFree := True;
  Result := True;
end;

function umlFileOpen(Name: umlString; var IOHnd: TIOHnd; _OnlyRead: Boolean): Boolean;
var
  SR: TSR;
begin
  if IOHnd.OpenFlags = True then
    begin
      IOHnd.Return := umlFileIsActive;
      Result := False;
      Exit;
    end;
  if umlFindFirstFile(name, SR) = False then
    begin
      IOHnd.Return := umlNotFindFile;
      Result := False;
      umlFindClose(SR);
      Exit;
    end;
  try
    if _OnlyRead then
        IOHnd.Handle := TCoreClassFileStream.Create(name.Text, fmOpenRead or fmShareDenyWrite)
    else
        IOHnd.Handle := TCoreClassFileStream.Create(name.Text, fmOpenReadWrite);
  except
    IOHnd.Handle := nil;
    IOHnd.Return := umlOpenFileError;
    Result := False;
    umlFindClose(SR);
    Exit;
  end;
  IOHnd.IsOnlyRead := _OnlyRead;
  IOHnd.Return := umlNotError;
  IOHnd.Size := SR.Size;
  IOHnd.Position := 0;
  if not FileAge(name.Text, IOHnd.Time) then
      IOHnd.Time := Now;
  IOHnd.Attrib := SR.Attr;
  IOHnd.Name := name;
  IOHnd.OpenFlags := True;
  IOHnd.AutoFree := True;
  Result := True;
  umlFindClose(SR);
end;

function umlFileClose(var IOHnd: TIOHnd): Boolean;
begin
  if IOHnd.OpenFlags = False then
    begin
      IOHnd.Return := umlNotOpenFile;
      Result := False;
      Exit;
    end;
  if IOHnd.Handle = nil then
    begin
      IOHnd.Return := umlFileHandleError;
      Result := False;
      Exit;
    end;

  umlFileEndWrite(IOHnd);

  if IOHnd.PrepareReadBuff <> nil then
      DisposeObject(IOHnd.PrepareReadBuff);
  IOHnd.PrepareReadBuff := nil;
  IOHnd.PrepareReadPosition := -1;

  try
    if IOHnd.AutoFree then
        DisposeObject(IOHnd.Handle)
    else
        IOHnd.Handle := nil;
  except
  end;
  IOHnd.Handle := nil;
  IOHnd.Return := umlNotError;
  IOHnd.Time := umlDefaultTime;
  IOHnd.Attrib := umlDefaultAttrib;
  IOHnd.Name := '';
  IOHnd.OpenFlags := False;
  IOHnd.WriteFlag := False;
  Result := True;
end;

function umlFileUpdate(var IOHnd: TIOHnd): Boolean;
begin
  if (IOHnd.OpenFlags = False) or (IOHnd.Handle = nil) then
    begin
      IOHnd.Return := umlFileHandleError;
      Result := False;
      Exit;
    end;

  umlFileEndWrite(IOHnd);
  umlResetPrepareRead(IOHnd);
  IOHnd.WriteFlag := False;

  Result := True;
end;

function umlFileTest(var IOHnd: TIOHnd): Boolean;
begin
  if (IOHnd.OpenFlags = False) or (IOHnd.Handle = nil) then
    begin
      IOHnd.Return := umlFileHandleError;
      Result := False;
      Exit;
    end;
  IOHnd.Return := umlNotError;
  Result := True;
end;

procedure umlResetPrepareRead(var IOHnd: TIOHnd);
begin
  if IOHnd.PrepareReadBuff <> nil then
      DisposeObject(IOHnd.PrepareReadBuff);
  IOHnd.PrepareReadBuff := nil;
  IOHnd.PrepareReadPosition := -1;
end;

function umlFilePrepareRead(var IOHnd: TIOHnd; Size: Int64; var Buffers): Boolean;
var
  m64      : TMemoryStream64;
  preRedSiz: Int64;
begin
  Result := False;

  if not IOHnd.Handle.InheritsFrom(TCoreClassFileStream) then
      Exit;

  if Size > PrepareReadCacheSize then
    begin
      umlResetPrepareRead(IOHnd);
      IOHnd.Handle.Position := IOHnd.Position;
      Exit;
    end;

  if IOHnd.PrepareReadBuff = nil then
      IOHnd.PrepareReadBuff := TMemoryStream64.Create;

  m64 := TMemoryStream64(IOHnd.PrepareReadBuff);

  if (IOHnd.Position < IOHnd.PrepareReadPosition) or (IOHnd.PrepareReadPosition + m64.Size < IOHnd.Position + Size) then
    begin
      // prepare read buffer
      IOHnd.Handle.Position := IOHnd.Position;
      IOHnd.PrepareReadPosition := IOHnd.Position;

      m64.Clear;
      IOHnd.PrepareReadPosition := IOHnd.Handle.Position;
      if IOHnd.Handle.Size - IOHnd.Handle.Position >= PrepareReadCacheSize then
        begin
          Result := m64.CopyFrom(IOHnd.Handle, PrepareReadCacheSize) = PrepareReadCacheSize;
        end
      else
        begin
          preRedSiz := IOHnd.Handle.Size - IOHnd.Handle.Position;
          Result := m64.CopyFrom(IOHnd.Handle, preRedSiz) = preRedSiz;
        end;
    end;

  if (IOHnd.Position >= IOHnd.PrepareReadPosition) and (IOHnd.PrepareReadPosition + m64.Size >= IOHnd.Position + Size) then
    begin
      move(Pointer(NativeUInt(m64.Memory) + (IOHnd.Position - IOHnd.PrepareReadPosition))^, Buffers, Size);
      Inc(IOHnd.Position, Size);
      Result := True;
    end
  else
    begin
      // safe process
      umlResetPrepareRead(IOHnd);
      IOHnd.Handle.Position := IOHnd.Position;
      Exit;
    end;
end;

function umlFileRead(var IOHnd: TIOHnd; Size: Int64; var Buffers): Boolean;
var
  BuffPointer: Pointer;
  i          : NativeInt;
  BuffInt    : NativeUInt;
begin
  if not umlFileEndWrite(IOHnd) then
    begin
      Result := False;
      Exit;
    end;

  if Size = 0 then
    begin
      IOHnd.Return := umlNotError;
      Result := True;
      Exit;
    end;

  if umlFilePrepareRead(IOHnd, Size, Buffers) then
    begin
      IOHnd.Return := umlNotError;
      Result := True;
      Exit;
    end;

  try
    if Size > umlMaxFileRecSize then
      begin
        // process Chunk buffer
        BuffInt := NativeUInt(@Buffers);
        BuffPointer := Pointer(BuffInt);
        for i := 1 to (Size div umlMaxFileRecSize) do
          begin
            if IOHnd.Handle.Read(BuffPointer^, umlMaxFileRecSize) <> umlMaxFileRecSize then
              begin
                IOHnd.Return := umlFileReadError;
                Result := False;
                Exit;
              end;
            BuffInt := BuffInt + umlMaxFileRecSize;
            BuffPointer := Pointer(BuffInt);
          end;
        // process buffer rest
        i := Size mod umlMaxFileRecSize;
        if IOHnd.Handle.Read(BuffPointer^, i) <> i then
          begin
            IOHnd.Return := umlFileReadError;
            Result := False;
            Exit;
          end;
        Inc(IOHnd.Position, Size);
        IOHnd.Return := umlNotError;
        Result := True;
        Exit;
      end;
    if IOHnd.Handle.Read(Buffers, Size) <> Size then
      begin
        IOHnd.Return := umlFileReadError;
        Result := False;
        Exit;
      end;
    Inc(IOHnd.Position, Size);
    IOHnd.Return := umlNotError;
    Result := True;
  except
    IOHnd.Return := umlFileReadError;
    Result := False;
  end;
end;

function umlFileBeginWrite(var IOHnd: TIOHnd): Boolean;
begin
  Result := True;

  if not umlFileTest(IOHnd) then
      Exit;

  if IOHnd.FlushBuff <> nil then
      Exit;

  if IOHnd.Handle is TCoreClassFileStream then
      IOHnd.FlushBuff := TMemoryStream64.Create;
end;

function umlFileEndWrite(var IOHnd: TIOHnd): Boolean;
var
  m64: TMemoryStream64;
begin
  if IOHnd.FlushBuff <> nil then
    begin
      m64 := TMemoryStream64(IOHnd.FlushBuff);
      IOHnd.FlushBuff := nil;

      if IOHnd.Handle.Write(m64.Memory^, m64.Size) <> m64.Size then
        begin
          IOHnd.Return := umlFileWriteError;
          Result := False;
          Exit;
        end;
      DisposeObject(m64);
    end;
  Result := True;
end;

function umlFileWrite(var IOHnd: TIOHnd; Size: Int64; var Buffers): Boolean;
var
  BuffPointer: Pointer;
  i          : NativeInt;
  BuffInt    : NativeUInt;
begin
  if (IOHnd.IsOnlyRead) or (not IOHnd.OpenFlags) then
    begin
      IOHnd.Return := umlFileWriteError;
      Result := False;
      Exit;
    end;
  if Size = 0 then
    begin
      IOHnd.Return := umlNotError;
      Result := True;
      Exit;
    end;

  IOHnd.WriteFlag := True;

  umlResetPrepareRead(IOHnd);

  if Size <= $F000 then
      umlFileBeginWrite(IOHnd);

  if IOHnd.FlushBuff <> nil then
    begin
      if TMemoryStream64(IOHnd.FlushBuff).Write64(Buffers, Size) <> Size then
        begin
          IOHnd.Return := umlFileWriteError;
          Result := False;
          Exit;
        end;

      Inc(IOHnd.Position, Size);
      if IOHnd.Position > IOHnd.Size then
          IOHnd.Size := IOHnd.Position;
      IOHnd.Return := umlNotError;
      Result := True;
      Exit;
    end;

  try
    if Size > umlMaxFileRecSize then
      begin
        // process buffer chunk
        BuffInt := NativeUInt(@Buffers);
        BuffPointer := Pointer(BuffInt);
        for i := 1 to (Size div umlMaxFileRecSize) do
          begin
            if IOHnd.Handle.Write(BuffPointer^, umlMaxFileRecSize) <> umlMaxFileRecSize then
              begin
                IOHnd.Return := umlFileWriteError;
                Result := False;
                Exit;
              end;
            BuffInt := BuffInt + umlMaxFileRecSize;
            BuffPointer := Pointer(BuffInt);
          end;
        // process buffer rest
        i := Size mod umlMaxFileRecSize;
        if IOHnd.Handle.Write(BuffPointer^, i) <> i then
          begin
            IOHnd.Return := umlFileWriteError;
            Result := False;
            Exit;
          end;

        Inc(IOHnd.Position, Size);
        if IOHnd.Position > IOHnd.Size then
            IOHnd.Size := IOHnd.Position;
        IOHnd.Return := umlNotError;
        Result := True;
        Exit;
      end;
    if IOHnd.Handle.Write(Buffers, Size) <> Size then
      begin
        IOHnd.Return := umlFileWriteError;
        Result := False;
        Exit;
      end;

    Inc(IOHnd.Position, Size);
    if IOHnd.Position > IOHnd.Size then
        IOHnd.Size := IOHnd.Position;
    IOHnd.Return := umlNotError;
    Result := True;
  except
    IOHnd.Return := umlFileWriteError;
    Result := False;
  end;
end;

function umlFileWriteStr(var IOHnd: TIOHnd; var Value: umlString): Boolean;
var
  buff: FixedLengthString;
begin
  buff := Pascal2FixedLengthString(Value);
  if umlFileWrite(IOHnd, FixedLengthStringSize + FixedLengthStringHeaderSize, buff) = False then
    begin
      IOHnd.Return := umlFileWriteError;
      Result := False;
      Exit;
    end;

  IOHnd.Return := umlNotError;
  Result := True;
end;

function umlFileReadStr(var IOHnd: TIOHnd; var Value: umlString): Boolean;
var
  buff: FixedLengthString;
begin
  try
    if umlFileRead(IOHnd, FixedLengthStringSize + FixedLengthStringHeaderSize, buff) = False then
      begin
        IOHnd.Return := umlFileReadError;
        Result := False;
        Exit;
      end;
    Value := FixedLengthString2Pascal(buff);
  except
      Value.Text := '';
  end;

  IOHnd.Return := umlNotError;
  Result := True;
end;

function umlFileSeek(var IOHnd: TIOHnd; APos: Int64): Boolean;
begin
  if (APos <> IOHnd.Position) or (APos <> IOHnd.Handle.Position) then
    if not umlFileEndWrite(IOHnd) then
      begin
        Result := False;
        Exit;
      end;

  IOHnd.Return := umlSeekError;
  Result := False;
  try
    IOHnd.Position := IOHnd.Handle.Seek(APos, TSeekOrigin.soBeginning);
    Result := IOHnd.Position <> -1;
    if Result then
        IOHnd.Return := umlNotError;
  except
  end;
end;

function umlFileGetPOS(var IOHnd: TIOHnd): Int64;
begin
  if (IOHnd.OpenFlags = False) or (IOHnd.Handle = nil) then
    begin
      IOHnd.Return := umlFileHandleError;
      Result := umlFileHandleError;
      Exit;
    end;
  try
      Result := IOHnd.Position;
  except
    IOHnd.Return := umlFileHandleError;
    Result := umlFileHandleError;
  end;
end;

function umlFileGetSize(var IOHnd: TIOHnd): Int64;
begin
  if (IOHnd.OpenFlags = False) or (IOHnd.Handle = nil) then
    begin
      IOHnd.Return := umlFileHandleError;
      Result := 0;
      Exit;
    end;
  Result := IOHnd.Size;
end;

function umlGetFileTime(FileName: umlString): TDateTime;
var
  f: THandle;
begin
  f := FileOpen(FileName.Text, fmOpenRead or fmShareDenyWrite);
  if f = THandle(-1) then
      Result := Now
  else
    begin
      Result := FileDateToDateTime(FileGetDate(f));
      FileClose(f);
    end;
end;

procedure umlSetFileTime(FileName: umlString; newTime: TDateTime);
begin
  FileSetDate(FileName.Text, DateTimeToFileDate(newTime));
end;

function umlGetFileSize(FileName: umlString): Int64;
var
  SR: TSR;
begin
  Result := 0;
  if umlFindFirstFile(FileName, SR) = True then
    begin
      Result := SR.Size;
      while umlFindNextFile(SR) = True do
          Result := Result + SR.Size;
    end;
  umlFindClose(SR);
end;

function umlGetFileCount(FileName: umlString): Integer;
var
  SR: TSR;
begin
  Result := 0;
  if umlFindFirstFile(FileName, SR) = True then
    begin
      Result := Result + 1;
      while umlFindNextFile(SR) = True do
          Result := Result + 1;
    end;
  umlFindClose(SR);
end;

function umlGetFileDateTime(FileName: umlString): TDateTime;
begin
  if not FileAge(FileName.Text, Result, False) then
      Result := Now;
end;

function umlDeleteFile(FileName: umlString; const _VerifyCheck: Boolean = False): Boolean;
var
  _SR: TSR;
begin
  if umlExistsLimitChar(FileName, '*?') then
    begin
      if umlFindFirstFile(FileName, _SR) then
        begin
          repeat
            try
                DeleteFile(umlCombineFileName(FileName, _SR.Name).Text);
            except
            end;
          until not umlFindNextFile(_SR);
        end;
      umlFindClose(_SR);
      Result := True;
    end
  else
    begin
      try
          Result := DeleteFile(FileName.Text);
      except
          Result := False;
      end;
      if Result and _VerifyCheck then
          Result := not umlFileExists(FileName)
      else
          Result := True;
    end;
end;

function umlCopyFile(SourFile, DestFile: umlString): Boolean;
var
  _SH, _DH: TCoreClassFileStream;
begin
  Result := False;
  _SH := nil;
  _DH := nil;
  try
    if not umlFileExists(SourFile) then
        Exit;
    if umlMultipleMatch(True, ExpandFileName(SourFile.Text), ExpandFileName(DestFile.Text)) then
        Exit;
    _SH := TCoreClassFileStream.Create(SourFile.Text, fmOpenRead or fmShareDenyWrite);
    _DH := TCoreClassFileStream.Create(DestFile.Text, fmCreate);
    Result := _DH.CopyFrom(_SH, _SH.Size) = _SH.Size;
    DisposeObject(_SH);
    DisposeObject(_DH);
    umlSetFileTime(DestFile, umlGetFileTime(SourFile));
  except
    if _SH <> nil then
        DisposeObject(_SH);
    if _DH <> nil then
        DisposeObject(_DH);
  end;
end;

function umlRenameFile(OldName, NewName: umlString): Boolean;
begin
  Result := RenameFile(OldName.Text, NewName.Text);
end;

procedure umlSetLength(var aStr: umlString; NewStrLength: Integer);
begin
  aStr.len := NewStrLength;
end;

procedure umlSetLength(var aStr: umlBytes; NewStrLength: Integer);
begin
  SetLength(aStr, NewStrLength);
end;

procedure umlSetLength(var aStr: umlArrayString; NewStrLength: Integer);
begin
  SetLength(aStr, NewStrLength);
end;

function umlGetLength(aStr: umlString): Integer;
begin
  Result := aStr.len;
end;

function umlGetLength(var aStr: umlBytes): Integer;
begin
  Result := Length(aStr);
end;

function umlGetLength(aStr: umlArrayString): Integer;
begin
  Result := Length(aStr);
end;

function umlUpperCase(Str: umlString): umlString;
begin
  Result := UpperCase(Str.Text);
end;

function umlLowerCase(Str: umlString): umlString;
begin
  Result := LowerCase(Str.Text);
end;

function umlCopyStr(aStr: umlString; MainPosition, LastPosition: Integer): umlString;
begin
  Result := aStr.Copy(MainPosition, LastPosition - MainPosition);
end;

function umlSameText(s1, s2: umlString): Boolean;
begin
  Result := s1.Same(s2);
end;

function umlGetStrIndexPos(IgnoreCase: Boolean; StartIndex: Integer; Str, SubStr: umlString): Integer;
label Cycle_Label;
var
  UpperCaseSourceStr, UpperCaseSubStr                      : umlString;
  SourceIndex, SubIndex, TempIndex, SourceLength, SubLength: Integer;
begin
  Result := 0;

  if Str.len < SubStr.len then
      Exit;

  if IgnoreCase then
    begin
      UpperCaseSourceStr := umlUpperCase(Str);
      UpperCaseSubStr := umlUpperCase(SubStr);
    end
  else
    begin
      UpperCaseSourceStr := Str;
      UpperCaseSubStr := SubStr;
    end;

  SourceLength := Str.len;
  SubLength := SubStr.len;

  if not(StartIndex > SourceLength) then
      Exit;
  SourceIndex := StartIndex;
Cycle_Label:

  if (SourceIndex + SubLength) > SourceLength + 1 then
      Exit;
  SubIndex := 1;
  TempIndex := SourceIndex;

  while UpperCaseSourceStr[TempIndex] = UpperCaseSubStr[SubIndex] do
    begin
      if SubIndex = SubLength then
        begin
          Result := SourceIndex;
          Exit;
        end;
      TempIndex := TempIndex + 1;
      SubIndex := SubIndex + 1;
    end;
  SourceIndex := SourceIndex + 1;
  goto Cycle_Label;
end;

function umlDeleteChar(_Text, _Char: umlString): umlString;
var
  i: Integer;
begin
  Result := '';
  if _Text.len > 0 then
    for i := 1 to _Text.len do
      if not umlMatchLimitChar(_Text[i], _Char) then
          Result := Result + _Text[i];
end;

function umlDeleteChar(_Text: umlString; const SomeCharsets: TOrdChars): umlString; overload;
var
  i: Integer;
begin
  Result := '';
  if _Text.len > 0 then
    for i := 1 to _Text.len do
      if not CharIn(_Text[i], SomeCharsets) then
          Result := Result + _Text[i];
end;

function umlGetNumberCharInText(n: umlString): umlString;
var
  i: Integer;
begin
  Result := '';
  i := 0;
  if n.len = 0 then
      Exit;

  while i <= n.len do
    begin
      if (not CharIn(n[i], c0to9)) then
        begin
          if (Result.len = 0) then
              Inc(i)
          else
              Exit;
        end
      else
        begin
          Result := Result + n[i];
          Inc(i);
        end;
    end;
end;

function umlGetLimitCharPos(CharValue: umlChar; LimitValue: umlString): Integer;
var
  LimitCharValuePos, LimitCharValueLength: Integer;
begin
  Result := 0;
  LimitCharValueLength := umlGetLength(LimitValue);
  if LimitCharValueLength > 0 then
    begin
      LimitCharValuePos := 1;
      if LimitCharValueLength > 1 then
        begin
          while (LimitValue[LimitCharValuePos] <> CharValue) and (LimitCharValuePos < LimitCharValueLength) do
              Inc(LimitCharValuePos);
          if LimitCharValuePos < LimitCharValueLength then
              Result := LimitCharValuePos;
        end;
      if Result = 0 then
        begin
          if LimitValue[LimitCharValueLength] = CharValue then
              Result := LimitCharValueLength;
        end;
    end;
end;

function umlMatchLimitChar(CharValue: umlChar; LimitValue: umlPString): Boolean;
var
  LimitCharValuePos, LimitCharValueLength: Integer;
begin
  Result := False;
  LimitCharValueLength := umlGetLength(LimitValue^);
  if LimitCharValueLength > 0 then
    begin
      LimitCharValuePos := 1;
      if LimitCharValueLength > 1 then
        begin
          while (LimitValue^[LimitCharValuePos] <> CharValue) and (LimitCharValuePos < LimitCharValueLength) do
              Inc(LimitCharValuePos);
          Result := LimitCharValuePos < LimitCharValueLength;
        end;
      if not Result then
          Result := LimitValue^[LimitCharValueLength] = CharValue;
    end;
end;

function umlMatchLimitChar(CharValue: umlChar; LimitValue: umlString): Boolean;
var
  LimitCharValuePos, LimitCharValueLength: Integer;
begin
  Result := False;
  LimitCharValueLength := umlGetLength(LimitValue);
  if LimitCharValueLength > 0 then
    begin
      LimitCharValuePos := 1;
      if LimitCharValueLength > 1 then
        begin
          while (LimitValue[LimitCharValuePos] <> CharValue) and (LimitCharValuePos < LimitCharValueLength) do
              Inc(LimitCharValuePos);
          Result := LimitCharValuePos < LimitCharValueLength;
        end;
      if not Result then
          Result := LimitValue[LimitCharValueLength] = CharValue;
    end;
end;

function umlExistsLimitChar(StrValue: umlString; LimitValue: umlString): Boolean;
var
  c: SystemChar;
begin
  Result := True;
  for c in StrValue.buff do
    if CharIn(c, LimitValue.buff) then
        Exit;
  Result := False;
end;

function umlExistsChar(StrValue: umlString; LimitValue: umlString): Boolean;
var
  c: SystemChar;
begin
  Result := True;
  for c in StrValue.buff do
    if CharIn(c, LimitValue.buff) then
        Exit;
  Result := False;
end;

function umlDelLimitChar(StrValue: umlString; LimitValue: umlString): umlString;
var
  i: Integer;
begin
  Result := '';
  if umlGetLength(StrValue) > 0 then
    begin
      for i := 1 to umlGetLength(StrValue) do
        if not umlMatchLimitChar(StrValue[i], @LimitValue) then
            Result := Result + StrValue[i];
    end;
end;

function umlGetLimitCharCount(StrValue: umlString; LimitValue: umlString): Integer;
var
  i: Integer;
begin
  Result := 0;
  if umlGetLength(StrValue) > 0 then
    begin
      for i := 1 to umlGetLength(StrValue) do
        begin
          if umlMatchLimitChar(StrValue[i], @LimitValue) then
              Inc(Result);
        end;
    end;
end;

function umlTrimChar(S: umlString; SpaceStr: umlString): umlString;
var
  i, l: Integer;
begin
  Result := '';
  l := umlGetLength(S);
  if l > 0 then
    begin
      i := 1;
      while umlMatchLimitChar(S[i], @SpaceStr) do
        begin
          Inc(i);
          if (i > l) then
              Exit;
        end;
      if not(i > l) then
        begin
          while umlMatchLimitChar(S[l], @SpaceStr) do
              Dec(l);
          Result := umlCopyStr(S, i, l + 1);
        end;
    end;
end;

function umlGetFirstStr(aStr: umlString; SpaceStr: umlString): umlString;
var
  umlGetFirstName_PrevPos, umlGetFirstName_Pos: Integer;
begin
  Result := aStr;
  if umlGetLength(Result) <= 1 then
    begin
      Exit;
    end;
  umlGetFirstName_Pos := 1;
  while umlMatchLimitChar(Result[umlGetFirstName_Pos], @SpaceStr) do
    begin
      if umlGetFirstName_Pos = umlGetLength(Result) then
          Exit;
      Inc(umlGetFirstName_Pos);
    end;
  umlGetFirstName_PrevPos := umlGetFirstName_Pos;
  while not umlMatchLimitChar(Result[umlGetFirstName_Pos], @SpaceStr) do
    begin
      if umlGetFirstName_Pos = umlGetLength(Result) then
        begin
          Result := umlCopyStr(Result, umlGetFirstName_PrevPos, umlGetFirstName_Pos + 1);
          Exit;
        end;
      Inc(umlGetFirstName_Pos);
    end;
  Result := umlCopyStr(Result, umlGetFirstName_PrevPos, umlGetFirstName_Pos);
end;

function umlGetLastStr(aStr: umlString; SpaceStr: umlString): umlString;
var
  umlGetLastName_PrevPos, umlGetLastName_Pos: Integer;
begin
  Result := aStr;
  umlGetLastName_Pos := umlGetLength(Result);
  if umlGetLastName_Pos <= 1 then
    begin
      Exit;
    end;
  while umlMatchLimitChar(Result[umlGetLastName_Pos], @SpaceStr) do
    begin
      if umlGetLastName_Pos = 1 then
          Exit;
      Dec(umlGetLastName_Pos);
    end;
  umlGetLastName_PrevPos := umlGetLastName_Pos;
  while not umlMatchLimitChar(Result[umlGetLastName_Pos], @SpaceStr) do
    begin
      if umlGetLastName_Pos = 1 then
        begin
          Result := umlCopyStr(Result, umlGetLastName_Pos, umlGetLastName_PrevPos + 1);
          Exit;
        end;
      Dec(umlGetLastName_Pos);
    end;
  Result := umlCopyStr(Result, umlGetLastName_Pos + 1, umlGetLastName_PrevPos + 1);
end;

function umlDeleteFirstStr(aStr: umlString; SpaceStr: umlString): umlString;
var
  umlMaskFirstName_Pos: Integer;
begin
  Result := aStr;
  if umlGetLength(Result) <= 1 then
    begin
      Result := '';
      Exit;
    end;
  umlMaskFirstName_Pos := 1;
  while umlMatchLimitChar(Result[umlMaskFirstName_Pos], @SpaceStr) do
    begin
      if umlMaskFirstName_Pos = umlGetLength(Result) then
        begin
          Result := '';
          Exit;
        end;
      Inc(umlMaskFirstName_Pos);
    end;
  while not umlMatchLimitChar(Result[umlMaskFirstName_Pos], @SpaceStr) do
    begin
      if umlMaskFirstName_Pos = umlGetLength(Result) then
        begin
          Result := '';
          Exit;
        end;
      Inc(umlMaskFirstName_Pos);
    end;
  while umlMatchLimitChar(Result[umlMaskFirstName_Pos], @SpaceStr) do
    begin
      if umlMaskFirstName_Pos = umlGetLength(Result) then
        begin
          Result := '';
          Exit;
        end;
      Inc(umlMaskFirstName_Pos);
    end;
  Result := umlCopyStr(Result, umlMaskFirstName_Pos, umlGetLength(Result) + 1);
end;

function umlDeleteLastStr(aStr: umlString; SpaceStr: umlString): umlString;
var
  umlMaskLastName_Pos: Integer;
begin
  Result := aStr;
  umlMaskLastName_Pos := umlGetLength(Result);
  if umlMaskLastName_Pos <= 1 then
    begin
      Result := '';
      Exit;
    end;
  while umlMatchLimitChar(Result[umlMaskLastName_Pos], @SpaceStr) do
    begin
      if umlMaskLastName_Pos = 1 then
        begin
          Result := '';
          Exit;
        end;
      Dec(umlMaskLastName_Pos);
    end;
  while not umlMatchLimitChar(Result[umlMaskLastName_Pos], @SpaceStr) do
    begin
      if umlMaskLastName_Pos = 1 then
        begin
          Result := '';
          Exit;
        end;
      Dec(umlMaskLastName_Pos);
    end;
  while umlMatchLimitChar(Result[umlMaskLastName_Pos], @SpaceStr) do
    begin
      if umlMaskLastName_Pos = 1 then
        begin
          Result := '';
          Exit;
        end;
      Dec(umlMaskLastName_Pos);
    end;
  umlSetLength(Result, umlMaskLastName_Pos);
end;

function umlGetIndexStrCount(aStr: umlString; SpaceStr: umlString): Integer;
var
  Str : umlString;
  APos: Integer;
begin
  Str := aStr;
  Result := 0;
  if umlGetLength(Str) = 0 then
      Exit;
  APos := 1;
  while True do
    begin
      while umlMatchLimitChar(Str[APos], @SpaceStr) do
        begin
          if APos >= umlGetLength(Str) then
              Exit;
          Inc(APos);
        end;
      Inc(Result);
      while not umlMatchLimitChar(Str[APos], @SpaceStr) do
        begin
          if APos >= umlGetLength(Str) then
              Exit;
          Inc(APos);
        end;
    end;
end;

function umlGetIndexStr(aStr: umlString; SpaceStr: umlString; Index: Integer): umlString;
var
  umlGetIndexName_Repeat: Integer;
begin
  case index of
    - 1:
      begin
        Result := '';
        Exit;
      end;
    0, 1:
      begin
        Result := umlGetFirstStr(aStr, SpaceStr);
        Exit;
      end;
  end;
  if index >= umlGetIndexStrCount(aStr, SpaceStr) then
    begin
      Result := umlGetLastStr(aStr, SpaceStr);
      Exit;
    end;
  Result := aStr;
  for umlGetIndexName_Repeat := 2 to index do
    begin
      Result := umlDeleteFirstStr(Result, SpaceStr);
    end;
  Result := umlGetFirstStr(Result, SpaceStr);
end;

procedure umlGetSplitArray(_SourText: umlString; var _DestArray: umlArrayString; _SplitChar: umlString);
var
  i, _IndexCount: Integer;
  _Text         : umlString;
begin
  _Text := _SourText;
  _IndexCount := umlGetIndexStrCount(_Text, _SplitChar);
  if (_IndexCount = 0) and (umlGetLength(_SourText) > 0) then
    begin
      SetLength(_DestArray, 1);
      _DestArray[0] := _SourText;
    end
  else
    begin
      SetLength(_DestArray, _IndexCount);
      i := low(_DestArray);
      while i < _IndexCount do
        begin
          _DestArray[i] := umlGetFirstStr(_Text, _SplitChar);
          _Text := umlDeleteFirstStr(_Text, _SplitChar);
          Inc(i);
        end;
    end;
end;

function umlArrayStringToText(var _Ary: umlArrayString; _SplitChar: umlString): umlString;
var
  i: Integer;
begin
  Result := '';
  for i := low(_Ary) to high(_Ary) do
    if i < high(_Ary) then
        Result := Result + _Ary[i] + _SplitChar
    else
        Result := Result + _Ary[i];
end;

function umlStringsToText(_List: TCoreClassStrings; _SplitChar: umlString): umlString;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to _List.Count - 1 do
    if i > 0 then
        Result := Result + _SplitChar + _List[i]
    else
        Result := _List[i];
end;

function umlGetFirstStr_M(aStr: umlString; SpaceStr: umlString): umlString;
var
  umlGetFirstName_PrevPos, umlGetFirstName_Pos: Integer;
begin
  Result := aStr;
  if umlGetLength(Result) <= 1 then
      Exit;
  umlGetFirstName_Pos := 1;
  if umlMatchLimitChar(Result[umlGetFirstName_Pos], @SpaceStr) then
    begin
      Inc(umlGetFirstName_Pos);
      umlGetFirstName_PrevPos := umlGetFirstName_Pos;
    end
  else
    begin
      umlGetFirstName_PrevPos := umlGetFirstName_Pos;
      while not umlMatchLimitChar(Result[umlGetFirstName_Pos], @SpaceStr) do
        begin
          if umlGetFirstName_Pos = umlGetLength(Result) then
            begin
              Result := umlCopyStr(Result, umlGetFirstName_PrevPos, umlGetFirstName_Pos + 1);
              Exit;
            end;
          Inc(umlGetFirstName_Pos);
        end;
    end;
  Result := umlCopyStr(Result, umlGetFirstName_PrevPos, umlGetFirstName_Pos);
end;

function umlDeleteFirstStr_M(aStr: umlString; SpaceStr: umlString): umlString;
var
  umlMaskFirstName_Pos: Integer;
begin
  Result := aStr;
  if umlGetLength(Result) <= 1 then
    begin
      Result := '';
      Exit;
    end;
  umlMaskFirstName_Pos := 1;
  while not umlMatchLimitChar(Result[umlMaskFirstName_Pos], @SpaceStr) do
    begin
      if umlMaskFirstName_Pos = umlGetLength(Result) then
        begin
          Result := '';
          Exit;
        end;
      Inc(umlMaskFirstName_Pos);
    end;
  if umlMatchLimitChar(Result[umlMaskFirstName_Pos], @SpaceStr) then
      Inc(umlMaskFirstName_Pos);
  Result := umlCopyStr(Result, umlMaskFirstName_Pos, umlGetLength(Result) + 1);
end;

function umlGetLastStr_M(aStr: umlString; SpaceStr: umlString): umlString;
var
  umlGetLastName_PrevPos, umlGetLastName_Pos: Integer;
begin
  Result := aStr;
  umlGetLastName_Pos := umlGetLength(Result);
  if umlGetLastName_Pos <= 1 then
      Exit;
  if Result[umlGetLastName_Pos] = SpaceStr then
      Dec(umlGetLastName_Pos);
  umlGetLastName_PrevPos := umlGetLastName_Pos;
  while not umlMatchLimitChar(Result[umlGetLastName_Pos], @SpaceStr) do
    begin
      if umlGetLastName_Pos = 1 then
        begin
          Result := umlCopyStr(Result, umlGetLastName_Pos, umlGetLastName_PrevPos + 1);
          Exit;
        end;
      Dec(umlGetLastName_Pos);
    end;
  Result := umlCopyStr(Result, umlGetLastName_Pos + 1, umlGetLastName_PrevPos + 1);
end;

function umlDeleteLastStr_M(aStr: umlString; SpaceStr: umlString): umlString;
var
  umlMaskLastName_Pos: Integer;
begin
  Result := aStr;
  umlMaskLastName_Pos := umlGetLength(Result);
  if umlMaskLastName_Pos <= 1 then
    begin
      Result := '';
      Exit;
    end;
  if umlMatchLimitChar(Result[umlMaskLastName_Pos], @SpaceStr) then
      Dec(umlMaskLastName_Pos);
  while not umlMatchLimitChar(Result[umlMaskLastName_Pos], @SpaceStr) do
    begin
      if umlMaskLastName_Pos = 1 then
        begin
          Result := '';
          Exit;
        end;
      Dec(umlMaskLastName_Pos);
    end;
  umlSetLength(Result, umlMaskLastName_Pos);
end;

function umlGetIndexStrCount_M(aStr: umlString; SpaceStr: umlString): Integer;
var
  Str : umlString;
  APos: Integer;
begin
  Str := aStr;
  Result := 0;
  if umlGetLength(Str) = 0 then
      Exit;
  APos := 1;
  Result := 1;
  while True do
    begin
      while not umlMatchLimitChar(Str[APos], @SpaceStr) do
        begin
          if APos = umlGetLength(Str) then
              Exit;
          Inc(APos);
        end;
      Inc(Result);
      if APos = umlGetLength(Str) then
          Exit;
      Inc(APos);
    end;
end;

function umlGetIndexStr_M(aStr: umlString; SpaceStr: umlString; Index: Integer): umlString;
var
  umlGetIndexName_Repeat: Integer;
begin
  case index of
    - 1:
      begin
        Result := '';
        Exit;
      end;
    0, 1:
      begin
        Result := umlGetFirstStr_M(aStr, SpaceStr);
        Exit;
      end;
  end;
  if index >= umlGetIndexStrCount_M(aStr, SpaceStr) then
    begin
      Result := umlGetLastStr_M(aStr, SpaceStr);
      Exit;
    end;
  Result := aStr;
  for umlGetIndexName_Repeat := 2 to index do
      Result := umlDeleteFirstStr_M(Result, SpaceStr);
  Result := umlGetFirstStr_M(Result, SpaceStr);
end;

function umlGetFirstTextPos(S: umlString; ATextList: array of umlString; var OutText: umlString): Integer;
var
  i, j: Integer;
begin
  Result := -1;
  for i := 1 to S.len do
    begin
      for j := low(ATextList) to high(ATextList) do
        begin
          if S.ComparePos(i, @ATextList[j]) then
            begin
              OutText := ATextList[j];
              Result := i;
              Exit;
            end;
        end;
    end;
end;

function umlDeleteText(ASourText: umlString; ABeginFlag, AEndFlag: array of umlString; ANeedBegin, ANeedEnd: Boolean): umlString;
var
  ABeginPos, AEndPos           : Integer;
  ABeginText, AEndText, ANewStr: umlString;
begin
  Result := ASourText;
  if umlGetLength(ASourText) > 0 then
    begin
      ABeginPos := umlGetFirstTextPos(ASourText, ABeginFlag, ABeginText);
      if ABeginPos > 0 then
          ANewStr := umlCopyStr(ASourText, ABeginPos + umlGetLength(ABeginText), umlGetLength(ASourText) + 1)
      else if ANeedBegin then
          Exit
      else
          ANewStr := ASourText;

      AEndPos := umlGetFirstTextPos(ANewStr, AEndFlag, AEndText);
      if AEndPos > 0 then
          ANewStr := umlCopyStr(ANewStr, (AEndPos + umlGetLength(AEndText)), umlGetLength(ANewStr) + 1)
      else if ANeedEnd then
          Exit
      else
          ANewStr := '';

      if ABeginPos > 0 then
        begin
          if AEndPos > 0 then
              Result := umlCopyStr(ASourText, 0, ABeginPos - 1) + umlDeleteText(ANewStr, ABeginFlag, AEndFlag, ANeedBegin, ANeedEnd)
          else
              Result := umlCopyStr(ASourText, 0, ABeginPos - 1) + ANewStr;
        end
      else if AEndPos > 0 then
          Result := ANewStr;
    end;
end;

function umlGetTextContent(ASourText: umlString; ABeginFlag, AEndFlag: array of umlString): umlString;
var
  ABeginPos, AEndPos           : Integer;
  ABeginText, AEndText, ANewStr: umlString;
begin
  Result := '';
  if umlGetLength(ASourText) > 0 then
    begin
      ABeginPos := umlGetFirstTextPos(ASourText, ABeginFlag, ABeginText);
      if ABeginPos > 0 then
          ANewStr := umlCopyStr(ASourText, ABeginPos + umlGetLength(ABeginText), umlGetLength(ASourText) + 1)
      else
          ANewStr := ASourText;

      AEndPos := umlGetFirstTextPos(ANewStr, AEndFlag, AEndText);
      if AEndPos > 0 then
          Result := umlCopyStr(ANewStr, 0, AEndPos - 1)
      else
          Result := ANewStr;
    end;
end;

function umlGetNumTextType(S: umlString): TTextType;
type
  TValSym = (vsSymSub, vsSymAdd, vsSymAddSub, vsSymDollar, vsDot, vsDotBeforNum, vsDotAfterNum, vsNum, vsAtoF, vsE, vsUnknow);
var
  cnt: array [TValSym] of Integer;
  v  : TValSym;
  c  : umlChar;
  i  : Integer;
begin
  if umlSameText('true', S) or umlSameText('false', S) then
      Exit(ntBool);

  for v := low(TValSym) to high(TValSym) do
      cnt[v] := 0;

  for i := 1 to S.len do
    begin
      c := S[i];
      if CharIn(c, [c0to9]) then
        begin
          Inc(cnt[vsNum]);
          if cnt[vsDot] > 0 then
              Inc(cnt[vsDotAfterNum]);
        end
      else if CharIn(c, [cLoAtoF, cHiAtoF]) then
        begin
          Inc(cnt[vsAtoF]);
          if CharIn(c, 'eE') then
              Inc(cnt[vsE]);
        end
      else if c = '.' then
        begin
          Inc(cnt[vsDot]);
          cnt[vsDotBeforNum] := cnt[vsNum];
        end
      else if CharIn(c, '-') then
        begin
          Inc(cnt[vsSymSub]);
          Inc(cnt[vsSymAddSub]);
        end
      else if CharIn(c, '+') then
        begin
          Inc(cnt[vsSymAdd]);
          Inc(cnt[vsSymAddSub]);
        end
      else if CharIn(c, '$') and (i = 1) then
          Inc(cnt[vsSymDollar])
      else
          Exit(ntUnknow);
    end;

  if cnt[vsDot] > 1 then
      Exit(ntUnknow);
  if cnt[vsSymDollar] > 1 then
      Exit(ntUnknow);
  if (cnt[vsSymDollar] = 0) and (cnt[vsNum] = 0) then
      Exit(ntUnknow);
  if (cnt[vsSymAdd] > 1) and (cnt[vsE] = 0) and (cnt[vsSymDollar] = 0) then
      Exit(ntUnknow);

  if (cnt[vsSymDollar] = 0) and
    ((cnt[vsDot] = 1) or ((cnt[vsE] = 1) and ((cnt[vsSymAddSub] >= 1) and (cnt[vsSymDollar] = 0)))) then
    begin
      if cnt[vsSymDollar] > 0 then
          Exit(ntUnknow);
      if (cnt[vsAtoF] <> cnt[vsE]) then
          Exit(ntUnknow);

      if cnt[vsE] = 1 then
        begin
          Result := ntDouble
        end
      else if ((cnt[vsDotBeforNum] > 0)) and (cnt[vsDotAfterNum] > 0) then
        begin
          if cnt[vsDotAfterNum] < 5 then
              Result := ntCurrency
          else if cnt[vsNum] > 7 then
              Result := ntDouble
          else
              Result := ntSingle;
        end
      else
          Exit(ntUnknow);
    end
  else
    begin
      if cnt[vsSymDollar] = 1 then
        begin
          if cnt[vsSymSub] > 0 then
            begin
              if cnt[vsNum] < 2 then
                  Result := ntShortInt
              else if cnt[vsNum] < 4 then
                  Result := ntSmallInt
              else if cnt[vsNum] < 7 then
                  Result := ntInt
              else if cnt[vsNum] < 13 then
                  Result := ntInt64
              else
                  Result := ntUnknow;
            end
          else
            begin
              if cnt[vsNum] < 3 then
                  Result := ntByte
              else if cnt[vsNum] < 5 then
                  Result := ntWord
              else if cnt[vsNum] < 8 then
                  Result := ntUInt
              else if cnt[vsNum] < 14 then
                  Result := ntUInt64
              else
                  Result := ntUnknow;
            end;
        end
      else if cnt[vsAtoF] > 0 then
          Exit(ntUnknow)
      else if cnt[vsSymSub] > 0 then
        begin
          if cnt[vsNum] < 3 then
              Result := ntShortInt
          else if cnt[vsNum] < 5 then
              Result := ntSmallInt
          else if cnt[vsNum] < 8 then
              Result := ntInt
          else if cnt[vsNum] < 13 then
              Result := ntInt64
          else
              Result := ntUnknow;
        end
      else
        begin
          if cnt[vsNum] < 3 then
              Result := ntByte
          else if cnt[vsNum] < 5 then
              Result := ntWord
          else if cnt[vsNum] < 8 then
              Result := ntUInt
          else if cnt[vsNum] < 14 then
              Result := ntUInt64
          else
              Result := ntUnknow;
        end;
    end;
end;

function umlIsHex(aStr: umlString): Boolean;
begin
  Result := umlGetNumTextType(aStr) in
    [ntInt, ntInt64, ntUInt64, ntWord, ntByte, ntSmallInt, ntShortInt, ntUInt];
end;

function umlIsNumber(aStr: umlString): Boolean;
begin
  Result := umlGetNumTextType(aStr) <> ntUnknow;
end;

function umlIsIntNumber(aStr: umlString): Boolean;
begin
  Result := umlGetNumTextType(aStr) in
    [ntInt, ntInt64, ntUInt64, ntWord, ntByte, ntSmallInt, ntShortInt, ntUInt];
end;

function umlIsFloatNumber(aStr: umlString): Boolean;
begin
  Result := umlGetNumTextType(aStr) in [ntSingle, ntDouble, ntCurrency];
end;

function umlIsBool(aStr: umlString): Boolean;
begin
  Result := umlGetNumTextType(aStr) = ntBool;
end;

function umlNumberCount(aStr: umlString): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to umlGetLength(aStr) do
    if CharIn(aStr[i], [c0to9]) then
        Inc(Result);
end;

function umlPercentageToFloat(OriginMax, OriginMin, ProcressParameter: Double): Double;
begin
  Result := (ProcressParameter - OriginMin) * 100.0 / (OriginMax - OriginMin);
end;

function umlPercentageToInt(OriginParameter, ProcressParameter: Integer): Integer;
begin
  if OriginParameter = 0 then
      Result := 0
  else
      Result := (Integer(Round((ProcressParameter * 100.0) / OriginParameter)));
end;

function umlPercentageToStr(OriginParameter, ProcressParameter: Integer): umlString;
begin
  Result := IntToStr(umlPercentageToInt(OriginParameter, ProcressParameter)) + '%';
end;

function umlSmartSizeToStr(Size: Int64): umlString;
begin
  if Size < 1 shl 10 then
      Result := format('%d', [Size])
  else if Size < 1 shl 20 then
      Result := format('%fKb', [Size / (1 shl 10)])
  else if Size < 1 shl 30 then
      Result := format('%fM', [Size / (1 shl 20)])
  else
      Result := format('%fG', [Size / (1 shl 30)])
end;

function umlIntToStr(Parameter: Double): umlString;
begin
  Result := IntToStr(Round(Parameter));
end;

function umlIntToStr(Parameter: Int64): umlString;
begin
  Result := IntToStr(Parameter);
end;

function umlSizeToStr(Parameter: Int64): umlString;
begin
  try
      Result := umlSmartSizeToStr(Parameter);
  except
      Result := IntToStr(Parameter) + ' B';
  end;
end;

function umlTimeToStr(TimeInteger: Integer): umlString;
begin
  Result := DateTimeToStr(FileDateToDateTime(TimeInteger));
end;

function umlDateToStr(TimeInteger: Integer): umlString;
begin
  Result := DateToStr(FileDateToDateTime(TimeInteger));
end;

function umlFloatToStr(f: Double): umlString;
begin
  Result := FloatToStr(f);
end;

function umlStrToInt(_V: umlString): Integer;
begin
  Result := umlStrToInt(_V, 0);
end;

function umlStrToInt(_V: umlString; _Def: Integer): Integer;
begin
  if umlIsNumber(_V) then
      Result := StrToInt(_V.Text)
  else
      Result := _Def;
end;

function umlStrToInt(_V: umlString; _Def: Double): Integer;
begin
  if umlIsNumber(_V) then
      Result := StrToInt(_V.Text)
  else
      Result := Round(_Def);
end;

function umlStrToFloat(_V: umlString; _Def: Double): Double;
begin
  if umlIsNumber(_V) then
      Result := StrToFloat(_V.Text)
  else
      Result := _Def;
end;

function umlMultipleMatch(IgnoreCase: Boolean; SourceStr, TargetStr, umlMultipleString, umlMultipleCharacter: umlString): Boolean;
label CharacterRep_Label, MultipleCharacterRep_Label, MultipleStringRep_Label;
var
  UpperCaseSourceStr, UpperCaseTargetStr, SwapStr                            : umlString;
  SourceChar, TargetChar, SwapChar                                           : umlChar;
  SourceIndex, TargetIndex, SwapIndex, SourceLength, TargetLength, SwapLength: Integer;
begin
  SourceLength := SourceStr.len;
  if SourceLength = 0 then
    begin
      Result := True;
      Exit;
    end;

  TargetLength := TargetStr.len;
  if TargetLength = 0 then
    begin
      Result := False;
      Exit;
    end;

  if IgnoreCase then
    begin
      UpperCaseSourceStr := umlUpperCase(SourceStr);
      UpperCaseTargetStr := umlUpperCase(TargetStr);
    end
  else
    begin
      UpperCaseSourceStr := SourceStr;
      UpperCaseTargetStr := TargetStr;
    end;

  if (not umlExistsLimitChar(SourceStr, umlMultipleCharacter)) and (not umlExistsLimitChar(SourceStr, umlMultipleString)) then
    begin
      Result := (SourceLength = TargetLength) and (UpperCaseSourceStr = UpperCaseTargetStr);
      Exit;
    end;
  if SourceLength = 1 then
    begin
      if umlMatchLimitChar(UpperCaseSourceStr[1], @umlMultipleString) then
          Result := True
      else
          Result := False;
      Exit;
    end;
  SourceIndex := 1;
  TargetIndex := 1;
  SourceChar := UpperCaseSourceStr[SourceIndex];
  TargetChar := UpperCaseTargetStr[TargetIndex];
CharacterRep_Label:
  while (SourceChar = TargetChar) and (not umlMatchLimitChar(SourceChar, @umlMultipleCharacter)) and (not umlMatchLimitChar(SourceChar, @umlMultipleString)) do
    begin
      if SourceIndex = SourceLength then
        begin
          if TargetIndex = TargetLength then
            begin
              Result := True;
              Exit;
            end;
          Result := False;
          Exit;
        end;
      if TargetIndex = TargetLength then
        begin
          SourceIndex := SourceIndex + 1;
          if SourceIndex = SourceLength then
            begin
              SourceChar := UpperCaseSourceStr[SourceIndex];
              Result := umlMatchLimitChar(SourceChar, @umlMultipleString) or umlMatchLimitChar(SourceChar, @umlMultipleCharacter);
              Exit;
            end;
          Result := False;
          Exit;
        end;
      SourceIndex := SourceIndex + 1;
      TargetIndex := TargetIndex + 1;
      SourceChar := UpperCaseSourceStr[SourceIndex];
      TargetChar := UpperCaseTargetStr[TargetIndex];
    end;
MultipleCharacterRep_Label:
  while umlMatchLimitChar(SourceChar, @umlMultipleCharacter) do
    begin
      if SourceIndex = SourceLength then
        begin
          if TargetIndex = TargetLength then
            begin
              Result := True;
              Exit;
            end;
          Result := False;
          Exit;
        end;
      if TargetIndex = TargetLength then
        begin
          SourceIndex := SourceIndex + 1;
          SourceChar := UpperCaseSourceStr[SourceIndex];
          if (SourceIndex = SourceLength) and ((umlMatchLimitChar(SourceChar, @umlMultipleString)) or (umlMatchLimitChar(SourceChar, @umlMultipleCharacter))) then
            begin
              Result := True;
              Exit;
            end;
          Result := False;
          Exit;
        end;
      SourceIndex := SourceIndex + 1;
      TargetIndex := TargetIndex + 1;
      SourceChar := UpperCaseSourceStr[SourceIndex];
      TargetChar := UpperCaseTargetStr[TargetIndex];
    end;
MultipleStringRep_Label:
  if umlMatchLimitChar(SourceChar, @umlMultipleString) then
    begin
      if SourceIndex = SourceLength then
        begin
          Result := True;
          Exit;
        end;
      SourceIndex := SourceIndex + 1;
      SourceChar := UpperCaseSourceStr[SourceIndex];

      while (umlMatchLimitChar(SourceChar, @umlMultipleString)) or (umlMatchLimitChar(SourceChar, @umlMultipleCharacter)) do
        begin
          if SourceIndex = SourceLength then
            begin
              Result := True;
              Exit;
            end;
          SourceIndex := SourceIndex + 1;
          SourceChar := UpperCaseSourceStr[SourceIndex];
          while umlMatchLimitChar(SourceChar, @umlMultipleCharacter) do
            begin
              if SourceIndex = SourceLength then
                begin
                  Result := True;
                  Exit;
                end;
              SourceIndex := SourceIndex + 1;
              SourceChar := UpperCaseSourceStr[SourceIndex];
            end;
        end;
      SwapStr := umlCopyStr(UpperCaseSourceStr, SourceIndex, SourceLength + 1);
      SwapLength := umlGetLength(SwapStr);
      if SwapLength = 0 then
        begin
          Result := (UpperCaseSourceStr[SourceIndex] = umlMultipleString);
          Exit;
        end;
      SwapIndex := 1;
      SwapChar := SwapStr[SwapIndex];
      while (not umlMatchLimitChar(SwapChar, @umlMultipleCharacter)) and (not umlMatchLimitChar(SwapChar, @umlMultipleString)) and (SwapIndex < SwapLength) do
        begin
          SwapIndex := SwapIndex + 1;
          SwapChar := SwapStr[SwapIndex];
        end;
      if (umlMatchLimitChar(SwapChar, @umlMultipleCharacter)) or (umlMatchLimitChar(SwapChar, @umlMultipleString)) then
          SwapStr := umlCopyStr(SwapStr, 1, SwapIndex)
      else
        begin
          SwapStr := umlCopyStr(SwapStr, 1, SwapIndex + 1);
          if SwapStr = '' then
            begin
              Result := False;
              Exit;
            end;
          SwapLength := umlGetLength(SwapStr);
          SwapIndex := 1;
          SwapChar := SwapStr[SwapLength];
          TargetChar := UpperCaseTargetStr[TargetLength];
          while SwapChar = TargetChar do
            begin
              if SwapIndex = SwapLength then
                begin
                  Result := True;
                  Exit;
                end;
              if SwapIndex = TargetLength then
                begin
                  Result := False;
                  Exit;
                end;
              SwapChar := SwapStr[(SwapLength) - SwapIndex];
              TargetChar := UpperCaseTargetStr[(TargetLength) - SwapIndex];
              SwapIndex := SwapIndex + 1;
            end;
          Result := False;
          Exit;
        end;
      SwapChar := SwapStr[1];
      SwapIndex := 1;
      SwapLength := umlGetLength(SwapStr);
      while SwapIndex <= SwapLength do
        begin
          if (TargetIndex - 1) + SwapIndex > TargetLength then
            begin
              Result := False;
              Exit;
            end;
          SwapChar := SwapStr[SwapIndex];
          TargetChar := UpperCaseTargetStr[(TargetIndex - 1) + SwapIndex];
          while SwapChar <> TargetChar do
            begin
              if (TargetIndex + SwapLength) > TargetLength then
                begin
                  Result := False;
                  Exit;
                end;
              TargetIndex := TargetIndex + 1;
              SwapIndex := 1;
              SwapChar := SwapStr[SwapIndex];
              TargetChar := UpperCaseTargetStr[(TargetIndex - 1) + SwapIndex];
            end;
          SwapIndex := SwapIndex + 1;
        end;
      TargetIndex := (TargetIndex - 1) + SwapLength;
      SourceIndex := (SourceIndex - 1) + SwapLength;
      TargetChar := SwapChar;
      SourceChar := SwapChar;
    end;
  if SourceChar = TargetChar then
      goto CharacterRep_Label
  else if umlMatchLimitChar(SourceChar, @umlMultipleCharacter) then
      goto MultipleCharacterRep_Label
  else if umlMatchLimitChar(SourceChar, @umlMultipleString) then
      goto MultipleStringRep_Label
  else
      Result := False;
end;

function umlMultipleMatch(IgnoreCase: Boolean; SourceStr, TargetStr: umlString): Boolean;
begin
  if (SourceStr.len > 0) and (SourceStr.Text <> '*') then
      Result := umlMultipleMatch(IgnoreCase, SourceStr, TargetStr, '*', '?')
  else
      Result := True;
end;

function umlMultipleMatch(const SourceStr, TargetStr: umlString): Boolean;
var
  fi: umlArrayString;
begin
  if (SourceStr.len > 0) and (SourceStr.Text <> '*') then
    begin
      umlGetSplitArray(SourceStr, fi, ';');
      Result := umlMultipleMatch(fi, TargetStr);
    end
  else
      Result := True;
end;

function umlMultipleMatch(const ValueCheck: umlArrayString; Value: umlString): Boolean;
var
  i: Integer;
begin
  Result := True;
  if umlGetLength(Value) > 0 then
    begin
      if high(ValueCheck) >= 0 then
        begin
          Result := False;
          for i := low(ValueCheck) to high(ValueCheck) do
            begin
              Result := umlMultipleMatch(True, ValueCheck[i], Value);
              if Result then
                  Exit;
            end;
        end;
    end;
end;

function umlSearchMatch(const SourceStr, TargetStr: umlString): Boolean;
var
  fi: umlArrayString;
begin
  if (SourceStr.len > 0) and (SourceStr.Text <> '*') then
    begin
      umlGetSplitArray(SourceStr, fi, ';');
      Result := umlSearchMatch(fi, TargetStr);
    end
  else
      Result := True;
end;

function umlSearchMatch(ValueCheck: umlArrayString; Value: umlString): Boolean;
var
  i: Integer;
begin
  Result := True;
  if umlGetLength(Value) > 0 then
    begin
      if high(ValueCheck) >= 0 then
        begin
          Result := False;
          for i := low(ValueCheck) to high(ValueCheck) do
            begin
              Result := (Value.GetPos(ValueCheck[i]) > 0) or (umlMultipleMatch(True, ValueCheck[i], Value));
              if Result then
                  Exit;
            end;
        end;
    end;
end;

function umlDeTimeCodeToStr(NowDateTime: TDateTime): umlString;
var
  Year, Month, Day    : Word;
  Hour, Min, Sec, MSec: Word;
begin
  DecodeDate(NowDateTime, Year, Month, Day);
  DecodeTime(NowDateTime, Hour, Min, Sec, MSec);
  Result := IntToHex(Year, 4) + IntToHex(Month, 2) +
    IntToHex(Day, 2) + IntToHex(Hour, 1) + IntToHex(Min, 2) +
    IntToHex(Sec, 2) + IntToHex(MSec, 3);
end;

function umlStringReplace(S, OldPattern, NewPattern: umlString; IgnoreCase: Boolean): umlString;
var
  f: TReplaceFlags;
begin
  f := [rfReplaceAll];
  if IgnoreCase then
      f := f + [rfIgnoreCase];
  Result.Text := StringReplace(S.Text, OldPattern.Text, NewPattern.Text, f);
end;

function umlCharReplace(S: umlString; OldPattern, NewPattern: umlChar): umlString;
var
  i: Integer;
begin
  Result := S;
  if umlGetLength(Result) > 0 then
    begin
      for i := 1 to umlGetLength(Result) do
        begin
          if Result[i] = OldPattern then
              Result[i] := NewPattern;
        end;
    end;
end;

function umlEncodeText2HTML(psSrc: umlString): umlString;
var
  i: Integer;
begin
  Result := '';
  if psSrc.len > 0 then
    begin
      i := 1;
      while i <= psSrc.len do
        begin
          case psSrc[i] of
            ' ':
              Result := Result + '&nbsp;';
            '<':
              Result := Result + '&lt;';
            '>':
              Result := Result + '&gt;';
            '&':
              Result := Result + '&amp;';
            '"':
              Result := Result + '&quot;';
            #9:
              Result := Result + '&nbsp;&nbsp;&nbsp;&nbsp;';
            #13:
              begin
                if i + 1 <= psSrc.len then
                  begin
                    if psSrc[i + 1] = #10 then
                        Inc(i);
                    Result := Result + '<br>';
                  end
                else
                  begin
                    Result := Result + '<br>';
                  end;
              end;
            #10:
              begin
                if i + 1 <= psSrc.len then
                  begin
                    if psSrc[i + 1] = #13 then
                        Inc(i);
                    Result := Result + '<br>';
                  end
                else
                  begin
                    Result := Result + '<br>';
                  end;
              end;
            else
              Result := Result + psSrc[i];
          end;
          Inc(i);
        end;
    end;
end;

type
  TByte4 = record
    b1: Byte;
    b2: Byte;
    b3: Byte;
    b4: Byte;
  end;

  PByte4 = ^TByte4;

  TByte3 = record
    b1: Byte;
    b2: Byte;
    b3: Byte;
  end;

  PByte3 = ^TByte3;

function umlBase64DecodePartial(const InputBuffer: Pointer; const InputBytesCount: Cardinal; const OutputBuffer: Pointer; var ByteBuffer, ByteBufferSpace: NativeInt): Cardinal;
const
  umlBase64_DECODE_TABLE: array [Byte] of Cardinal = (255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 062, 255, 255, 255, 063, 052, 053, 054, 055, 056, 057, 058, 059, 060, 061, 255, 255,
    255, 255, 255, 255, 255, 000, 001, 002, 003, 004, 005, 006, 007, 008, 009, 010, 011, 012, 013, 014, 015, 016, 017, 018, 019, 020, 021, 022, 023, 024, 025, 255, 255, 255, 255,
    255, 255, 026, 027, 028, 029, 030, 031, 032, 033, 034, 035, 036, 037, 038, 039, 040, 041, 042, 043, 044, 045, 046, 047, 048, 049, 050, 051, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255);
var
  lByteBuffer, lByteBufferSpace, c: Cardinal;
  InPtr, InLimitPtr               : PBYTE;
  OutPtr                          : PByte3;
begin
  if InputBytesCount > 0 then
    begin
      InPtr := InputBuffer;
      NativeUInt(InLimitPtr) := NativeUInt(InPtr) + InputBytesCount;
      OutPtr := OutputBuffer;
      lByteBuffer := ByteBuffer;
      lByteBufferSpace := ByteBufferSpace;
      while InPtr <> InLimitPtr do
        begin
          c := umlBase64_DECODE_TABLE[InPtr^];
          Inc(InPtr);
          if c = $FF then
              Continue;
          lByteBuffer := lByteBuffer shl 6;
          lByteBuffer := lByteBuffer or c;
          Dec(lByteBufferSpace);
          if lByteBufferSpace <> 0 then
              Continue;
          OutPtr^.b3 := Byte(lByteBuffer);
          lByteBuffer := lByteBuffer shr 8;
          OutPtr^.b2 := Byte(lByteBuffer);
          lByteBuffer := lByteBuffer shr 8;
          OutPtr^.b1 := Byte(lByteBuffer);
          lByteBuffer := 0;
          Inc(OutPtr);
          lByteBufferSpace := 4;
        end;
      ByteBuffer := lByteBuffer;
      ByteBufferSpace := lByteBufferSpace;
      Result := Cardinal(OutPtr) - Cardinal(OutputBuffer);
    end
  else
      Result := 0;
end;

function umlBase64DecodePartialEnd(const OutputBuffer: Pointer; const ByteBuffer: NativeInt; const ByteBufferSpace: NativeInt): Cardinal;
var
  lByteBuffer: Cardinal;
begin
  case ByteBufferSpace of
    1:
      begin
        lByteBuffer := ByteBuffer shr 2;
        PByte3(OutputBuffer)^.b2 := Byte(lByteBuffer);
        lByteBuffer := lByteBuffer shr 8;
        PByte3(OutputBuffer)^.b1 := Byte(lByteBuffer);
        Result := 2;
      end;
    2:
      begin
        lByteBuffer := ByteBuffer shr 4;
        PByte3(OutputBuffer)^.b1 := Byte(lByteBuffer);
        Result := 1;
      end;
    else
      Result := 0;
  end;
end;

procedure umlBase64Encode(const InputBuffer: Pointer; const InputByteCount: NativeInt; const OutputBuffer: Pointer);
const
  EQUAL_SIGN  = Byte('=');
  BUFFER_SIZE = $3000;

  umlBase64_ENCODE_TABLE: array [0 .. 63] of Byte = (065, 066, 067, 068, 069, 070, 071, 072, 073, 074, 075, 076, 077, 078, 079, 080, 081, 082, 083, 084, 085, 086, 087, 088, 089,
    090, 097, 098, 099, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 048, 049, 050, 051, 052, 053, 054, 055,
    056, 057, 043, 047);
var
  B, InMax3        : NativeUInt;
  InPtr, InLimitPtr: ^Byte;
  OutPtr           : PByte4;
begin
  if InputByteCount <= 0 then
      Exit;
  InPtr := InputBuffer;
  InMax3 := InputByteCount div 3 * 3;
  OutPtr := OutputBuffer;
  NativeUInt(InLimitPtr) := NativeUInt(InPtr) + InMax3;
  while InPtr <> InLimitPtr do
    begin
      B := InPtr^;
      B := B shl 8;
      Inc(InPtr);
      B := B or InPtr^;
      B := B shl 8;
      Inc(InPtr);
      B := B or InPtr^;
      Inc(InPtr);
      OutPtr^.b4 := umlBase64_ENCODE_TABLE[B and $3F];
      B := B shr 6;
      OutPtr^.b3 := umlBase64_ENCODE_TABLE[B and $3F];
      B := B shr 6;
      OutPtr^.b2 := umlBase64_ENCODE_TABLE[B and $3F];
      B := B shr 6;
      OutPtr^.b1 := umlBase64_ENCODE_TABLE[B];
      Inc(OutPtr);
    end;

  case InputByteCount - InMax3 of
    1:
      begin
        B := InPtr^;
        B := B shl 4;
        OutPtr^.b2 := umlBase64_ENCODE_TABLE[B and $3F];
        B := B shr 6;
        OutPtr^.b1 := umlBase64_ENCODE_TABLE[B];
        OutPtr^.b3 := EQUAL_SIGN;
        OutPtr^.b4 := EQUAL_SIGN;
      end;
    2:
      begin
        B := InPtr^;
        Inc(InPtr);
        B := B shl 8;
        B := B or InPtr^;
        B := B shl 2;
        OutPtr^.b3 := umlBase64_ENCODE_TABLE[B and $3F];
        B := B shr 6;
        OutPtr^.b2 := umlBase64_ENCODE_TABLE[B and $3F];
        B := B shr 6;
        OutPtr^.b1 := umlBase64_ENCODE_TABLE[B];
        OutPtr^.b4 := EQUAL_SIGN;
      end;
  end;
end;

procedure umlBase64EncodeBytes(var Sour, Dest: TBytes);
var
  l: NativeInt;
begin
  l := Length(Sour);
  if l > 0 then
    begin
      SetLength(Dest, (l + 2) div 3 * 4);
      umlBase64Encode(@Sour[0], l, @Dest[0]);
    end;
end;

procedure umlBase64EncodeBytes(var Sour: TBytes; var Dest: umlString);
var
  buff: TBytes;
begin
  umlBase64EncodeBytes(Sour, buff);
  Dest.Bytes := buff;
end;

procedure umlBase64DecodeBytes(var Sour, Dest: TBytes);
var
  ByteBuffer, ByteBufferSpace: NativeInt;
  l                          : NativeInt;
begin
  l := Length(Sour);
  if l > 0 then
    begin
      SetLength(Dest, (l + 3) div 4 * 3);
      ByteBuffer := 0;
      ByteBufferSpace := 4;
      l := umlBase64DecodePartial(@Sour[0], l, @Dest[0], ByteBuffer, ByteBufferSpace);
      Inc(l, umlBase64DecodePartialEnd(Pointer(NativeUInt(@Dest[0]) + l), ByteBuffer, ByteBufferSpace));
      SetLength(Dest, l);
    end;
end;

procedure umlBase64DecodeBytes(Sour: umlString; var Dest: TBytes);
var
  buff: TBytes;
begin
  buff := Sour.Bytes;
  umlBase64DecodeBytes(buff, Dest);
end;

procedure umlDecodeLineBASE64(Buffer: umlString; var Output: umlString);
var
  B, nb: TBytes;
begin
  B := umlBytesOf(Buffer);
  umlBase64DecodeBytes(B, nb);
  Output := umlStringOf(nb);
end;

procedure umlEncodeLineBASE64(Buffer: umlString; var Output: umlString);
var
  B, nb: TBytes;
begin
  B := umlBytesOf(Buffer);
  umlBase64EncodeBytes(B, nb);
  Output := umlStringOf(nb);
end;

procedure umlDecodeStreamBASE64(Buffer: umlString; Output: TCoreClassStream);
var
  B, nb: TBytes;
  bak  : Int64;
begin
  B := umlBytesOf(Buffer);
  umlBase64DecodeBytes(B, nb);
  bak := Output.Position;
  Output.WriteBuffer(nb[0], Length(nb));
  Output.Position := bak;
end;

procedure umlEncodeStreamBASE64(Buffer: TCoreClassStream; var Output: umlString);
var
  B, nb: TBytes;
  bak  : Int64;
begin
  bak := Buffer.Position;

  Buffer.Position := 0;
  SetLength(B, Buffer.Size);
  Buffer.ReadBuffer(B[0], Buffer.Size);
  umlBase64EncodeBytes(B, nb);
  Output := umlStringOf(nb);

  Buffer.Position := bak;
end;

procedure umlDivisionBase64Text(Buffer: umlString; width: Integer; DivisionAsPascalString: Boolean; var Output: umlString);
var
  i, n: Integer;
begin
  Output := '';
  n := 0;
  for i := 1 to Buffer.len do
    begin
      if (DivisionAsPascalString) and (n = 0) then
          Output.Append('''');

      Output.Append(Buffer[i]);
      Inc(n);
      if n = width then
        begin
          if DivisionAsPascalString then
              Output.Append('''' + '+' + #13#10)
          else
              Output.Append(#13#10);
          n := 0;
        end;
    end;
  if DivisionAsPascalString then
      Output.Append('''' + ';');
end;

function umlMD5(const BuffPtr: PBYTE; const BuffSize: NativeUInt): TMD5;
type
  TDWordArray = array [0 .. MaxInt div SizeOf(DWORD) - 1] of DWORD;
  PDWordArray = ^TDWordArray;

const
  S11 = 7;
  S12 = 12;
  S13 = 17;
  S14 = 22;

  S21 = 5;
  S22 = 9;
  S23 = 14;
  S24 = 20;

  S31 = 4;
  S32 = 11;
  S33 = 16;
  S34 = 23;

  S41 = 6;
  S42 = 10;
  S43 = 15;
  S44 = 21;

var
  ContextCount : array [0 .. 1] of DWORD;
  ContextState : array [0 .. 4] of DWORD;
  ContextBuffer: array [0 .. 63] of Byte;
  Padding      : array [0 .. 63] of Byte;

  procedure Encode(const Dst: PByteArray; const Src: PDWordArray; const Count: NativeUInt); inline;
  var
    i, j: NativeUInt;
  begin
    i := 0;
    j := 0;
    while (j < Count) do
      begin
        Dst^[j] := Src^[i] and $FF;
        Dst^[j + 1] := (Src^[i] shr 8) and $FF;
        Dst^[j + 2] := (Src^[i] shr 16) and $FF;
        Dst^[j + 3] := (Src^[i] shr 24) and $FF;
        Inc(j, 4);
        Inc(i);
      end;
  end;
  procedure Decode(const Dst: PDWordArray; const Src: PByteArray; const Count, Shift: NativeUInt); inline;
  var
    i, j: NativeUInt;
  begin
    j := 0;
    i := 0;
    while (j < Count) do
      begin
        Dst^[i] := (
          (Src^[j + Shift] and $FF) or
          ((Src^[j + Shift + 1] and $FF) shl 8) or
          ((Src^[j + Shift + 2] and $FF) shl 16) or
          ((Src^[j + Shift + 3] and $FF) shl 24)
          );
        Inc(j, 4);
        Inc(i);
      end;
  end;

  procedure Transform(const Block: PByteArray; const Shift: NativeUInt);
    function f(const x, y, z: DWORD): DWORD; inline;
    begin
      Result := (x and y) or ((not x) and z);
    end;
    function G(const x, y, z: DWORD): DWORD; inline;
    begin
      Result := (x and z) or (y and (not z));
    end;
    function H(const x, y, z: DWORD): DWORD; inline;
    begin
      Result := x xor y xor z;
    end;
    function i(const x, y, z: DWORD): DWORD; inline;
    begin
      Result := y xor (x or (not z));
    end;
    procedure RL(var x: DWORD; const n: Byte); inline;
    begin
      x := (x shl n) or (x shr (32 - n));
    end;
    procedure FF(var a: DWORD; const B, c, d, x: DWORD; const S: Byte; const ac: DWORD); inline;
    begin
      Inc(a, f(B, c, d) + x + ac);
      RL(a, S);
      Inc(a, B);
    end;
    procedure GG(var a: DWORD; const B, c, d, x: DWORD; const S: Byte; const ac: DWORD); inline;
    begin
      Inc(a, G(B, c, d) + x + ac);
      RL(a, S);
      Inc(a, B);
    end;
    procedure HH(var a: DWORD; const B, c, d, x: DWORD; const S: Byte; const ac: DWORD); inline;
    begin
      Inc(a, H(B, c, d) + x + ac);
      RL(a, S);
      Inc(a, B);
    end;
    procedure II(var a: DWORD; const B, c, d, x: DWORD; const S: Byte; const ac: DWORD); inline;
    begin
      Inc(a, i(B, c, d) + x + ac);
      RL(a, S);
      Inc(a, B);
    end;

  var
    a, B, c, d: DWORD;
  var
    x: array [0 .. 15] of DWORD;
  begin
    a := ContextState[0];
    B := ContextState[1];
    c := ContextState[2];
    d := ContextState[3];
    Decode(@x[0], Block, 64, Shift);
    // Round 1
    FF(a, B, c, d, x[0], S11, $D76AA478);  { 1 }
    FF(d, a, B, c, x[1], S12, $E8C7B756);  { 2 }
    FF(c, d, a, B, x[2], S13, $242070DB);  { 3 }
    FF(B, c, d, a, x[3], S14, $C1BDCEEE);  { 4 }
    FF(a, B, c, d, x[4], S11, $F57C0FAF);  { 5 }
    FF(d, a, B, c, x[5], S12, $4787C62A);  { 6 }
    FF(c, d, a, B, x[6], S13, $A8304613);  { 7 }
    FF(B, c, d, a, x[7], S14, $FD469501);  { 8 }
    FF(a, B, c, d, x[8], S11, $698098D8);  { 9 }
    FF(d, a, B, c, x[9], S12, $8B44F7AF);  { 10 }
    FF(c, d, a, B, x[10], S13, $FFFF5BB1); { 11 }
    FF(B, c, d, a, x[11], S14, $895CD7BE); { 12 }
    FF(a, B, c, d, x[12], S11, $6B901122); { 13 }
    FF(d, a, B, c, x[13], S12, $FD987193); { 14 }
    FF(c, d, a, B, x[14], S13, $A679438E); { 15 }
    FF(B, c, d, a, x[15], S14, $49B40821); { 16 }
    // Round 2
    GG(a, B, c, d, x[1], S21, $F61E2562);  { 17 }
    GG(d, a, B, c, x[6], S22, $C040B340);  { 18 }
    GG(c, d, a, B, x[11], S23, $265E5A51); { 19 }
    GG(B, c, d, a, x[0], S24, $E9B6C7AA);  { 20 }
    GG(a, B, c, d, x[5], S21, $D62F105D);  { 21 }
    GG(d, a, B, c, x[10], S22, $2441453);  { 22 }
    GG(c, d, a, B, x[15], S23, $D8A1E681); { 23 }
    GG(B, c, d, a, x[4], S24, $E7D3FBC8);  { 24 }
    GG(a, B, c, d, x[9], S21, $21E1CDE6);  { 25 }
    GG(d, a, B, c, x[14], S22, $C33707D6); { 26 }
    GG(c, d, a, B, x[3], S23, $F4D50D87);  { 27 }
    GG(B, c, d, a, x[8], S24, $455A14ED);  { 28 }
    GG(a, B, c, d, x[13], S21, $A9E3E905); { 29 }
    GG(d, a, B, c, x[2], S22, $FCEFA3F8);  { 30 }
    GG(c, d, a, B, x[7], S23, $676F02D9);  { 31 }
    GG(B, c, d, a, x[12], S24, $8D2A4C8A); { 32 }
    // Round 3
    HH(a, B, c, d, x[5], S31, $FFFA3942);  { 33 }
    HH(d, a, B, c, x[8], S32, $8771F681);  { 34 }
    HH(c, d, a, B, x[11], S33, $6D9D6122); { 35 }
    HH(B, c, d, a, x[14], S34, $FDE5380C); { 36 }
    HH(a, B, c, d, x[1], S31, $A4BEEA44);  { 37 }
    HH(d, a, B, c, x[4], S32, $4BDECFA9);  { 38 }
    HH(c, d, a, B, x[7], S33, $F6BB4B60);  { 39 }
    HH(B, c, d, a, x[10], S34, $BEBFBC70); { 40 }
    HH(a, B, c, d, x[13], S31, $289B7EC6); { 41 }
    HH(d, a, B, c, x[0], S32, $EAA127FA);  { 42 }
    HH(c, d, a, B, x[3], S33, $D4EF3085);  { 43 }
    HH(B, c, d, a, x[6], S34, $4881D05);   { 44 }
    HH(a, B, c, d, x[9], S31, $D9D4D039);  { 45 }
    HH(d, a, B, c, x[12], S32, $E6DB99E5); { 46 }
    HH(c, d, a, B, x[15], S33, $1FA27CF8); { 47 }
    HH(B, c, d, a, x[2], S34, $C4AC5665);  { 48 }
    // Round 4
    II(a, B, c, d, x[0], S41, $F4292244);  { 49 }
    II(d, a, B, c, x[7], S42, $432AFF97);  { 50 }
    II(c, d, a, B, x[14], S43, $AB9423A7); { 51 }
    II(B, c, d, a, x[5], S44, $FC93A039);  { 52 }
    II(a, B, c, d, x[12], S41, $655B59C3); { 53 }
    II(d, a, B, c, x[3], S42, $8F0CCC92);  { 54 }
    II(c, d, a, B, x[10], S43, $FFEFF47D); { 55 }
    II(B, c, d, a, x[1], S44, $85845DD1);  { 56 }
    II(a, B, c, d, x[8], S41, $6FA87E4F);  { 57 }
    II(d, a, B, c, x[15], S42, $FE2CE6E0); { 58 }
    II(c, d, a, B, x[6], S43, $A3014314);  { 59 }
    II(B, c, d, a, x[13], S44, $4E0811A1); { 60 }
    II(a, B, c, d, x[4], S41, $F7537E82);  { 61 }
    II(d, a, B, c, x[11], S42, $BD3AF235); { 62 }
    II(c, d, a, B, x[2], S43, $2AD7D2BB);  { 63 }
    II(B, c, d, a, x[9], S44, $EB86D391);  { 64 }

    Inc(ContextState[0], a);
    Inc(ContextState[1], B);
    Inc(ContextState[2], c);
    Inc(ContextState[3], d);
  end;
  procedure Update(const Value: PBYTE; const Count: NativeUInt);
  var
    i, Index, PartLen, Start: NativeUInt;
  var
    pb: PByteArray;
  begin
    pb := PByteArray(Value);
    index := (ContextCount[0] shr 3) and $3F;

    Inc(ContextCount[0], Count shl 3);
    if ContextCount[0] < (Count shl 3) then
        Inc(ContextCount[1]);

    Inc(ContextCount[1], Count shr (SizeOf(Count) * 8 - 3));

    PartLen := 64 - index;
    if Count >= PartLen then
      begin
        for i := 0 to PartLen - 1 do
            ContextBuffer[i + index] := pb^[i];

        Transform(@ContextBuffer, 0);
        i := PartLen;
        while (i + 63) < Count do
          begin
            Transform(pb, i);
            Inc(i, 64);
          end;
        index := 0;
      end
    else
        i := 0;
    if (i < Count) then
      begin
        Start := i;
        while (i < Count) do
          begin
            ContextBuffer[index + i - Start] := pb^[i];
            Inc(i);
          end;
      end;
  end;

var
  Bits         : array [0 .. 7] of Byte;
  Index, PadLen: NativeUInt;
begin
  FillByte(Padding, 64, 0);
  Padding[0] := $80;
  ContextCount[0] := 0;
  ContextCount[1] := 0;
  ContextState[0] := $67452301;
  ContextState[1] := $EFCDAB89;
  ContextState[2] := $98BADCFE;
  ContextState[3] := $10325476;
  Update(BuffPtr, BuffSize);
  Encode(@Bits, @ContextCount, 8);
  index := (ContextCount[0] shr 3) and $3F;
  if index < 56 then
      PadLen := 56 - index
  else
      PadLen := 120 - index;
  Update(@Padding, PadLen);
  Update(@Bits, 8);
  Encode(@Result, @ContextState, 16);
end;

function umlMD5Char(const BuffPtr: PBYTE; const BuffSize: NativeUInt): umlString;
begin
  Result := umlMD52Str(umlMD5(BuffPtr, BuffSize));
end;

function umlMD5String(const BuffPtr: PBYTE; const BuffSize: NativeUInt): umlString;
begin
  Result := umlMD52Str(umlMD5(BuffPtr, BuffSize));
end;

function umlStreamMD5(Stream: TCoreClassStream; StartPos, EndPos: Int64): TMD5;
type
  TDWordArray = array [0 .. MaxInt div SizeOf(DWORD) - 1] of DWORD;
  PDWordArray = ^TDWordArray;

const
  S11 = 7;
  S12 = 12;
  S13 = 17;
  S14 = 22;

  S21 = 5;
  S22 = 9;
  S23 = 14;
  S24 = 20;

  S31 = 4;
  S32 = 11;
  S33 = 16;
  S34 = 23;

  S41 = 6;
  S42 = 10;
  S43 = 15;
  S44 = 21;

var
  ContextCount : array [0 .. 1] of DWORD;
  ContextState : array [0 .. 4] of DWORD;
  ContextBuffer: array [0 .. 63] of Byte;
  Padding      : array [0 .. 63] of Byte;

  procedure Encode(const Dst: PByteArray; const Src: PDWordArray; const Count: NativeUInt); inline;
  var
    i, j: NativeUInt;
  begin
    i := 0;
    j := 0;
    while (j < Count) do
      begin
        Dst^[j] := Src^[i] and $FF;
        Dst^[j + 1] := (Src^[i] shr 8) and $FF;
        Dst^[j + 2] := (Src^[i] shr 16) and $FF;
        Dst^[j + 3] := (Src^[i] shr 24) and $FF;
        Inc(j, 4);
        Inc(i);
      end;
  end;
  procedure Decode(const Dst: PDWordArray; const Src: PByteArray; const Count, Shift: NativeUInt); inline;
  var
    i, j: NativeUInt;
  begin
    j := 0;
    i := 0;
    while (j < Count) do
      begin
        Dst^[i] := (
          (Src^[j + Shift] and $FF) or
          ((Src^[j + Shift + 1] and $FF) shl 8) or
          ((Src^[j + Shift + 2] and $FF) shl 16) or
          ((Src^[j + Shift + 3] and $FF) shl 24)
          );
        Inc(j, 4);
        Inc(i);
      end;
  end;

  procedure Transform(const Block: PByteArray; const Shift: NativeUInt);
    function f(const x, y, z: DWORD): DWORD; inline;
    begin
      Result := (x and y) or ((not x) and z);
    end;
    function G(const x, y, z: DWORD): DWORD; inline;
    begin
      Result := (x and z) or (y and (not z));
    end;
    function H(const x, y, z: DWORD): DWORD; inline;
    begin
      Result := x xor y xor z;
    end;
    function i(const x, y, z: DWORD): DWORD; inline;
    begin
      Result := y xor (x or (not z));
    end;
    procedure RL(var x: DWORD; const n: Byte); inline;
    begin
      x := (x shl n) or (x shr (32 - n));
    end;
    procedure FF(var a: DWORD; const B, c, d, x: DWORD; const S: Byte; const ac: DWORD); inline;
    begin
      Inc(a, f(B, c, d) + x + ac);
      RL(a, S);
      Inc(a, B);
    end;
    procedure GG(var a: DWORD; const B, c, d, x: DWORD; const S: Byte; const ac: DWORD); inline;
    begin
      Inc(a, G(B, c, d) + x + ac);
      RL(a, S);
      Inc(a, B);
    end;
    procedure HH(var a: DWORD; const B, c, d, x: DWORD; const S: Byte; const ac: DWORD); inline;
    begin
      Inc(a, H(B, c, d) + x + ac);
      RL(a, S);
      Inc(a, B);
    end;
    procedure II(var a: DWORD; const B, c, d, x: DWORD; const S: Byte; const ac: DWORD); inline;
    begin
      Inc(a, i(B, c, d) + x + ac);
      RL(a, S);
      Inc(a, B);
    end;

  var
    a, B, c, d: DWORD;
  var
    x: array [0 .. 15] of DWORD;
  begin
    a := ContextState[0];
    B := ContextState[1];
    c := ContextState[2];
    d := ContextState[3];
    Decode(@x[0], Block, 64, Shift);
    // Round 1
    FF(a, B, c, d, x[0], S11, $D76AA478);  { 1 }
    FF(d, a, B, c, x[1], S12, $E8C7B756);  { 2 }
    FF(c, d, a, B, x[2], S13, $242070DB);  { 3 }
    FF(B, c, d, a, x[3], S14, $C1BDCEEE);  { 4 }
    FF(a, B, c, d, x[4], S11, $F57C0FAF);  { 5 }
    FF(d, a, B, c, x[5], S12, $4787C62A);  { 6 }
    FF(c, d, a, B, x[6], S13, $A8304613);  { 7 }
    FF(B, c, d, a, x[7], S14, $FD469501);  { 8 }
    FF(a, B, c, d, x[8], S11, $698098D8);  { 9 }
    FF(d, a, B, c, x[9], S12, $8B44F7AF);  { 10 }
    FF(c, d, a, B, x[10], S13, $FFFF5BB1); { 11 }
    FF(B, c, d, a, x[11], S14, $895CD7BE); { 12 }
    FF(a, B, c, d, x[12], S11, $6B901122); { 13 }
    FF(d, a, B, c, x[13], S12, $FD987193); { 14 }
    FF(c, d, a, B, x[14], S13, $A679438E); { 15 }
    FF(B, c, d, a, x[15], S14, $49B40821); { 16 }
    // Round 2
    GG(a, B, c, d, x[1], S21, $F61E2562);  { 17 }
    GG(d, a, B, c, x[6], S22, $C040B340);  { 18 }
    GG(c, d, a, B, x[11], S23, $265E5A51); { 19 }
    GG(B, c, d, a, x[0], S24, $E9B6C7AA);  { 20 }
    GG(a, B, c, d, x[5], S21, $D62F105D);  { 21 }
    GG(d, a, B, c, x[10], S22, $2441453);  { 22 }
    GG(c, d, a, B, x[15], S23, $D8A1E681); { 23 }
    GG(B, c, d, a, x[4], S24, $E7D3FBC8);  { 24 }
    GG(a, B, c, d, x[9], S21, $21E1CDE6);  { 25 }
    GG(d, a, B, c, x[14], S22, $C33707D6); { 26 }
    GG(c, d, a, B, x[3], S23, $F4D50D87);  { 27 }
    GG(B, c, d, a, x[8], S24, $455A14ED);  { 28 }
    GG(a, B, c, d, x[13], S21, $A9E3E905); { 29 }
    GG(d, a, B, c, x[2], S22, $FCEFA3F8);  { 30 }
    GG(c, d, a, B, x[7], S23, $676F02D9);  { 31 }
    GG(B, c, d, a, x[12], S24, $8D2A4C8A); { 32 }
    // Round 3
    HH(a, B, c, d, x[5], S31, $FFFA3942);  { 33 }
    HH(d, a, B, c, x[8], S32, $8771F681);  { 34 }
    HH(c, d, a, B, x[11], S33, $6D9D6122); { 35 }
    HH(B, c, d, a, x[14], S34, $FDE5380C); { 36 }
    HH(a, B, c, d, x[1], S31, $A4BEEA44);  { 37 }
    HH(d, a, B, c, x[4], S32, $4BDECFA9);  { 38 }
    HH(c, d, a, B, x[7], S33, $F6BB4B60);  { 39 }
    HH(B, c, d, a, x[10], S34, $BEBFBC70); { 40 }
    HH(a, B, c, d, x[13], S31, $289B7EC6); { 41 }
    HH(d, a, B, c, x[0], S32, $EAA127FA);  { 42 }
    HH(c, d, a, B, x[3], S33, $D4EF3085);  { 43 }
    HH(B, c, d, a, x[6], S34, $4881D05);   { 44 }
    HH(a, B, c, d, x[9], S31, $D9D4D039);  { 45 }
    HH(d, a, B, c, x[12], S32, $E6DB99E5); { 46 }
    HH(c, d, a, B, x[15], S33, $1FA27CF8); { 47 }
    HH(B, c, d, a, x[2], S34, $C4AC5665);  { 48 }
    // Round 4
    II(a, B, c, d, x[0], S41, $F4292244);  { 49 }
    II(d, a, B, c, x[7], S42, $432AFF97);  { 50 }
    II(c, d, a, B, x[14], S43, $AB9423A7); { 51 }
    II(B, c, d, a, x[5], S44, $FC93A039);  { 52 }
    II(a, B, c, d, x[12], S41, $655B59C3); { 53 }
    II(d, a, B, c, x[3], S42, $8F0CCC92);  { 54 }
    II(c, d, a, B, x[10], S43, $FFEFF47D); { 55 }
    II(B, c, d, a, x[1], S44, $85845DD1);  { 56 }
    II(a, B, c, d, x[8], S41, $6FA87E4F);  { 57 }
    II(d, a, B, c, x[15], S42, $FE2CE6E0); { 58 }
    II(c, d, a, B, x[6], S43, $A3014314);  { 59 }
    II(B, c, d, a, x[13], S44, $4E0811A1); { 60 }
    II(a, B, c, d, x[4], S41, $F7537E82);  { 61 }
    II(d, a, B, c, x[11], S42, $BD3AF235); { 62 }
    II(c, d, a, B, x[2], S43, $2AD7D2BB);  { 63 }
    II(B, c, d, a, x[9], S44, $EB86D391);  { 64 }

    Inc(ContextState[0], a);
    Inc(ContextState[1], B);
    Inc(ContextState[2], c);
    Inc(ContextState[3], d);
  end;

  procedure Update(const Value: PBYTE; const Count: NativeUInt);
  var
    i, Index, PartLen, Start: NativeUInt;
    pb                      : PByteArray;
  begin
    pb := PByteArray(Value);
    index := (ContextCount[0] shr 3) and $3F;

    Inc(ContextCount[0], Count shl 3);
    if ContextCount[0] < (Count shl 3) then
        Inc(ContextCount[1]);

    Inc(ContextCount[1], Count shr (SizeOf(Count) * 8 - 3));

    PartLen := 64 - index;
    if Count >= PartLen then
      begin
        for i := 0 to PartLen - 1 do
            ContextBuffer[i + index] := pb^[i];

        Transform(@ContextBuffer, 0);
        i := PartLen;
        while (i + 63) < Count do
          begin
            Transform(pb, i);
            Inc(i, 64);
          end;
        index := 0;
      end
    else
        i := 0;
    if (i < Count) then
      begin
        Start := i;
        while (i < Count) do
          begin
            ContextBuffer[index + i - Start] := pb^[i];
            Inc(i);
          end;
      end;
  end;

  procedure UpdateStreamBuffer();
  var
    i, Index, PartLen, Start      : Int64;
    StreamSize, buffSiz, BuffStart: Int64;
    buff                          : TBytes;
  begin
    StreamSize := EndPos - StartPos;

    index := (ContextCount[0] shr 3) and $3F;

    Inc(ContextCount[0], StreamSize shl 3);
    if ContextCount[0] < (StreamSize shl 3) then
        Inc(ContextCount[1]);

    Inc(ContextCount[1], StreamSize shr 61);

    // default size = 1M;
    buffSiz := 1024 * 1024;

    if StreamSize < buffSiz then
        buffSiz := StreamSize;

    SetLength(buff, buffSiz);

    Stream.Position := StartPos;
    Stream.Read(buff[0], buffSiz);

    PartLen := 64 - index;
    BuffStart := 0;

    if StreamSize >= PartLen then
      begin
        for i := 0 to PartLen - 1 do
            ContextBuffer[i + index] := buff[i];

        Transform(@ContextBuffer, 0);
        i := PartLen;
        while (i + 63) < StreamSize do
          begin
            if BuffStart + 64 > buffSiz then
              begin
                Stream.Position := StartPos + i;
                if Stream.Position + buffSiz > EndPos then
                  begin
                    FillByte(buff[0], buffSiz, 0);
                    Stream.Read(buff[0], EndPos - Stream.Position);
                  end
                else
                    Stream.Read(buff[0], buffSiz);
                BuffStart := 0;
              end;

            Transform(@buff[0], BuffStart);
            Inc(i, 64);
            Inc(BuffStart, 64);
          end;
        index := 0;
      end
    else
        i := 0;

    if (i < StreamSize) then
      begin
        if BuffStart + (StreamSize - i) > buffSiz then
          begin
            Stream.Position := StartPos + i;
            Stream.Read(buff[0], (StreamSize - i));
            BuffStart := 0;
          end;

        Start := i;
        while (i < StreamSize) do
          begin
            ContextBuffer[index + i - Start] := buff[BuffStart];
            Inc(i);
            Inc(BuffStart);
          end;
      end;
  end;

var
  Bits         : array [0 .. 7] of Byte;
  Index, PadLen: NativeUInt;
begin
  FillByte(Padding, 64, 0);
  Padding[0] := $80;
  ContextCount[0] := 0;
  ContextCount[1] := 0;
  ContextState[0] := $67452301;
  ContextState[1] := $EFCDAB89;
  ContextState[2] := $98BADCFE;
  ContextState[3] := $10325476;
  UpdateStreamBuffer;
  // Update(BuffPtr, BuffSize);
  Encode(@Bits, @ContextCount, 8);
  index := (ContextCount[0] shr 3) and $3F;
  if index < 56 then
      PadLen := 56 - index
  else
      PadLen := 120 - index;
  Update(@Padding, PadLen);
  Update(@Bits, 8);
  Encode(@Result, @ContextState, 16);
end;

function umlStreamMD5(Stream: TCoreClassStream): TMD5;
begin
  if Stream.Size <= 0 then
    begin
      Result := NullMD5;
      Exit;
    end;
  Stream.Position := 0;
  Result := umlStreamMD5(Stream, 0, Stream.Size);
  Stream.Position := 0;
end;

function umlStreamMD5Char(Stream: TCoreClassStream): umlString;
begin
  Result := umlMD52Str(umlStreamMD5(Stream));
end;

function umlStreamMD5String(Stream: TCoreClassStream): umlString;
begin
  Result := umlMD52Str(umlStreamMD5(Stream));
end;

function umlStringMD5(const Value: umlString): TMD5;
var
  B: TBytes;
begin
  B := umlBytesOf(Value);
  Result := umlMD5(@B[0], Length(B));
end;

function umlStringMD5Char(const Value: umlString): umlString;
var
  B: TBytes;
begin
  B := umlBytesOf(Value);
  Result := umlMD52Str(umlMD5(@B[0], Length(B)));
end;

function umlMD52Str(md5: TMD5): umlString;
const
  HexArr: array [0 .. 15] of umlChar = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f');
var
  i: Integer;
begin
  Result.len := 32;
  for i := 0 to 15 do
    begin
      Result.buff[i * 2] := HexArr[(md5[i] shr 4) and $0F];
      Result.buff[i * 2 + 1] := HexArr[md5[i] and $0F];
    end;
end;

function umlMD52String(md5: TMD5): umlString;
const
  HexArr: array [0 .. 15] of umlChar = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f');
var
  i: Integer;
begin
  Result.len := 32;
  for i := 0 to 15 do
    begin
      Result.buff[i * 2] := HexArr[(md5[i] shr 4) and $0F];
      Result.buff[i * 2 + 1] := HexArr[md5[i] and $0F];
    end;
end;

function umlMD5Compare(const m1, m2: TMD5): Boolean;
begin
  Result := (PUInt64(@m1[0])^ = PUInt64(@m2[0])^) and (PUInt64(@m1[8])^ = PUInt64(@m2[8])^);
end;

function umlCompareMD5(const m1, m2: TMD5): Boolean;
begin
  Result := (PUInt64(@m1[0])^ = PUInt64(@m2[0])^) and (PUInt64(@m1[8])^ = PUInt64(@m2[8])^);
end;

function umlCRC16(const Value: PBYTE; const Count: NativeUInt): Word;
var
  i: NativeUInt;
var
  pb: PByteArray absolute Value;
begin
  Result := 0;
  for i := 0 to Count - 1 do
      Result := (Result shr 8) xor CRC16Table[pb^[i] xor (Result and $FF)];
end;

function umlStringCRC16(const Value: umlString): Word;
var
  B: TBytes;
begin
  B := umlBytesOf(Value);
  Result := umlCRC16(@B[0], Length(B));
end;

function umlStreamCRC16(Stream: TMixedStream; StartPos, EndPos: Int64): Word;
const
  ChunkSize = 1024 * 1024;
  procedure CRC16BUpdate(var crc: Word; const Buf: Pointer; len: NativeUInt); inline;
  var
    p: PBYTE;
    i: Integer;
  begin
    p := Buf;
    for i := 0 to len - 1 do
      begin
        crc := (crc shr 8) xor CRC16Table[p^ xor (crc and $FF)];
        Inc(p);
      end;
  end;

var
  j    : NativeUInt;
  Num  : NativeUInt;
  Rest : NativeUInt;
  Buf  : Pointer;
  FSize: Int64;
begin
  { Allocate buffer to read file }
  Buf := GetMemory(ChunkSize);
  { Initialize CRC }
  Result := 0;

  { V1.03 calculate how much of the file we are processing }
  FSize := Stream.Size;
  if (StartPos >= FSize) then
      StartPos := 0;
  if (EndPos > FSize) or (EndPos = 0) then
      EndPos := FSize;

  { Calculate number of full chunks that will fit into the buffer }
  Num := EndPos div ChunkSize;
  { Calculate remaining bytes }
  Rest := EndPos mod ChunkSize;

  { Set the stream to the beginning of the file }
  Stream.Position := StartPos;

  { Process full chunks }
  for j := 0 to Num - 1 do begin
      Stream.Read(Buf^, ChunkSize);
      CRC16BUpdate(Result, Buf, ChunkSize);
    end;

  { Process remaining bytes }
  if Rest > 0 then begin
      Stream.Read(Buf^, Rest);
      CRC16BUpdate(Result, Buf, Rest);
    end;

  FreeMem(Buf, ChunkSize);
end;

function umlStreamCRC16(Stream: TMixedStream): Word;
begin
  Stream.Position := 0;
  Result := umlStreamCRC16(Stream, 0, Stream.Size);
  Stream.Position := 0;
end;

function umlCRC32(const Value: PBYTE; const Count: NativeUInt): Cardinal;
var
  i: NativeUInt;
var
  pb: PByteArray absolute Value;
begin
  Result := $FFFFFFFF;
  for i := 0 to Count - 1 do
      Result := ((Result shr 8) and $00FFFFFF) xor CRC32Table[(Result xor pb^[i]) and $FF];
  Result := Result xor $FFFFFFFF;
end;

function umlString2CRC32(const Value: umlString): Cardinal;
var
  B: TBytes;
begin
  B := umlBytesOf(Value);
  Result := umlCRC32(@B[0], Length(B));
end;

function umlStreamCRC32(Stream: TMixedStream; StartPos, EndPos: Int64): Cardinal;
const
  ChunkSize = 1024 * 1024;

  procedure CRC32BUpdate(var crc: Cardinal; const Buf: Pointer; len: NativeUInt); inline;
  var
    p: PBYTE;
    i: Integer;
  begin
    p := Buf;
    for i := 0 to len - 1 do
      begin
        crc := ((crc shr 8) and $00FFFFFF) xor CRC32Table[(crc xor p^) and $FF];
        Inc(p);
      end;
  end;

var
  j    : NativeUInt;
  Num  : NativeUInt;
  Rest : NativeUInt;
  Buf  : Pointer;
  FSize: Int64;
begin
  { Allocate buffer to read file }
  Buf := GetMemory(ChunkSize);

  { Initialize CRC }
  Result := $FFFFFFFF;

  { V1.03 calculate how much of the file we are processing }
  FSize := Stream.Size;
  if (StartPos >= FSize) then
      StartPos := 0;
  if (EndPos > FSize) or (EndPos = 0) then
      EndPos := FSize;

  { Calculate number of full chunks that will fit into the buffer }
  Num := EndPos div ChunkSize;
  { Calculate remaining bytes }
  Rest := EndPos mod ChunkSize;

  { Set the stream to the beginning of the file }
  Stream.Position := StartPos;

  { Process full chunks }
  for j := 0 to Num - 1 do begin
      Stream.Read(Buf^, ChunkSize);
      CRC32BUpdate(Result, Buf, ChunkSize);
    end;

  { Process remaining bytes }
  if Rest > 0 then begin
      Stream.Read(Buf^, Rest);
      CRC32BUpdate(Result, Buf, Rest);
    end;

  FreeMem(Buf, ChunkSize);

  Result := Result xor $FFFFFFFF;
end;

function umlStreamCRC32(Stream: TMixedStream): Cardinal;
begin
  Stream.Position := 0;
  Result := umlStreamCRC32(Stream, 0, Stream.Size);
  Stream.Position := 0;
end;

procedure umlDES(const Input: TDESKey; var Output: TDESKey; const Key: TDESKey; Encrypt: Boolean);
type
  TArrayOf16Bytes = array [1 .. 16] of Byte;
  TArrayOf28Bytes = array [1 .. 28] of Byte;
  TArrayOf32Bytes = array [1 .. 32] of Byte;
  TArrayOf48Bytes = array [1 .. 48] of Byte;
  TArrayOf56Bytes = array [1 .. 56] of Byte;
  TArrayOf64Bytes = array [1 .. 64] of Byte;

  TDesData = record
    InputValue: TArrayOf64Bytes;
    OutputValue: TArrayOf64Bytes;
    RoundKeys: array [1 .. 16] of TArrayOf48Bytes;
    l, r: TArrayOf32Bytes;
    FunctionResult: TArrayOf32Bytes;
    c, d: TArrayOf28Bytes;
  end;

const
  { Initial Permutation }
  IP: TArrayOf64Bytes = (
    58, 50, 42, 34, 26, 18, 10, 2,
    60, 52, 44, 36, 28, 20, 12, 4,
    62, 54, 46, 38, 30, 22, 14, 6,
    64, 56, 48, 40, 32, 24, 16, 8,
    57, 49, 41, 33, 25, 17, 9, 1,
    59, 51, 43, 35, 27, 19, 11, 3,
    61, 53, 45, 37, 29, 21, 13, 5,
    63, 55, 47, 39, 31, 23, 15, 7);
  { Final Permutation }
  InvIP: TArrayOf64Bytes = (
    40, 8, 48, 16, 56, 24, 64, 32,
    39, 7, 47, 15, 55, 23, 63, 31,
    38, 6, 46, 14, 54, 22, 62, 30,
    37, 5, 45, 13, 53, 21, 61, 29,
    36, 4, 44, 12, 52, 20, 60, 28,
    35, 3, 43, 11, 51, 19, 59, 27,
    34, 2, 42, 10, 50, 18, 58, 26,
    33, 1, 41, 9, 49, 17, 57, 25);
  { Expansion Permutation }
  e: TArrayOf48Bytes = (
    32, 1, 2, 3, 4, 5,
    4, 5, 6, 7, 8, 9,
    8, 9, 10, 11, 12, 13,
    12, 13, 14, 15, 16, 17,
    16, 17, 18, 19, 20, 21,
    20, 21, 22, 23, 24, 25,
    24, 25, 26, 27, 28, 29,
    28, 29, 30, 31, 32, 1);
  { P-Box permutation }
  p: TArrayOf32Bytes = (
    16, 7, 20, 21, 29, 12, 28, 17,
    1, 15, 23, 26, 5, 18, 31, 10,
    2, 8, 24, 14, 32, 27, 3, 9,
    19, 13, 30, 6, 22, 11, 4, 25);
  { Key Permutation }
  PC_1: TArrayOf56Bytes = (
    57, 49, 41, 33, 25, 17, 9,
    1, 58, 50, 42, 34, 26, 18,
    10, 2, 59, 51, 43, 35, 27,
    19, 11, 3, 60, 52, 44, 36,
    63, 55, 47, 39, 31, 23, 15,
    7, 62, 54, 46, 38, 30, 22,
    14, 6, 61, 53, 45, 37, 29,
    21, 13, 5, 28, 20, 12, 4);
  { Compression Permutation }
  PC_2: TArrayOf48Bytes = (
    14, 17, 11, 24, 1, 5,
    3, 28, 15, 6, 21, 10,
    23, 19, 12, 4, 26, 8,
    16, 7, 27, 20, 13, 2,
    41, 52, 31, 37, 47, 55,
    30, 40, 51, 45, 33, 48,
    44, 49, 39, 56, 34, 53,
    46, 42, 50, 36, 29, 32);
  { Number of key bits shifted per round }
  ST: TArrayOf16Bytes = (
    1, 1, 2, 2, 2, 2, 2, 2,
    1, 2, 2, 2, 2, 2, 2, 1);
  { S-Boxes }
  SBoxes: array [1 .. 8, 0 .. 3, 0 .. 15] of Byte =
    (((14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7),
    (0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8),
    (4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0),
    (15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13)),

    ((15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10),
    (3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5),
    (0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15),
    (13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9)),

    ((10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8),
    (13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1),
    (13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7),
    (1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12)),

    ((7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15),
    (13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9),
    (10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4),
    (3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14)),

    ((2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9),
    (14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6),
    (4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14),
    (11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3)),

    ((12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11),
    (10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8),
    (9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6),
    (4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13)),

    ((4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1),
    (13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6),
    (1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2),
    (6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12)),

    ((13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7),
    (1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2),
    (7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8),
    (2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11)));

  function GetBit(const Bits: TDESKey; const Index: Byte): Byte; inline;
  var
    idx: Byte;
  begin
    idx := index - 1;
    if Bits[idx div 8] and (128 shr (idx mod 8)) > 0 then
        Result := 1
    else
        Result := 0;
  end;

  procedure SetBit(var Bits: TDESKey; Index, Value: Byte); inline;
  var
    Bit: Byte;
  begin
    Dec(index);
    Bit := 128 shr (index mod 8);
    case Value of
      0: Bits[index div 8] := Bits[index div 8] and (not Bit);
      1: Bits[index div 8] := Bits[index div 8] or Bit;
    end;
  end;

  procedure f(var FR: TArrayOf32Bytes; var FK: TArrayOf48Bytes; var TotalOut: TArrayOf32Bytes); inline;
  var
    Temp1                  : TArrayOf48Bytes;
    Temp2                  : TArrayOf32Bytes;
    n, H, i, j, Row, Column: Cardinal;
  begin
    for n := 1 to 48 do
        Temp1[n] := FR[e[n]] xor FK[n];
    for n := 1 to 8 do
      begin
        i := (n - 1) * 6;
        j := (n - 1) * 4;
        Row := Temp1[i + 1] * 2 + Temp1[i + 6];
        Column := Temp1[i + 2] * 8 + Temp1[i + 3] * 4 +
          Temp1[i + 4] * 2 + Temp1[i + 5];
        for H := 1 to 4 do
          begin
            case H of
              1: Temp2[j + H] := (SBoxes[n, Row, Column] and 8) div 8;
              2: Temp2[j + H] := (SBoxes[n, Row, Column] and 4) div 4;
              3: Temp2[j + H] := (SBoxes[n, Row, Column] and 2) div 2;
              4: Temp2[j + H] := (SBoxes[n, Row, Column] and 1);
            end;
          end;
      end;
    for n := 1 to 32 do
        TotalOut[n] := Temp2[p[n]];
  end;

  procedure Shift(var SubKeyPart: TArrayOf28Bytes); inline;
  var
    n, B: Byte;
  begin
    B := SubKeyPart[1];
    for n := 1 to 27 do
        SubKeyPart[n] := SubKeyPart[n + 1];
    SubKeyPart[28] := B;
  end;

  procedure SubKey(var DesData: TDesData; Round: Byte; var SubKey: TArrayOf48Bytes); inline;
  var
    n, B: Byte;
  begin
    for n := 1 to ST[Round] do
      begin
        Shift(DesData.c);
        Shift(DesData.d);
      end;
    for n := 1 to 48 do
      begin
        B := PC_2[n];
        if B <= 28 then
            SubKey[n] := DesData.c[B]
        else
            SubKey[n] := DesData.d[B - 28];
      end;
  end;

var
  n, B, Round: Byte;
  DesData    : TDesData;
begin
  for n := 1 to 64 do
      DesData.InputValue[n] := GetBit(Input, n);
  for n := 1 to 28 do
    begin
      DesData.c[n] := GetBit(Key, PC_1[n]);
      DesData.d[n] := GetBit(Key, PC_1[n + 28]);
    end;
  for n := 1 to 16 do
      SubKey(DesData, n, DesData.RoundKeys[n]);
  for n := 1 to 64 do
    begin
      if n <= 32 then
          DesData.l[n] := DesData.InputValue[IP[n]]
      else
          DesData.r[n - 32] := DesData.InputValue[IP[n]];
    end;
  for Round := 1 to 16 do
    begin
      if Encrypt then
          f(DesData.r, DesData.RoundKeys[Round], DesData.FunctionResult)
      else
          f(DesData.r, DesData.RoundKeys[17 - Round], DesData.FunctionResult);
      for n := 1 to 32 do
          DesData.FunctionResult[n] := DesData.FunctionResult[n] xor DesData.l[n];
      DesData.l := DesData.r;
      DesData.r := DesData.FunctionResult;
    end;
  for n := 1 to 64 do
    begin
      B := InvIP[n];
      if B <= 32 then
          DesData.OutputValue[n] := DesData.r[B]
      else
          DesData.OutputValue[n] := DesData.l[B - 32];
    end;
  for n := 1 to 64 do
      SetBit(Output, n, DesData.OutputValue[n]);
end;

procedure umlDES(DataPtr: Pointer; Size: Cardinal; const Key: TDESKey; Encrypt: Boolean);
var
  p: NativeUInt;
begin
  p := 0;
  repeat
    umlDES(PDESKey(Pointer(NativeUInt(DataPtr) + p))^, PDESKey(Pointer(NativeUInt(DataPtr) + p))^, Key, Encrypt);
    p := p + 8;
  until p + 8 > Size;
end;

procedure umlDES(DataPtr: Pointer; Size: Cardinal; const Key: umlString; Encrypt: Boolean);
var
  h64: THash64;
begin
  h64 := FastHash64PascalString(@Key);
  umlDES(DataPtr, Size, PDESKey(@h64)^, Encrypt);
end;

procedure umlDES(Input, Output: TMixedStream; const Key: TDESKey; Encrypt: Boolean);
const
  bufflen = 1024 * 1024;
var
  buff: array of Byte;

  procedure FillBuff(Size: Cardinal);
  var
    p: Cardinal;
  begin
    p := 0;

    repeat
      umlDES(PDESKey(@buff[p])^, PDESKey(@buff[p])^, Key, Encrypt);
      p := p + 8;
    until p + 8 > Size;
  end;

var
  l      : Cardinal;
  p, Size: Int64;
begin
  SetLength(buff, bufflen);
  Input.Position := 0;
  p := 0;
  l := bufflen;
  Size := Input.Size;

  if Encrypt then
    begin
      Output.Size := umlInt64Length + Size;
      Output.Position := 0;
      Output.Write(Size, umlInt64Length);

      while p + bufflen < Size do
        begin
          Input.Read(buff[0], l);
          FillBuff(l);
          Output.Write(buff[0], l);
          p := p + l;
        end;

      l := Size - p;
      Input.Read(buff[0], l);
      FillBuff(l);
      Output.Write(buff[0], l);
    end
  else
    begin
      Input.Read(Size, umlInt64Length);
      Output.Size := Size;
      Output.Position := 0;

      while p + bufflen < Size do
        begin
          Input.Read(buff[0], l);
          FillBuff(l);
          Output.Write(buff[0], l);
          p := p + l;
        end;

      l := Size - p;
      Input.Read(buff[0], l);
      FillBuff(l);
      Output.Write(buff[0], l);
    end;
end;

procedure umlDES(Input, Output: TMixedStream; const Key: umlString; Encrypt: Boolean);
var
  h64: THash64;
begin
  h64 := FastHash64PascalString(@Key);
  umlDES(Input, Output, PDESKey(@h64)^, Encrypt);
end;

function umlDESCompare(const d1, d2: TDESKey): Boolean;
begin
  Result := PUInt64(@d1[0])^ = PUInt64(@d2[0])^;
end;

procedure umlFastSymbol(DataPtr: Pointer; Size: Cardinal; const Key: TDESKey; Encrypt: Boolean);
var
  p: NativeUInt;
  i: Integer;
  B: PBYTE;
begin
  i := 0;
  for p := 0 to Size - 1 do
    begin
      B := Pointer(NativeUInt(DataPtr) + p);
      if Encrypt then
          B^ := B^ + Key[i]
      else
          B^ := B^ - Key[i];

      Inc(i);
      if i >= umlDESLength then
          i := 0;
    end;
end;

procedure umlFastSymbol(DataPtr: Pointer; Size: Cardinal; const Key: umlString; Encrypt: Boolean);
var
  h64: THash64;
begin
  h64 := FastHash64PascalString(@Key);
  umlFastSymbol(DataPtr, Size, PDESKey(@h64)^, Encrypt);
end;

function umlTrimSpace(S: umlString): umlString;
var
  i, l: Integer;
begin
  Result := '';
  l := S.len;
  if l > 0 then
    begin
      i := 1;
      while CharIn(S[i], #32#0) do
        begin
          Inc(i);
          if (i > l) then
            begin
              Result := '';
              Exit;
            end;
        end;
      if i > l then
          Result := ''
      else
        begin
          while CharIn(S[i], #32#0) do
            begin
              Dec(l);
              if not(l > 0) then
                begin
                  Result := '';
                  Exit;
                end;
            end;
          Result := S.Copy(i, l - i + 1);
        end;
    end;
end;

function umlSeparatorText(AText: umlString; Dest: TCoreClassStrings; SeparatorChar: umlString): Integer;
var
  ANewText, ASeparatorText: umlString;
begin
  Result := 0;
  if Assigned(Dest) then
    begin
      ANewText := AText;
      ASeparatorText := umlGetFirstStr(ANewText, SeparatorChar);
      while (umlGetLength(ASeparatorText) > 0) and (umlGetLength(ANewText) > 0) do
        begin
          Dest.Add(ASeparatorText.Text);
          Inc(Result);
          ANewText := umlDeleteFirstStr(ANewText, SeparatorChar);
          ASeparatorText := umlGetFirstStr(ANewText, SeparatorChar);
        end;
    end;
end;

function umlStringsMatchText(OriginValue: TCoreClassStrings; DestValue: umlString; IgnoreCase: Boolean = True): Boolean;
var
  i: Integer;
begin
  Result := False;
  if not Assigned(OriginValue) then
      Exit;
  if OriginValue.Count > 0 then
    begin
      for i := 0 to OriginValue.Count - 1 do
        begin
          if umlMultipleMatch(IgnoreCase, OriginValue[i], DestValue) then
            begin
              Result := True;
              Exit;
            end;
        end;
    end;
end;

function umlStringsInExists(Dest: TCoreClassStrings; _Text: umlString; IgnoreCase: Boolean = True): Boolean;
var
  i  : Integer;
  _NS: umlString;
begin
  Result := False;
  if IgnoreCase then
      _NS := umlUpperCase(_Text)
  else
      _NS := _Text;
  if Assigned(Dest) then
    begin
      if Dest.Count > 0 then
        begin
          for i := 0 to Dest.Count - 1 do
            begin
              if ((not IgnoreCase) and (_Text = Dest[i])) or ((IgnoreCase) and (umlSameText(_Text, Dest[i]))) then
                begin
                  Result := True;
                  Exit;
                end;
            end;
        end;
    end;
end;

function umlTextInStrings(_Text: umlString; Dest: TCoreClassStrings; IgnoreCase: Boolean = True): Boolean;
begin
  Result := umlStringsInExists(Dest, _Text, IgnoreCase);
end;

function umlAddNewStrTo(SourceStr: umlString; Dest: TCoreClassStrings; IgnoreCase: Boolean = True): Boolean;
begin
  Result := not umlStringsInExists(Dest, SourceStr, IgnoreCase);
  if Result then
      Dest.Append(SourceStr.Text);
end;

function umlDeleteStrings(_Text: umlString; Dest: TCoreClassStrings; IgnoreCase: Boolean = True): Integer;
var
  i: Integer;
begin
  Result := 0;
  if Assigned(Dest) then
    begin
      if Dest.Count > 0 then
        begin
          i := 0;
          while i < Dest.Count do
            begin
              if ((not IgnoreCase) and (_Text = Dest[i])) or ((IgnoreCase) and (umlMultipleMatch(IgnoreCase, _Text, Dest[i]))) then
                begin
                  Dest.Delete(i);
                  Inc(Result);
                end
              else
                  Inc(i);
            end;
        end;
    end;
end;

function umlDeleteStringsNot(_Text: umlString; Dest: TCoreClassStrings; IgnoreCase: Boolean = True): Integer;
var
  i: Integer;
begin
  Result := 0;
  if Assigned(Dest) then
    begin
      if Dest.Count > 0 then
        begin
          i := 0;
          while i < Dest.Count do
            begin
              if ((not IgnoreCase) and (_Text <> Dest[i])) or ((IgnoreCase) and (not umlMultipleMatch(IgnoreCase, _Text, Dest[i]))) then
                begin
                  Dest.Delete(i);
                  Inc(Result);
                end
              else
                  Inc(i);
            end;
        end;
    end;
end;

function umlMergeStrings(Source, Dest: TCoreClassStrings; IgnoreCase: Boolean = True): Integer;
var
  i: Integer;
begin
  Result := 0;
  if (not Assigned(Source)) or (not Assigned(Dest)) then
      Exit;
  if Source.Count > 0 then
    begin
      for i := 0 to Source.Count - 1 do
        begin
          umlAddNewStrTo(Source[i], Dest, IgnoreCase);
          Inc(Result);
        end;
    end;
end;

function umlConverStrToFileName(Value: umlString): umlString;
var
  i: Integer;
begin
  Result := Value;
  for i := 1 to umlGetLength(Result) do
    begin
      if CharIn(Result[i], '":;/\|<>?*%') then
          Result[i] := ' ';
    end;
end;

function umlLimitTextMatch(_Text, _Limit, _MatchText: umlString; _IgnoreCase: Boolean): Boolean;
var
  _N, _T: umlString;
begin
  Result := True;
  if _MatchText = '' then
      Exit;
  _N := _Text;
  //
  if umlExistsLimitChar(_N, _Limit) then
    begin
      repeat
        _T := umlGetFirstStr(_N, _Limit);
        if umlMultipleMatch(_IgnoreCase, _MatchText, _T) then
            Exit;
        _N := umlDeleteFirstStr(_N, _Limit);
      until _N = '';
    end
  else
    begin
      _T := _N;
      if umlMultipleMatch(_IgnoreCase, _MatchText, _T) then
          Exit;
    end;
  //
  Result := False;
end;

function umlLimitTextTrimSpaceMatch(_Text, _Limit, _MatchText: umlString; _IgnoreCase: Boolean): Boolean;
var
  _N, _T: umlString;
begin
  Result := True;
  if _MatchText = '' then
      Exit;
  _N := _Text;
  //
  if umlExistsLimitChar(_N, _Limit) then
    begin
      repeat
        _T := umlTrimSpace(umlGetFirstStr(_N, _Limit));
        if umlMultipleMatch(_IgnoreCase, _MatchText, _T) then
            Exit;
        _N := umlDeleteFirstStr(_N, _Limit);
      until _N = '';
    end
  else
    begin
      _T := umlTrimSpace(_N);
      if umlMultipleMatch(_IgnoreCase, _MatchText, _T) then
          Exit;
    end;
  //
  Result := False;
end;

function umlLimitDeleteText(_Text, _Limit, _MatchText: umlString; _IgnoreCase: Boolean): umlString;
var
  _N, _T: umlString;
begin
  if (_MatchText = '') or (_Limit = '') then
    begin
      Result := _Text;
      Exit;
    end;
  Result := '';
  _N := _Text;
  //
  if umlExistsLimitChar(_N, _Limit) then
    begin
      repeat
        _T := umlGetFirstStr(_N, _Limit);
        if not umlMultipleMatch(_IgnoreCase, _MatchText, _T) then
          begin
            if Result <> '' then
                Result := Result + _Limit[1] + _T
            else
                Result := _T;
          end;
        _N := umlDeleteFirstStr(_N, _Limit);
      until _N = '';
    end
  else
    begin
      _T := _N;
      if not umlMultipleMatch(_IgnoreCase, _MatchText, _T) then
          Result := _Text;
    end;
end;

function umlLimitTextAsList(_Text, _Limit: umlString; _AsList: TCoreClassStrings): Boolean;
var
  _N, _T: umlString;
begin
  _AsList.Clear;
  _N := _Text;
  //
  if umlExistsLimitChar(_N, _Limit) then
    begin
      repeat
        _T := umlGetFirstStr(_N, _Limit);
        _AsList.Append(_T.Text);
        _N := umlDeleteFirstStr(_N, _Limit);
      until _N = '';
    end
  else
    begin
      _T := _N;
      if umlGetLength(_T) > 0 then
          _AsList.Append(_T.Text);
    end;
  //
  Result := _AsList.Count > 0;
end;

function umlLimitTextAsListAndTrimSpace(_Text, _Limit: umlString; _AsList: TCoreClassStrings): Boolean;
var
  _N, _T: umlString;
begin
  _AsList.Clear;
  _N := _Text;
  //
  if umlExistsLimitChar(_N, _Limit) then
    begin
      repeat
        _T := umlGetFirstStr(_N, _Limit);
        _AsList.Append(umlTrimSpace(_T).Text);
        _N := umlDeleteFirstStr(_N, _Limit);
      until _N = '';
    end
  else
    begin
      _T := _N;
      if umlGetLength(_T) > 0 then
          _AsList.Append(umlTrimSpace(_T).Text);
    end;
  //
  Result := _AsList.Count > 0;
end;

function umlListAsLimitText(_List: TCoreClassStrings; _Limit: umlString): umlString;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to _List.Count - 1 do
    if Result = '' then
        Result := _List[i]
    else
        Result := Result + _Limit + _List[i];
end;

function umlUpdateComponentName(Name: umlString): umlString;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to umlGetLength(name) do
    if umlGetLength(Result) > 0 then
      begin
        if CharIn(name[i], [c0to9, cLoAtoZ, cHiAtoZ], '-') then
            Result := Result + name[i];
      end
    else if CharIn(name[i], [cLoAtoZ, cHiAtoZ]) then
        Result := Result + name[i];
end;

function umlMakeComponentName(OWner: TCoreClassComponent; RefrenceName: umlString): umlString;
var
  c: Cardinal;
begin
  c := 1;
  RefrenceName := umlUpdateComponentName(RefrenceName);
  Result := RefrenceName;
  while OWner.FindComponent(Result.Text) <> nil do
    begin
      Result := RefrenceName + IntToStr(c);
      Inc(c);
    end;
end;

procedure umlReadComponent(Stream: TCoreClassStream; comp: TCoreClassComponent);
var
  r            : TCoreClassReader;
  needClearName: Boolean;
begin
  r := TCoreClassReader.Create(Stream, 4096);
  r.IgnoreChildren := True;
  try
    needClearName := (comp.Name = '');
    r.ReadRootComponent(comp);
    if needClearName then
        comp.Name := '';
  except
  end;
  DisposeObject(r);
end;

procedure umlWriteComponent(Stream: TCoreClassStream; comp: TCoreClassComponent);
var
  W: TCoreClassWriter;
begin
  W := TCoreClassWriter.Create(Stream, 4096);
  W.IgnoreChildren := True;
  W.WriteDescendent(comp, nil);
  DisposeObject(W);
end;

procedure umlCopyComponentDataTo(comp, copyto: TCoreClassComponent);
var
  ms: TCoreClassMemoryStream;
begin
  if comp.ClassType <> copyto.ClassType then
      Exit;
  ms := TCoreClassMemoryStream.Create;
  try
    umlWriteComponent(ms, comp);
    ms.Position := 0;
    umlReadComponent(ms, copyto);
  except
  end;
  DisposeObject(ms);
end;

function umlProcessCycleValue(CurrentVal, DeltaVal, StartVal, OverVal: Single; var EndFlag: Boolean): Single;
  function IfOut(Cur, Delta, Dest: Single): Boolean; inline;
  begin
    if Cur > Dest then
        Result := Cur - Delta < Dest
    else
        Result := Cur + Delta > Dest;
  end;

  function GetOutValue(Cur, Delta, Dest: Single): Single; inline;
  begin
    if IfOut(Cur, Delta, Dest) then
      begin
        if Cur > Dest then
            Result := Dest - (Cur - Delta)
        else
            Result := Cur + Delta - Dest;
      end
    else
        Result := 0;
  end;

  function GetDeltaValue(Cur, Delta, Dest: Single): Single; inline;
  begin
    if Cur > Dest then
        Result := Cur - Delta
    else
        Result := Cur + Delta;
  end;

begin
  if (DeltaVal > 0) and (StartVal <> OverVal) then
    begin
      if EndFlag then
        begin
          if IfOut(CurrentVal, DeltaVal, OverVal) then
            begin
              EndFlag := False;
              Result := umlProcessCycleValue(OverVal, GetOutValue(CurrentVal, DeltaVal, OverVal), StartVal, OverVal, EndFlag);
            end
          else
              Result := GetDeltaValue(CurrentVal, DeltaVal, OverVal);
        end
      else
        begin
          if IfOut(CurrentVal, DeltaVal, StartVal) then
            begin
              EndFlag := True;
              Result := umlProcessCycleValue(StartVal, GetOutValue(CurrentVal, DeltaVal, StartVal), StartVal, OverVal, EndFlag);
            end
          else
              Result := GetDeltaValue(CurrentVal, DeltaVal, StartVal);
        end
    end
  else
      Result := CurrentVal;
end;

end.
