#include<iostream>
#include <time.h>
using namespace std;
int main()
{
	double a,time_t;
	int res;
	cout << " Insert>a ";
	cin >> a;
	_asm
	{
		fild a
		fxch st(0)
		fstp res
	}
	cout << " Resualt: " << res << endl;
	cout << " Time: " <<time << endl;
	system("pause>>void");
}