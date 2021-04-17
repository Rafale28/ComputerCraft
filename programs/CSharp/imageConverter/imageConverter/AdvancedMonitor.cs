using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;
using System.IO;

namespace imageConverter
{
    static class AdvancedMonitor
    {
        private static int check(Color src)
        {
            //透明の時は黒くなる
            int num = 15;

            //透明じゃないとき
            if (src.A != 0)
            {
                for (int i = 0; i < 16; i++)
                {
                    if (src.R == ColorConvert.colorArray[i].R &&
                        src.G == ColorConvert.colorArray[i].G &&
                        src.B == ColorConvert.colorArray[i].B)
                    {
                        num = i;
                        break;
                    }
                }
            }
            return num;
        }
        private static int checkPaletteColor(Color c, List<Color> colorList)
        {
            int ret = 0;
            for(int cnt=0; cnt < colorList.Count; cnt++)
            {
                if (c.R == colorList[cnt].R &&
                    c.G == colorList[cnt].G &&
                    c.B == colorList[cnt].B)
                {
                    ret = cnt;
                }
            }
            return ret;
        }
        private static void dumpColor(String fn, List<Color> clist)
        {
            StreamWriter writer = new StreamWriter(fn +".clist");
            for (int i=0; i < clist.Count; i++)
            {
                Common.DEBUG_PRINT("COLOR R:" + clist[i].R + " G:" + clist[i].G + " B:" + clist[i].B);
                //writer.WriteLine("term.setPaletteColour(colors." + ColorConvert.colorString[i] + ", 0x" + clist[i].R.ToString("X02") + clist[i].G.ToString("X02") + clist[i].B.ToString("X02") + ")");
                writer.WriteLine((1 << i).ToString());
                writer.WriteLine("0x" + clist[i].R.ToString("X02") + clist[i].G.ToString("X02") + clist[i].B.ToString("X02"));
            }
            writer.Close();
        }
        public static int doConvert(List<ColorConvert.ImageStr> img)
        {
            foreach (ColorConvert.ImageStr i in img)
            {
                Common.DEBUG_PRINT("Convert to AdvancedMonitor format...");
                StreamWriter writer = new StreamWriter(i.getFileName()+".nfp");
                int bmpWidth = i.getBitmap().Width;
                int bmpHeight = i.getBitmap().Height;
                int num = -1;
                dumpColor(i.getFileName(), i.getColorList());
                for (int hCount = 0; hCount < bmpHeight; hCount++)
                {
                    for (int wCount = 0; wCount < bmpWidth; wCount++)
                    {
                        //num = check(i.getBitmap().GetPixel(wCount, hCount));
                        num = checkPaletteColor(i.getBitmap().GetPixel(wCount, hCount), i.getColorList());
                        writer.Write(num.ToString("x"));
                    }
                    writer.Write("\n");
                }
                writer.Close();
            }
            Common.DEBUG_PRINT("Color Convert finished");
            return 0;
        }
    }
}
