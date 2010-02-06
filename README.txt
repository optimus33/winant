To build you will need to do this:
1. install NSIS (http://nsis.sourceforge.net/Main_Page)
2. download a binary distribution of Ant 1.7.1 from here: http://ant.apache.org/bindownload.cgi
and extract it so that the folder named "apache-ant-1.7.1" is in the same directory as winant.nsi and info.txt
3. download a binary distribution of ant-contrib from here: http://ant-contrib.sourceforge.net/ and extract it so that the "ant-contrib" folder is in the same directory as winant.nsi
4. update the changelog and other relevant bits of info.txt
5. be sure to up the version number in winant.nsi
6. run the NSIS compiler on winant.nsi