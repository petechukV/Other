#include "MyForm.h"

using namespace System;
using namespace System::Windows::Forms;
using namespace System::Drawing;

[STAThreadAttribute]
void Main(array<String^>^ args)
{
	Application::EnableVisualStyles();
	Application::SetCompatibleTextRenderingDefault(false);
	pract_zav3::MyForm form;
	Application::Run(%form);
}