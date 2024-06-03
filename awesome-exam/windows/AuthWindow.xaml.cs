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

namespace awesome_exam.windows
{
    /// <summary>
    /// Логика взаимодействия для AuthWindow.xaml
    /// </summary>
    public partial class AuthWindow : Window
    {
        DB.Employee employee = null;
        DB.User user = null;

        public AuthWindow()
        {
            InitializeComponent();
        }


        private void btnSignIn_Click_1(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(PbPassword.Password) && string.IsNullOrEmpty(TbLogin.Text))
            {
                employee = helper.EF.Context.Employees.ToList().Where(i => i.Password == PbPassword.Password && i.Login == TbLogin.Text).FirstOrDefault();
                user = helper.EF.Context.Users.ToList().Where(i => i.Password == PbPassword.Password && i.Login == TbLogin.Text).FirstOrDefault();

                if (user != null)
                {
                    ClientWindow client = new ClientWindow();
                }

                else if (employee != null)
                {
                    ClientWindow client = new ClientWindow();
                }
                else
                {
                    MessageBox.Show("Пользователя не существует", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
           
        }
    }
}
