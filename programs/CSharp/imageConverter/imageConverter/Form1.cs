using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using System.Diagnostics;

namespace imageConverter
{
    public partial class Form1 : Form
    {
        public static readonly String VERSION = "1.1.0";
        [System.Runtime.InteropServices.DllImport("kernel32.dll")] 
        private static extern bool AllocConsole();
        public Form1()
        {
            InitializeComponent();
            this.Icon = imageConverter.Properties.Resources.rinaboard;
            this.Text = this.Text +" Ver." + VERSION;
#if DEBUG
            AllocConsole();
            this.Text = this.Text + "(Debug Mode)";
#endif
        }

        //実行するモードをenumで定義
        private enum Mode { AdvancedMonitor, WoolArt }

        //実行ボタンイベント
        private void fileOpenButton_Click(object sender, EventArgs e)
        {
            int mode = -1;
            int height, width;

            if(comboBox1.SelectedItem != null){
                mode = comboBox1.SelectedIndex;
                Common.DEBUG_PRINT("Index:" + mode);
            }
            else {
                showErrorMessage("Modeをえらんで！");
                return;
            }

            //ファイル選択ダイアログを出す
            DialogResult dr = openFileDialog1.ShowDialog();

            if (dr == System.Windows.Forms.DialogResult.OK)
            {
                width   = (int)widthUpDown.Value;
                height  = (int)heightUpDown.Value;

                List<Image> image;
                image=new List<Image>();
                List<String> fname = new List<String>();
                String convertBin = "convert.exe";
                int fcnt = openFileDialog1.FileNames.Length;
                progressBar1.Minimum = 0;
                progressBar1.Maximum = fcnt;
                int pcount = 0;
                foreach (String filename in openFileDialog1.FileNames)
                {
                    if ((Mode)mode == Mode.AdvancedMonitor)
                    {
                        String cmdOption = filename + " -resize " + width.ToString() + "x" + height.ToString() +
                            "! -colors 16 " + Path.GetFileNameWithoutExtension(filename) + ".bmp";
                        ProcessStartInfo psi = new ProcessStartInfo();
                        psi.FileName = convertBin;
                        psi.Arguments = cmdOption;
                        psi.WindowStyle = ProcessWindowStyle.Hidden;
                        psi.CreateNoWindow = true;
                        //Process p = Process.Start(convertBin, cmdOption);
                        Process p = Process.Start(psi);

                        Common.DEBUG_PRINT("Process " + convertBin + " " + cmdOption);
                        p.WaitForExit();
                        image.Add(Image.FromFile(Path.GetFileNameWithoutExtension(filename) + ".bmp"));
                    } else
                    {
                        image.Add(Image.FromFile(filename));
                    }
                    fname.Add(Path.GetFileNameWithoutExtension(filename));
                    pcount++;
                    progressBar1.Value = pcount;
                }
                progressBar1.Value = 0;

                if (doConvert(mode, fname, image, width, height) != 0)
                {
                    showErrorMessage("Convert失敗!w");
                    Common.DEBUG_PRINT("ERROR");
                    return;
                }

                showMessage("完了Ahoy!!");
                Common.DEBUG_PRINT("Finish");
            }
        }

        //Convert実行
        private int doConvert(int mode,List<String> fname, List<Image> img, int width, int height)
        {
            int ret = -1;

            //convert to 16colorBitmap
            List<ColorConvert.ImageStr> imgstr = new List<ColorConvert.ImageStr>();
            int c = 0;
            int imgcnt = img.Count;
            progressBar1.Maximum = imgcnt;
            foreach (Image i in img)
            {

                ColorConvert.ImageStr istr = new ColorConvert.ImageStr();
                //Bitmap b = new Bitmap(width, height);
                Bitmap b = (Bitmap)i;
                //Graphics graphics = Graphics.FromImage(b);
                //System.Drawing.Imaging.ImageAttributes wrapMode = new System.Drawing.Imaging.ImageAttributes();
                //wrapMode.SetWrapMode(System.Drawing.Drawing2D.WrapMode.TileFlipXY);
                //graphics.DrawImage(i, new Rectangle(0, 0, width, height), 0, 0, i.Width, i.Height, GraphicsUnit.Pixel, wrapMode);
                istr.setImage(fname[c], b);
                imgstr.Add(istr);
                c++;
                progressBar1.Value = c;
            }

            ColorConvert cvt = new ColorConvert(imgstr);
            cvt.checkPalette();
#if DEBUG
            pictureBox1.ClientSize = new Size(width, height);
            pictureBox1.Image = (Image)imgstr[0].getBitmap();
#endif
            if (dumpBmp.Checked)
            {
                cvt.saveBitmap();
            }
            //ここでModeごとにクラス呼んで変換を実行
            switch ((Mode)mode)
            {
                case Mode.AdvancedMonitor:
                    Common.DEBUG_PRINT("Mode:AdvancedMonitor");
                    ret = AdvancedMonitor.doConvert(imgstr);
                    break;
            //未実装だからリリースビルドでは実行しない
#if DEBUG
                case Mode.WoolArt:
                    cvt.doColorConvert();
                    Common.DEBUG_PRINT("Mode:WoolArt");
                    ret = WoolArt.doConvert(imgstr[0]);
                    break;
#endif
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
    static class Common
    {
        //DEBUGメッセージ用関数
        public static void DEBUG_PRINT(String msg)
        {
#if DEBUG
            Console.WriteLine("[DEBUG]:" + msg);
#endif
        }
    }
}
