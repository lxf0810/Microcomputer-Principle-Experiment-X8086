@ECHO OFF
c:\masm32\ml /c /Zd /Zi /Zm /Zf %1
set str=%1
set str=%str:~0,-4%
c:\masm32\link /CODEVIEW /NOD /DEB /DEBUGB  /STACK:1024 %str%.obj,%str%.exe,nul.map,,