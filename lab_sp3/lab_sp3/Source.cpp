#include <iostream>
using namespace std;
int main() {
	double a, b,res;
	double c = 2.0, f = -5.0, d=-2;	
	do {
		cout << "Insert>a ""\n";
		cin >> a;
		while (a == 69) { return 0; };
		cout << "Insert>b ""\n";
		cin >> b;		
		if (a > b) {
			_asm
			{
				fld c
				fld st(0)				
				fld b
				fld st(1)
				fld a
				fld st(2)
				fadd st, st(1)
				fdiv st, st(2)
				fstp res
				fstp st(3)
			}
			cout <<"result "<< res << endl;
			cout << " " << endl;
		}else 
			if (a == b) {
				_asm
				{
					fld d
					fld st
					fstp res
					fstp st(4)
				}
				cout << "result " << res << endl;
				cout << " " << endl;
			}else
				if (a < b) {
					_asm
					{
						fld f
						fld st(2)
						fld b
						fld st(1)
						fld a
						fld st(0)
						fsub st(0) ,st(2)
						fdiv st(0) ,st(1)
						fstp res
						fstp st(5)
					}
					cout << "result " << res << endl;
					cout << " " << endl;
				}
	} while (a != 69);
}