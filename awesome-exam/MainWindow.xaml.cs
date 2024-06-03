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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace awesome_exam
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            GetList();
            LoadComboBox();
        }
        private void GetList()
        {
            DataGrid.ItemsSource = ClassHelper.EF.Context.UserOrderDataView.ToList();
        }

        private void LoadComboBox()
        {
            ComboBoxFullName.ItemsSource = ClassHelper.EF.Context.UserOrderDataView.Select(u => u.FullName).Distinct().ToList();
            ComboBoxFullName.SelectedIndex = 0;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            var selectedFullName = ComboBoxFullName.SelectedItem as string;
            DataGrid.ItemsSource = ClassHelper.EF.Context.UserOrderDataView
                                    .Where(u => u.FullName == selectedFullName)
                                    .ToList();

        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            GetList();
        }

        private void SortData_Click(object sender, RoutedEventArgs e)
        {
            var selectedColumn = ComboBoxSortColumn.SelectedItem as ComboBoxItem;
            bool ascending = RadioButtonAscending.IsChecked == true;
            bool descending = RadioButtonDescending.IsChecked == true;

            if (selectedColumn == null || (!ascending && !descending))
            {
                MessageBox.Show("Пожалуйста, выберите столбец и направление сортировки.");
                return;
            }

            var data = ClassHelper.EF.Context.UserOrderDataView.ToList();

            switch (selectedColumn.Content.ToString())
            {
                case "Дата":
                    if (ascending)
                        data = data.OrderBy(u => u.SaleDate).ToList();
                    else if (descending)
                        data = data.OrderByDescending(u => u.SaleDate).ToList();
                    break;
                case "Статус":
                    if (ascending)
                        data = data.OrderBy(u => u.Title).ToList();
                    else if (descending)
                        data = data.OrderByDescending(u => u.Title).ToList();
                    break;
                case "ФИО":
                    if (ascending)
                        data = data.OrderBy(u => u.FullName).ToList();
                    else if (descending)
                        data = data.OrderByDescending(u => u.FullName).ToList();
                    break;
            }

            DataGrid.ItemsSource = data;
        }
    }
}

