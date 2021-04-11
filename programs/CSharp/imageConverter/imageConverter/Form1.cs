﻿using System;
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
            this.Text = this.Text + "(Debug Mode)";
#endif
        }

        //実行するモードをenumで定義
        private enum Mode { AdvancedMonitor, WoolArt }

        //実行ボタンイベント
        private void fileOpenButton_Click(object sender, EventArgs e)
        {
            int mode = -1;
            int ret = -1;
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
                Image image = Image.FromFile(openFileDialog1.FileName);

                if (doConvert(mode, image, width, height) != 0)
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
        private int doConvert(int mode, Image img, int width, int height)
        {
            int ret = -1;
            //convert to 16colorBitmap
            Bitmap bmp = new Bitmap(width, height);
            Graphics graphics = Graphics.FromImage(bmp);
            System.Drawing.Imaging.ImageAttributes wrapMode = new System.Drawing.Imaging.ImageAttributes();
            wrapMode.SetWrapMode(System.Drawing.Drawing2D.WrapMode.TileFlipXY);
            graphics.DrawImage(img, new Rectangle(0, 0, width, height), 0, 0, img.Width, img.Height, GraphicsUnit.Pixel, wrapMode);

            ColorConvert cvt = new ColorConvert(bmp);
            cvt.doColorConvert();
#if DEBUG
            pictureBox1.ClientSize = new Size(width, height);
            pictureBox1.Image = (Image)bmp;
            cvt.saveBitmap();
#endif

            //ここでModeごとにクラス呼んで変換を実行
            switch ((Mode)mode)
            {
                case Mode.AdvancedMonitor:
                    Common.DEBUG_PRINT("Mode:AdvancedMonitor");
                    ret = AdvancedMonitor.doConvert(cvt.getBitmap());
                    break;
                case Mode.WoolArt:
                    Common.DEBUG_PRINT("Mode:WoolArt");
                    ret = WoolArt.doConvert(cvt.getBitmap());
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