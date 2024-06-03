using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace awesome_exam
{
    /// <summary>
    /// Логика взаимодействия для AuthWindow.xaml
    /// </summary>
    public partial class AuthWindow : Window
    {
        public AuthWindow()
        {
            InitializeComponent();
        }

        private void AuthButton_Click(object sender, RoutedEventArgs e)
        {
            var UAuth = ClassHelper.EF.Context.User.ToList().Where(i => i.Login == TbLogin.Text && i.Password == PbPassword.Password).FirstOrDefault();
            var EmpAuth = ClassHelper.EF.Context.Employee.ToList().Where(i => i.Login == TbLogin.Text && i.Password == PbPassword.Password).FirstOrDefault();
            if (UAuth != null)
            {
                MainWindow mainWindow = new MainWindow();
                mainWindow.Show();
                this.Close();
            }
            else if (EmpAuth != null)
            {

            }
            else
            {
                MessageBox.Show("Пользователя не существует", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }


        }
    }
}
