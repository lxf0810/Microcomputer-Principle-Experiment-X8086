@ECHO OFF
d:\masm32\ml /c /Zd /Zi /Zm /Zf %1
set str=%1
set str=%str:~0,-4%
d:\masm32\link /CODEVIEW /NOD /DEB /DEBUGB  /STACK:1024 %str%.obj,%str%.exe,nul.map,,