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
            int num = -1;
            
            for (int i=0; i < 16; i++)
            {
                if (src.R == ColorConvert.colorArray[i].R && 
                    src.G == ColorConvert.colorArray[i].G && 
                    src.B == ColorConvert.colorArray[i].B )
                {
                    num = i;
                    break;
                }
            }
            return num;
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
                for (int hCount = 0; hCount < bmpHeight; hCount++)
                {
                    for (int wCount = 0; wCount < bmpWidth; wCount++)
                    {
                        num = check(i.getBitmap().GetPixel(wCount, hCount));
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
