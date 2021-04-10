using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace imageConverter
{
    public partial class Form1 : Form
    {
        [System.Runtime.InteropServices.DllImport("kernel32.dll")] 
        private static extern bool AllocConsole();
        public Form1()
        {
            InitializeComponent();
#if DEBUG
            AllocConsole();
#endif
        }

        //実行するモードをenumで定義
        private enum Mode { AdvancedMonitor, WoolArt }

        //実行ボタンイベント
        private void fileOpenButton_Click(object sender, EventArgs e)
        {
            int mode = -1;
            int ret = -1;
            if(comboBox1.SelectedItem != null){
                //mode = comboBox1.SelectedItem.ToString();
                mode = comboBox1.SelectedIndex;
#if DEBUG
                Console.WriteLine("Index:" + mode);
#endif
            }
            else {
                showErrorMessage("Modeをえらんで！");
                return;
            }
            DialogResult dr = openFileDialog1.ShowDialog();
            if (dr == System.Windows.Forms.DialogResult.OK)
            {
                Image image = Image.FromFile(openFileDialog1.FileName);
                if (doConvert(mode, image) != 0)
                {
                    showErrorMessage("Convert失敗!w");
                    return;
                }
                showMessage("完了Ahoy!!");
            }
        }

        //Convert実行
        private int doConvert(int mode, Image img)
        {
            int ret = -1;
            //convert to 16colorBitmap

            //ここでModeごとにクラス呼んで変換を実行
            switch ((Mode)mode)
            {
                case Mode.AdvancedMonitor:
#if DEBUG
                    Console.WriteLine("Mode:AdvancedMonitor");
#endif
                    AdvancedMonitor amon = new AdvancedMonitor();
                    ret = amon.doConvert(img);
                    break;
                case Mode.WoolArt:
#if DEBUG
                    Console.WriteLine("Mode:WoolArt");
#endif
                    WoolArt wart = new WoolArt();
                    ret = wart.doConvert(img);
                    break;
                default:
                    ret = -1;
                    break;
            }
            return ret;
        }

        //ErrorMessage表示
        private void showErrorMessage(string errmsg)
        {
                MessageBox.Show(errmsg, 
                    "Error", 
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error);
        }
        private void showMessage(string msg)
        {
                MessageBox.Show(msg, 
                    "MSG", 
                    MessageBoxButtons.OK,
                    MessageBoxIcon.None);
        }
    }
}
