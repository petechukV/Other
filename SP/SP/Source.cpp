#include <iostream>
#include <time.h>
#include <stdio.h>
using namespace std;
class M {
	int x;
public: M(int X) :x(X) {}M func(M&m) {
	m.x *= x;
	return *this;
}
		void disp() { cout << x << " "; }
};
int inc5(int &x) { return x + 1; }

void main(void) {
	int x5 = 10; cout << (inc5(x5) + 10) << " "; cout << x5 << endl;
	//M a(10), b(20);
	//a.func(b).disp();
//	b.disp();
	/*const int n = 10;
	int a[n], i, s = 0;
	srand(time(NULL));
	for (i = 0; i < n; i++)s += (!((a[i] = rand() % 10) %2 ));
	cout << s;*///suma rand nepar
	/*union tcod { char sim;
	struct { int x : 5;
	int y : 3;;'m;
	}hh;
	};
	/////////////////////////////////////////
	tcod cod;
	cod.hh.x = 4;
	cod.hh.y = 2;
	cout << "\n"<<' '<<sizeof(cod)<<' '<<cod.sim;*///4d
	cout << "zavdany' za 2008" << "\n"; 
/*	const int N=500, M=10;
	int a[N], st[M];
	int p, j, i;
	for (i = 0; M - i; st[i++] = 0);
	for (i = 0; N - 1; st[a[i++]]++);
	for (p=i=0;N-i;i++)
		for(j=-1;st[i]-++j;a[p++]=i)*/
	/*int x = 0, y = 0, z = 0;
	++y+=y+++z + --x + ++++y + x+++z;
	cout << x <<' '<< y <<' '<< z;*/
	
	system("pause >>void");
}