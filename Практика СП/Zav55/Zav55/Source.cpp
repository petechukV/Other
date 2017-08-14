#include <Windows.h>
#include<string>
using namespace std;
#include <CommCtrl.h>
#pragma comment(lib, "ComCtl32.Lib")
#define ID_BUTTON_1 3000
char window_name[] = "Завдання 3.1";

HWND hBtn1;
HWND TextBox, TextBox1, SendButton, TextField, labelX, labelY, labelR;
HINSTANCE hInstan;
LRESULT CALLBACK win_proc(HWND wp_hWnd, UINT wp_uMsg, WPARAM wp_wParam, LPARAM wp_lParam);
ATOM RegMyWindowClass(HINSTANCE, LPCTSTR);

extern "C"
double FUNC1(double x);

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE, LPSTR IpCmdLine, int nCmdShow)
{



	MSG msg_;
	HWND hWnd;
	WNDCLASSEX wc;
	wc.cbSize = sizeof(wc);
	wc.style = CS_HREDRAW | CS_VREDRAW;
	wc.lpfnWndProc = win_proc;
	wc.cbWndExtra = NULL;
	wc.cbClsExtra = NULL;
	wc.hbrBackground = HBRUSH(COLOR_WINDOW + 1);
	wc.lpszMenuName = NULL;
	wc.lpszClassName = window_name;
	wc.hIconSm = NULL;

	wc.hInstance = GetModuleHandle(NULL);
	wc.hIcon = LoadIcon(NULL, IDI_APPLICATION);
	wc.hCursor = LoadCursor(NULL, IDC_ARROW);

	RegisterClassEx(&wc);
	hWnd = CreateWindowEx(
		NULL,
		window_name,
		window_name,
		WS_OVERLAPPEDWINDOW,
		500,
		300,
		260,
		150,
		NULL,
		(HMENU)NULL,
		wc.hInstance,
		NULL);

	ShowWindow(hWnd, SW_SHOWNORMAL);
	UpdateWindow(hWnd);
	while (GetMessage(&msg_, NULL, NULL, NULL)) {
		TranslateMessage(&msg_);
		DispatchMessage(&msg_);
	}
	return msg_.wParam;
}

LRESULT CALLBACK win_proc(HWND wp_hWnd, UINT wp_uMsg, WPARAM wp_wParam, LPARAM wp_lParam) {
	switch (wp_uMsg)
	{
	case WM_CREATE:
		TextBox = CreateWindow("EDIT",
			"",
			WS_BORDER | WS_CHILD | WS_VISIBLE,
			45, 20, 160, 25,
			wp_hWnd, (HMENU)1, NULL, NULL);

		SendButton = CreateWindow("BUTTON",
			"Значення Y(x)=",
			WS_VISIBLE | WS_CHILD | WS_BORDER,
			55, 50, 140, 25,
			wp_hWnd, (HMENU)2, NULL, NULL);

		TextField = CreateWindow("EDIT",
			"",
			WS_VISIBLE | WS_CHILD | WS_BORDER | ES_READONLY,
			45, 80, 160, 25,
			wp_hWnd, (HMENU)3, NULL, NULL);

		labelX = CreateWindow("static", "X =",
			WS_VISIBLE | WS_CHILD | WS_TABSTOP,
			10, 23, 30, 17, wp_hWnd, (HMENU)4, (HINSTANCE)GetWindowLong(wp_hWnd, GWL_HINSTANCE), NULL);

		labelY = CreateWindow("static", "Y =",
			WS_VISIBLE | WS_CHILD | WS_TABSTOP,
			10, 83, 30, 17, wp_hWnd, (HMENU)4, (HINSTANCE)GetWindowLong(wp_hWnd, GWL_HINSTANCE), NULL);

		break;

	case WM_COMMAND:
		/*BITMAP hImage = LoadImage(NULL, "12.bmp", IMAGE_BITMAP, 100, 100, LR_LOADFROMFILE);
		SendMessage(hwnd, STM_SETIMAGE, IMAGE_BITMAP, (LPARAM)hImage);*/

		switch (wp_wParam) {
		case 2:

			char buffer[256];
			char buffer1[256];

			GetWindowText(TextBox, buffer, lstrlen(buffer));
			string tmp = (string)buffer;
			double x = atof(tmp.c_str());
			tmp = (string)buffer1;
			double result = FUNC1(x);
			string str = to_string(result);
			SetWindowText(TextField, str.c_str());
			break;
		}
		break;

	case WM_DESTROY:
		PostQuitMessage(0);
		break;
	case WM_LBUTTONDOWN:

	default:
		return DefWindowProc(wp_hWnd, wp_uMsg, wp_wParam, wp_lParam);
	}
	return 0;
}