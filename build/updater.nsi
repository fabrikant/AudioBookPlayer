; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "ABPlayer"
!define PRODUCT_VERSION "2.0.0"
!define PRODUCT_PUBLISHER "AlexDev505"
!define PRODUCT_WEB_SITE "https://github.com/AlexDev505/ABPlayer"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\ABPlayer.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma
AutoCloseWindow true

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "sources\icon.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Instfiles page
!insertmacro MUI_PAGE_INSTFILES

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "Russian"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME}"
OutFile "updaters\ABPlayerUpdate.${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\ABPlayer"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

!define IfFileLocked "!insertmacro _IfFileLocked"

!macro _IfFileLocked label
  ClearErrors
  FileOpen $0 "$INSTDIR\ABPlayer.exe" w
  IfErrors ${label}
  FileClose $0
!macroend

Section "ABPlayer" SEC01
  SetOverwrite try
  SetOutPath "$INSTDIR"
  FileIsLocked:
    ${IfFileLocked} FileLocked
    File "ABPlayer\ABPlayer.exe"

    SetOutPath "$INSTDIR\_internal\static\css"
    File "ABPlayer\_internal\static\css\base.css"
    File "ABPlayer\_internal\static\css\book.css"
    File "ABPlayer\_internal\static\css\dark_theme.css"
    File "ABPlayer\_internal\static\css\downloads.css"
    File "ABPlayer\_internal\static\css\library.css"
    File "ABPlayer\_internal\static\css\light_theme.css"
    File "ABPlayer\_internal\static\css\search.css"
    File "ABPlayer\_internal\static\css\settings.css"
    SetOutPath "$INSTDIR\_internal\static\images"
    File "ABPlayer\_internal\static\images\angle_down.svg"
    File "ABPlayer\_internal\static\images\angle_left.svg"
    File "ABPlayer\_internal\static\images\angle_right.svg"
    File "ABPlayer\_internal\static\images\book.svg"
    File "ABPlayer\_internal\static\images\box-arrow-up-right.svg"
    File "ABPlayer\_internal\static\images\calendar.svg"
    File "ABPlayer\_internal\static\images\check.svg"
    File "ABPlayer\_internal\static\images\clock.svg"
    File "ABPlayer\_internal\static\images\cross.svg"
    File "ABPlayer\_internal\static\images\dash.svg"
    File "ABPlayer\_internal\static\images\double_angle_left.svg"
    File "ABPlayer\_internal\static\images\double_angle_right.svg"
    File "ABPlayer\_internal\static\images\download.svg"
    File "ABPlayer\_internal\static\images\filter.svg"
    File "ABPlayer\_internal\static\images\folder.svg"
    File "ABPlayer\_internal\static\images\hdd.svg"
    File "ABPlayer\_internal\static\images\hide_menu.svg"
    File "ABPlayer\_internal\static\images\icon.ico"
    File "ABPlayer\_internal\static\images\icon.png"
    File "ABPlayer\_internal\static\images\line.svg"
    File "ABPlayer\_internal\static\images\loading.gif"
    File "ABPlayer\_internal\static\images\loading_app.gif"
    File "ABPlayer\_internal\static\images\low_volume.svg"
    File "ABPlayer\_internal\static\images\medium_volume.svg"
    File "ABPlayer\_internal\static\images\menu.svg"
    File "ABPlayer\_internal\static\images\mic.svg"
    File "ABPlayer\_internal\static\images\mute.svg"
    File "ABPlayer\_internal\static\images\overlay.svg"
    File "ABPlayer\_internal\static\images\pause.svg"
    File "ABPlayer\_internal\static\images\person.svg"
    File "ABPlayer\_internal\static\images\play.svg"
    File "ABPlayer\_internal\static\images\plus.svg"
    File "ABPlayer\_internal\static\images\resize_bottom_right.svg"
    File "ABPlayer\_internal\static\images\search.svg"
    File "ABPlayer\_internal\static\images\settings.svg"
    File "ABPlayer\_internal\static\images\sort_down.svg"
    File "ABPlayer\_internal\static\images\sort_up.svg"
    File "ABPlayer\_internal\static\images\square.svg"
    File "ABPlayer\_internal\static\images\star.svg"
    File "ABPlayer\_internal\static\images\star_fill.svg"
    File "ABPlayer\_internal\static\images\tag.svg"
    File "ABPlayer\_internal\static\images\trash.svg"
    File "ABPlayer\_internal\static\images\volume.svg"
    File "ABPlayer\_internal\static\images\watch.svg"
    File "ABPlayer\_internal\static\images\window.svg"
    File "ABPlayer\_internal\static\images\x.svg"
    SetOutPath "$INSTDIR\_internal\static\js"
    File "ABPlayer\_internal\static\js\base.js"
    File "ABPlayer\_internal\static\js\book.js"
    File "ABPlayer\_internal\static\js\downloads.js"
    File "ABPlayer\_internal\static\js\library.js"
    File "ABPlayer\_internal\static\js\search.js"
    File "ABPlayer\_internal\static\js\settings.js"
    SetOutPath "$INSTDIR\_internal\templates"
    File "ABPlayer\_internal\templates\base.html"
    File "ABPlayer\_internal\templates\book.html"
    File "ABPlayer\_internal\templates\downloads.html"
    File "ABPlayer\_internal\templates\library.html"
    File "ABPlayer\_internal\templates\search.html"
    File "ABPlayer\_internal\templates\settings.html"
    File "ABPlayer\_internal\templates\starting_window.html"

    Goto Done
  FileLocked:
    Goto FileIsLocked
  Done:
SectionEnd

Section -Post
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\ABPlayer.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\ABPlayer.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

Function .OnInstSuccess
  SetOutPath "$INSTDIR"
  Exec "ABPlayer.exe"
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "�������� ��������� $(^Name) ���� ������� ���������."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "�� ������� � ���, ��� ������� ������� $(^Name) � ��� ���������� ���������?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\uninst.exe"
  
  Delete "$INSTDIR\ABPlayer.exe"
  Delete "$INSTDIR\_internal\api-ms-win-core-console-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-datetime-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-debug-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-errorhandling-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-file-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-file-l1-2-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-file-l2-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-handle-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-heap-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-interlocked-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-libraryloader-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-localization-l1-2-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-memory-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-namedpipe-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-processenvironment-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-processthreads-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-processthreads-l1-1-1.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-profile-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-rtlsupport-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-string-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-synch-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-synch-l1-2-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-sysinfo-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-timezone-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-core-util-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-crt-conio-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-crt-convert-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-crt-environment-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-crt-filesystem-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-crt-heap-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-crt-locale-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-crt-math-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-crt-process-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-crt-runtime-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-crt-stdio-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-crt-string-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-crt-time-l1-1-0.dll"
  Delete "$INSTDIR\_internal\api-ms-win-crt-utility-l1-1-0.dll"
  Delete "$INSTDIR\_internal\base_library.zip"
  Delete "$INSTDIR\_internal\libcrypto-3.dll"
  Delete "$INSTDIR\_internal\libffi-8.dll"
  Delete "$INSTDIR\_internal\libssl-3.dll"
  Delete "$INSTDIR\_internal\pyexpat.pyd"
  Delete "$INSTDIR\_internal\python312.dll"
  Delete "$INSTDIR\_internal\select.pyd"
  Delete "$INSTDIR\_internal\sqlite3.dll"
  Delete "$INSTDIR\_internal\ucrtbase.dll"
  Delete "$INSTDIR\_internal\unicodedata.pyd"
  Delete "$INSTDIR\_internal\VCRUNTIME140.dll"
  Delete "$INSTDIR\_internal\_asyncio.pyd"
  Delete "$INSTDIR\_internal\_bz2.pyd"
  Delete "$INSTDIR\_internal\_cffi_backend.cp312-win_amd64.pyd"
  Delete "$INSTDIR\_internal\_ctypes.pyd"
  Delete "$INSTDIR\_internal\_decimal.pyd"
  Delete "$INSTDIR\_internal\_elementtree.pyd"
  Delete "$INSTDIR\_internal\_hashlib.pyd"
  Delete "$INSTDIR\_internal\_lzma.pyd"
  Delete "$INSTDIR\_internal\_multiprocessing.pyd"
  Delete "$INSTDIR\_internal\_overlapped.pyd"
  Delete "$INSTDIR\_internal\_queue.pyd"
  Delete "$INSTDIR\_internal\_socket.pyd"
  Delete "$INSTDIR\_internal\_sqlite3.pyd"
  Delete "$INSTDIR\_internal\_ssl.pyd"
  Delete "$INSTDIR\_internal\_uuid.pyd"
  Delete "$INSTDIR\_internal\_wmi.pyd"
  Delete "$INSTDIR\_internal\_zoneinfo.pyd"
  Delete "$INSTDIR\_internal\bin\ffprobe.exe"
  Delete "$INSTDIR\_internal\certifi\cacert.pem"
  Delete "$INSTDIR\_internal\certifi\py.typed"
  Delete "$INSTDIR\_internal\charset_normalizer\md.cp312-win_amd64.pyd"
  Delete "$INSTDIR\_internal\charset_normalizer\md__mypyc.cp312-win_amd64.pyd"
  Delete "$INSTDIR\_internal\clr_loader\ffi\dlls\amd64\ClrLoader.dll"
  Delete "$INSTDIR\_internal\clr_loader\ffi\dlls\x86\ClrLoader.dll"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_ARC4.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_chacha20.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_pkcs1_decode.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_raw_aes.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_raw_aesni.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_raw_arc2.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_raw_blowfish.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_raw_cast.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_raw_cbc.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_raw_cfb.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_raw_ctr.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_raw_des.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_raw_des3.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_raw_ecb.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_raw_eksblowfish.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_raw_ocb.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_raw_ofb.pyd"
  Delete "$INSTDIR\_internal\Crypto\Cipher\_Salsa20.pyd"
  Delete "$INSTDIR\_internal\Crypto\Hash\_BLAKE2b.pyd"
  Delete "$INSTDIR\_internal\Crypto\Hash\_BLAKE2s.pyd"
  Delete "$INSTDIR\_internal\Crypto\Hash\_ghash_clmul.pyd"
  Delete "$INSTDIR\_internal\Crypto\Hash\_ghash_portable.pyd"
  Delete "$INSTDIR\_internal\Crypto\Hash\_keccak.pyd"
  Delete "$INSTDIR\_internal\Crypto\Hash\_MD2.pyd"
  Delete "$INSTDIR\_internal\Crypto\Hash\_MD4.pyd"
  Delete "$INSTDIR\_internal\Crypto\Hash\_MD5.pyd"
  Delete "$INSTDIR\_internal\Crypto\Hash\_poly1305.pyd"
  Delete "$INSTDIR\_internal\Crypto\Hash\_RIPEMD160.pyd"
  Delete "$INSTDIR\_internal\Crypto\Hash\_SHA1.pyd"
  Delete "$INSTDIR\_internal\Crypto\Hash\_SHA224.pyd"
  Delete "$INSTDIR\_internal\Crypto\Hash\_SHA256.pyd"
  Delete "$INSTDIR\_internal\Crypto\Hash\_SHA384.pyd"
  Delete "$INSTDIR\_internal\Crypto\Hash\_SHA512.pyd"
  Delete "$INSTDIR\_internal\Crypto\Math\_modexp.pyd"
  Delete "$INSTDIR\_internal\Crypto\Protocol\_scrypt.pyd"
  Delete "$INSTDIR\_internal\Crypto\PublicKey\_ec_ws.pyd"
  Delete "$INSTDIR\_internal\Crypto\PublicKey\_ed25519.pyd"
  Delete "$INSTDIR\_internal\Crypto\PublicKey\_ed448.pyd"
  Delete "$INSTDIR\_internal\Crypto\PublicKey\_x25519.pyd"
  Delete "$INSTDIR\_internal\Crypto\Util\_cpuid_c.pyd"
  Delete "$INSTDIR\_internal\Crypto\Util\_strxor.pyd"
  Delete "$INSTDIR\_internal\flask-3.0.1.dist-info\entry_points.txt"
  Delete "$INSTDIR\_internal\flask-3.0.1.dist-info\INSTALLER"
  Delete "$INSTDIR\_internal\flask-3.0.1.dist-info\LICENSE.rst"
  Delete "$INSTDIR\_internal\flask-3.0.1.dist-info\METADATA"
  Delete "$INSTDIR\_internal\flask-3.0.1.dist-info\RECORD"
  Delete "$INSTDIR\_internal\flask-3.0.1.dist-info\REQUESTED"
  Delete "$INSTDIR\_internal\flask-3.0.1.dist-info\WHEEL"
  Delete "$INSTDIR\_internal\markupsafe\_speedups.cp312-win_amd64.pyd"
  Delete "$INSTDIR\_internal\orjson\orjson.cp312-win_amd64.pyd"
  Delete "$INSTDIR\_internal\pythonnet\runtime\Python.Runtime.dll"
  Delete "$INSTDIR\_internal\static\css\base.css"
  Delete "$INSTDIR\_internal\static\css\book.css"
  Delete "$INSTDIR\_internal\static\css\dark_theme.css"
  Delete "$INSTDIR\_internal\static\css\downloads.css"
  Delete "$INSTDIR\_internal\static\css\library.css"
  Delete "$INSTDIR\_internal\static\css\light_theme.css"
  Delete "$INSTDIR\_internal\static\css\search.css"
  Delete "$INSTDIR\_internal\static\css\settings.css"
  Delete "$INSTDIR\_internal\static\images\angle_down.svg"
  Delete "$INSTDIR\_internal\static\images\angle_left.svg"
  Delete "$INSTDIR\_internal\static\images\angle_right.svg"
  Delete "$INSTDIR\_internal\static\images\book.svg"
  Delete "$INSTDIR\_internal\static\images\box-arrow-up-right.svg"
  Delete "$INSTDIR\_internal\static\images\calendar.svg"
  Delete "$INSTDIR\_internal\static\images\check.svg"
  Delete "$INSTDIR\_internal\static\images\clock.svg"
  Delete "$INSTDIR\_internal\static\images\cross.svg"
  Delete "$INSTDIR\_internal\static\images\dash.svg"
  Delete "$INSTDIR\_internal\static\images\double_angle_left.svg"
  Delete "$INSTDIR\_internal\static\images\double_angle_right.svg"
  Delete "$INSTDIR\_internal\static\images\download.svg"
  Delete "$INSTDIR\_internal\static\images\filter.svg"
  Delete "$INSTDIR\_internal\static\images\folder.svg"
  Delete "$INSTDIR\_internal\static\images\hdd.svg"
  Delete "$INSTDIR\_internal\static\images\hide_menu.svg"
  Delete "$INSTDIR\_internal\static\images\icon.ico"
  Delete "$INSTDIR\_internal\static\images\icon.png"
  Delete "$INSTDIR\_internal\static\images\line.svg"
  Delete "$INSTDIR\_internal\static\images\loading.gif"
  Delete "$INSTDIR\_internal\static\images\loading_app.gif"
  Delete "$INSTDIR\_internal\static\images\low_volume.svg"
  Delete "$INSTDIR\_internal\static\images\medium_volume.svg"
  Delete "$INSTDIR\_internal\static\images\menu.svg"
  Delete "$INSTDIR\_internal\static\images\mic.svg"
  Delete "$INSTDIR\_internal\static\images\mute.svg"
  Delete "$INSTDIR\_internal\static\images\overlay.svg"
  Delete "$INSTDIR\_internal\static\images\pause.svg"
  Delete "$INSTDIR\_internal\static\images\person.svg"
  Delete "$INSTDIR\_internal\static\images\play.svg"
  Delete "$INSTDIR\_internal\static\images\plus.svg"
  Delete "$INSTDIR\_internal\static\images\resize_bottom_right.svg"
  Delete "$INSTDIR\_internal\static\images\search.svg"
  Delete "$INSTDIR\_internal\static\images\settings.svg"
  Delete "$INSTDIR\_internal\static\images\sort_down.svg"
  Delete "$INSTDIR\_internal\static\images\sort_up.svg"
  Delete "$INSTDIR\_internal\static\images\square.svg"
  Delete "$INSTDIR\_internal\static\images\star.svg"
  Delete "$INSTDIR\_internal\static\images\star_fill.svg"
  Delete "$INSTDIR\_internal\static\images\tag.svg"
  Delete "$INSTDIR\_internal\static\images\trash.svg"
  Delete "$INSTDIR\_internal\static\images\volume.svg"
  Delete "$INSTDIR\_internal\static\images\watch.svg"
  Delete "$INSTDIR\_internal\static\images\window.svg"
  Delete "$INSTDIR\_internal\static\images\x.svg"
  Delete "$INSTDIR\_internal\static\js\base.js"
  Delete "$INSTDIR\_internal\static\js\book.js"
  Delete "$INSTDIR\_internal\static\js\downloads.js"
  Delete "$INSTDIR\_internal\static\js\library.js"
  Delete "$INSTDIR\_internal\static\js\search.js"
  Delete "$INSTDIR\_internal\static\js\settings.js"
  Delete "$INSTDIR\_internal\templates\base.html"
  Delete "$INSTDIR\_internal\templates\book.html"
  Delete "$INSTDIR\_internal\templates\downloads.html"
  Delete "$INSTDIR\_internal\templates\library.html"
  Delete "$INSTDIR\_internal\templates\search.html"
  Delete "$INSTDIR\_internal\templates\settings.html"
  Delete "$INSTDIR\_internal\templates\starting_window.html"
  Delete "$INSTDIR\_internal\webview\lib\Microsoft.Web.WebView2.Core.dll"
  Delete "$INSTDIR\_internal\webview\lib\Microsoft.Web.WebView2.WinForms.dll"
  Delete "$INSTDIR\_internal\webview\lib\WebBrowserInterop.x64.dll"
  Delete "$INSTDIR\_internal\webview\lib\WebBrowserInterop.x86.dll"
  Delete "$INSTDIR\_internal\webview\lib\runtimes\win-arm64\native\WebView2Loader.dll"
  Delete "$INSTDIR\_internal\webview\lib\runtimes\win-x64\native\WebView2Loader.dll"
  Delete "$INSTDIR\_internal\webview\lib\runtimes\win-x86\native\WebView2Loader.dll"
  Delete "$INSTDIR\_internal\werkzeug-3.0.1.dist-info\INSTALLER"
  Delete "$INSTDIR\_internal\werkzeug-3.0.1.dist-info\LICENSE.rst"
  Delete "$INSTDIR\_internal\werkzeug-3.0.1.dist-info\METADATA"
  Delete "$INSTDIR\_internal\werkzeug-3.0.1.dist-info\RECORD"
  Delete "$INSTDIR\_internal\werkzeug-3.0.1.dist-info\WHEEL"
  Delete "$INSTDIR\_internal\wheel-0.42.0.dist-info\entry_points.txt"
  Delete "$INSTDIR\_internal\wheel-0.42.0.dist-info\INSTALLER"
  Delete "$INSTDIR\_internal\wheel-0.42.0.dist-info\LICENSE.txt"
  Delete "$INSTDIR\_internal\wheel-0.42.0.dist-info\METADATA"
  Delete "$INSTDIR\_internal\wheel-0.42.0.dist-info\RECORD"
  Delete "$INSTDIR\_internal\wheel-0.42.0.dist-info\REQUESTED"
  Delete "$INSTDIR\_internal\wheel-0.42.0.dist-info\WHEEL"

  RMDir "$INSTDIR\_internal\wheel-0.42.0.dist-info"
  RMDir "$INSTDIR\_internal\werkzeug-3.0.1.dist-info"
  RMDir "$INSTDIR\_internal\webview\lib\runtimes\win-x86\native"
  RMDir "$INSTDIR\_internal\webview\lib\runtimes\win-x86"
  RMDir "$INSTDIR\_internal\webview\lib\runtimes\win-x64\native"
  RMDir "$INSTDIR\_internal\webview\lib\runtimes\win-x64"
  RMDir "$INSTDIR\_internal\webview\lib\runtimes\win-arm64\native"
  RMDir "$INSTDIR\_internal\webview\lib\runtimes\win-arm64"
  RMDir "$INSTDIR\_internal\webview\lib\runtimes"
  RMDir "$INSTDIR\_internal\webview\lib"
  RMDir "$INSTDIR\_internal\webview"
  RMDir "$INSTDIR\_internal\templates"
  RMDir "$INSTDIR\_internal\static\js"
  RMDir "$INSTDIR\_internal\static\images"
  RMDir "$INSTDIR\_internal\static\css"
  RMDir "$INSTDIR\_internal\static"
  RMDir "$INSTDIR\_internal\pythonnet\runtime"
  RMDir "$INSTDIR\_internal\pythonnet"
  RMDir "$INSTDIR\_internal\orjson"
  RMDir "$INSTDIR\_internal\markupsafe"
  RMDir "$INSTDIR\_internal\flask-3.0.1.dist-info"
  RMDir "$INSTDIR\_internal\Crypto\Util"
  RMDir "$INSTDIR\_internal\Crypto\PublicKey"
  RMDir "$INSTDIR\_internal\Crypto\Protocol"
  RMDir "$INSTDIR\_internal\Crypto\Math"
  RMDir "$INSTDIR\_internal\Crypto\Hash"
  RMDir "$INSTDIR\_internal\Crypto\Cipher"
  RMDir "$INSTDIR\_internal\Crypto"
  RMDir "$INSTDIR\_internal\clr_loader\ffi\dlls\x86"
  RMDir "$INSTDIR\_internal\clr_loader\ffi\dlls\amd64"
  RMDir "$INSTDIR\_internal\clr_loader\ffi\dlls"
  RMDir "$INSTDIR\_internal\clr_loader\ffi"
  RMDir "$INSTDIR\_internal\clr_loader"
  RMDir "$INSTDIR\_internal\charset_normalizer"
  RMDir "$INSTDIR\_internal\certifi"
  RMDir "$INSTDIR\_internal\bin"
  RMDir "$INSTDIR\_internal"
  RMDir "$INSTDIR"

  Delete "$LocalAppData\AudioBookPlayer\debug.log"
  Delete "$LocalAppData\AudioBookPlayer\library.sqlite"
  Delete "$LocalAppData\AudioBookPlayer\config.json"
  Delete "$LocalAppData\AudioBookPlayer\temp.txt"
  RMDir "$LocalAppData\AudioBookPlayer"

  Delete "$DESKTOP\ABPlayer.lnk"
  Delete "$SMPROGRAMS\ABPlayer.lnk"
  
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd