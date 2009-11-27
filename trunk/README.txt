To build you will need to do this:
1. install NSIS (http://nsis.sourceforge.net/Main_Page)
2. download a binary distribution of Ant 1.7.1 from here: http://ant.apache.org/bindownload.cgi
and extract it so that the folder named "apache-ant-1.7.0" is in the same directory as winant.nsi and info.txt
3. download a binary distribution of ant-contrib from here: http://ant-contrib.sourceforge.net/ and extract it so that the "ant-contrib" folder is in the same directory as winant.nsi

Then run the NSIS compiler on winant.nsi and that should build the installer for you.
