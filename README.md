# pasc500-compiler-in-C-language
Flex execution

flex compiler.l    # This command generates lex.yy.c
gcc lex.yy.c -lfl  # This command builds lex.yy.c to an executable
./a.exe Tests/test.cpp # WINDOWS: Execute Lexical analyzer on Tests/test.cpp
./a Tests/test.cpp     # LINUX: Execute Lexical analyzer on Tests/test.cpp

Bison execution
make                             # Automatically build all necessary files
./bison <Directory/TestFile.cpp> # Execute Lexical Analysis on the testfile.
