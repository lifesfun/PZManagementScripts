#include <string>
#include <fstream>
#include <iostream>
using namespace std;

//pzchunk Tools for manipulating bin files for pz
int main( int argc , char* argv[] ){ 

    cout << "The similar files are:" ; 

    const char* mapsPath = argv[1] ;
    ifstream mapsFile( mapsPath ) ;
    if( !mapsFile ){ cout << "No Maps" ; return 1 ; }
    string mapsLine ;

    const char* freshPath = argv[2] ;
    ifstream freshFile( freshPath ) ;
    if( !freshFile ){ cout << "No Fresh" ; return 1 ; }
    string freshLine ; 

    while( getline( mapsFile , mapsLine ) ){

                        cout << mapsLine ;
        while( getline( freshFile , freshLine) ){

                        cout << freshLine;
                if( ! mapsLine.compare( freshLine ) ){

                        cout << mapsLine ;
                }
        }
    }
    return 0 ;
}
