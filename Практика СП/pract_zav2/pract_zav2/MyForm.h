#pragma once
#include <iostream>
namespace pract_zav2 {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;
	extern "C" { 
		double FUNC1(double a);
	    double FUNC2(double a1, double b, double c1);
	}
	/// <summary>
	/// Сводка для MyForm
	/// </summary>
	public ref class MyForm : public System::Windows::Forms::Form
	{
	public:
		MyForm(void)
		{
			InitializeComponent();
			//
			//TODO: добавьте код конструктора
			//
		}

	protected:
		/// <summary>
		/// Освободить все используемые ресурсы.
		/// </summary>
		~MyForm()
		{
			if (components)
			{
				delete components;
			}
		}
	private: System::Windows::Forms::Label^  label1;
	protected:

	private: System::Windows::Forms::Button^  button2;
	private: System::Windows::Forms::TextBox^  num1;
	private: System::Windows::Forms::TextBox^  num2;
	private: System::Windows::Forms::TextBox^  num3;
	private: System::Windows::Forms::Label^  label2;
	private: System::Windows::Forms::Label^  label3;
	private: System::Windows::Forms::CheckBox^  checkBox1;
	private: System::Windows::Forms::Button^  button1;




	private:
		/// <summary>
		/// Обязательная переменная конструктора.
		/// </summary>
		System::ComponentModel::Container ^components;

#pragma region Windows Form Designer generated code
		/// <summary>
		/// Требуемый метод для поддержки конструктора — не изменяйте 
		/// содержимое этого метода с помощью редактора кода.
		/// </summary>
		void InitializeComponent(void)
		{
			System::ComponentModel::ComponentResourceManager^  resources = (gcnew System::ComponentModel::ComponentResourceManager(MyForm::typeid));
			this->label1 = (gcnew System::Windows::Forms::Label());
			this->button2 = (gcnew System::Windows::Forms::Button());
			this->num1 = (gcnew System::Windows::Forms::TextBox());
			this->num2 = (gcnew System::Windows::Forms::TextBox());
			this->num3 = (gcnew System::Windows::Forms::TextBox());
			this->label2 = (gcnew System::Windows::Forms::Label());
			this->label3 = (gcnew System::Windows::Forms::Label());
			this->checkBox1 = (gcnew System::Windows::Forms::CheckBox());
			this->button1 = (gcnew System::Windows::Forms::Button());
			this->SuspendLayout();
			// 
			// label1
			// 
			this->label1->AutoSize = true;
			this->label1->Font = (gcnew System::Drawing::Font(L"Times New Roman", 14.25F, System::Drawing::FontStyle::Italic, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(204)));
			this->label1->Location = System::Drawing::Point(12, 10);
			this->label1->Name = L"label1";
			this->label1->Size = System::Drawing::Size(34, 21);
			this->label1->TabIndex = 0;
			this->label1->Text = L"A=";
			this->label1->Click += gcnew System::EventHandler(this, &MyForm::label1_Click);
			// 
			// button2
			// 
			this->button2->Font = (gcnew System::Drawing::Font(L"Microsoft Sans Serif", 8.25F, System::Drawing::FontStyle::Regular, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(204)));
			this->button2->Location = System::Drawing::Point(16, 170);
			this->button2->Name = L"button2";
			this->button2->Size = System::Drawing::Size(111, 25);
			this->button2->TabIndex = 2;
			this->button2->Text = L"Обчислити вираз 1";
			this->button2->UseVisualStyleBackColor = true;
			this->button2->Click += gcnew System::EventHandler(this, &MyForm::button2_Click);
			// 
			// num1
			// 
			this->num1->Location = System::Drawing::Point(52, 13);
			this->num1->Name = L"num1";
			this->num1->Size = System::Drawing::Size(45, 21);
			this->num1->TabIndex = 3;
			this->num1->TextChanged += gcnew System::EventHandler(this, &MyForm::num1_TextChanged);
			// 
			// num2
			// 
			this->num2->Location = System::Drawing::Point(13, 127);
			this->num2->Name = L"num2";
			this->num2->Size = System::Drawing::Size(111, 21);
			this->num2->TabIndex = 4;
			this->num2->TextChanged += gcnew System::EventHandler(this, &MyForm::num2_TextChanged);
			// 
			// num3
			// 
			this->num3->Location = System::Drawing::Point(174, 127);
			this->num3->Name = L"num3";
			this->num3->Size = System::Drawing::Size(111, 21);
			this->num3->TabIndex = 5;
			// 
			// label2
			// 
			this->label2->AutoSize = true;
			this->label2->Font = (gcnew System::Drawing::Font(L"Times New Roman", 10.25F, System::Drawing::FontStyle::Regular, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(204)));
			this->label2->Location = System::Drawing::Point(10, 54);
			this->label2->Name = L"label2";
			this->label2->Size = System::Drawing::Size(116, 48);
			this->label2->TabIndex = 6;
			this->label2->Text = L"       cos(a)+sin(a)\r\nZ1=-----------------\r\n       cos(a)-sin(a)";
			this->label2->Click += gcnew System::EventHandler(this, &MyForm::label2_Click);
			// 
			// label3
			// 
			this->label3->AutoSize = true;
			this->label3->Font = (gcnew System::Drawing::Font(L"Times New Roman", 10.25F, System::Drawing::FontStyle::Regular, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(204)));
			this->label3->Location = System::Drawing::Point(171, 70);
			this->label3->Name = L"label3";
			this->label3->Size = System::Drawing::Size(119, 16);
			this->label3->TabIndex = 7;
			this->label3->Text = L" Z2=tg(2a)+sec(2a)";
			// 
			// checkBox1
			// 
			this->checkBox1->AutoSize = true;
			this->checkBox1->Font = (gcnew System::Drawing::Font(L"Microsoft Sans Serif", 10.25F, System::Drawing::FontStyle::Regular, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(204)));
			this->checkBox1->Location = System::Drawing::Point(174, 10);
			this->checkBox1->Name = L"checkBox1";
			this->checkBox1->Size = System::Drawing::Size(125, 21);
			this->checkBox1->TabIndex = 8;
			this->checkBox1->Text = L"Значення рівні";
			this->checkBox1->UseVisualStyleBackColor = true;
			this->checkBox1->CheckedChanged += gcnew System::EventHandler(this, &MyForm::checkBox1_CheckedChanged);
			// 
			// button1
			// 
			this->button1->Font = (gcnew System::Drawing::Font(L"Microsoft Sans Serif", 8.25F, System::Drawing::FontStyle::Regular, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(204)));
			this->button1->Location = System::Drawing::Point(174, 170);
			this->button1->Name = L"button1";
			this->button1->Size = System::Drawing::Size(111, 25);
			this->button1->TabIndex = 9;
			this->button1->Text = L"Обчислити вираз 2";
			this->button1->UseVisualStyleBackColor = true;
			this->button1->Click += gcnew System::EventHandler(this, &MyForm::button1_Click_1);
			// 
			// MyForm
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 14);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->AutoSize = true;
			this->BackColor = System::Drawing::Color::OldLace;
			this->ClientSize = System::Drawing::Size(304, 207);
			this->Controls->Add(this->button1);
			this->Controls->Add(this->checkBox1);
			this->Controls->Add(this->label3);
			this->Controls->Add(this->label2);
			this->Controls->Add(this->num3);
			this->Controls->Add(this->num2);
			this->Controls->Add(this->num1);
			this->Controls->Add(this->button2);
			this->Controls->Add(this->label1);
			this->Font = (gcnew System::Drawing::Font(L"Microsoft Tai Le", 8.25F, System::Drawing::FontStyle::Regular, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(204)));
			this->Icon = (cli::safe_cast<System::Drawing::Icon^>(resources->GetObject(L"$this.Icon")));
			this->Name = L"MyForm";
			this->Text = L"Практика";
			this->ResumeLayout(false);
			this->PerformLayout();

		}
#pragma endregion
		
	private: System::Void label1_Click(System::Object^  sender, System::EventArgs^  e) {
	}
	private: System::Void label2_Click(System::Object^  sender, System::EventArgs^  e) {
	}
private: System::Void button2_Click(System::Object^  sender, System::EventArgs^  e) {
	double a = System::Convert::ToDouble(num1->Text);
	double z1 = FUNC1(a);
	num2->Text = z1.ToString();	
	if (num3->Text == num2->Text) {
		checkBox1->Checked = true;
	}
	else if (num3->Text != num2->Text) {
		checkBox1->Checked = false;
	}
}
private: System::Void button1_Click(System::Object^  sender, System::EventArgs^  e) {
	
}
private: System::Void checkBox1_CheckedChanged(System::Object^  sender, System::EventArgs^  e) {
}
private: System::Void num1_TextChanged(System::Object^  sender, System::EventArgs^  e) {
}
private: System::Void num2_TextChanged(System::Object^  sender, System::EventArgs^  e) {
}
private: System::Void button1_Click_1(System::Object^  sender, System::EventArgs^  e) {
	double a1 = System::Convert::ToDouble(num1->Text);
	double b = 1;
	double c1 = 2;
	double z2 = FUNC2(a1, b, c1);
	num3->Text = z2.ToString();
	if (num3->Text == num2->Text) {
		checkBox1->Checked = true;
	}
	else if (num3->Text != num2->Text) {
		checkBox1->Checked = false;
	}
}
};
}
