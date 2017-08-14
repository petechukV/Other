#include <Windows.h>
char class_name[] = "Windows class 1";
char window_name[] = "Win32 assembly ";
char wnd_text[] = "Hello my king";

LRESULT CALLBACK win_proc(HWND wp_hWnd, UINT wp_uMsg, WPARAM wp_wParam, LPARAM wp_lParam);

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE, LPSTR IpCmdLine, int nCmdShow)
{
	MSG msg_;
	HWND hWnd;
	WNDCLASSEX wc;
	wc.cbSize = sizeof(wc);
	wc.style = CS_HREDRAW|CS_VREDRAW;
	wc.lpfnWndProc = win_proc;
	wc.cbWndExtra = NULL;
	wc.cbClsExtra = NULL;
	wc.hbrBackground = HBRUSH(COLOR_WINDOW + 1);
	wc.lpszMenuName = NULL;
	wc.lpszClassName = class_name;
	wc.hIconSm = NULL;

	wc.hInstance = GetModuleHandle(NULL);
	wc.hIcon = LoadIcon(NULL, IDI_APPLICATION);
	wc.hCursor = LoadCursor(NULL, IDC_ARROW);

	RegisterClassEx(&wc);
	hWnd = CreateWindowEx(
		NULL,
		class_name,
		window_name,
		WS_OVERLAPPEDWINDOW,
		CW_USEDEFAULT,
		CW_USEDEFAULT,
		CW_USEDEFAULT,
		CW_USEDEFAULT,
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
	case WM_DESTROY:
		PostQuitMessage(0);
		break;
	case WM_LBUTTONDOWN:
		SetWindowText(wp_hWnd, wnd_text);
	default:
		return DefWindowProc(wp_hWnd, wp_uMsg, wp_wParam, wp_lParam);
	}
	return 0;
}