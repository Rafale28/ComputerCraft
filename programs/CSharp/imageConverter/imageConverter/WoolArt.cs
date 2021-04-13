using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;
using System.IO;

namespace imageConverter
{
    static class WoolArt
    {
        private static int check(Color src)
        {
            int num = -1;
            
            //透明じゃないとき
            if (src.A != 0) {

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

        public static int doConvert(ColorConvert.ImageStr img)
        {
            Common.DEBUG_PRINT("Convert to WoolArt...");

            StreamWriter writer = new StreamWriter(img.getFileName() + ".nfp");
            int bmpWidth = img.getBitmap().Width;
            int bmpHeight = img.getBitmap().Height;
            int num = -1;
            for (int hCount = 0; hCount < bmpHeight; hCount++)
            {
                for (int wCount = 0; wCount < bmpWidth; wCount++)
                {
                    num = check(img.getBitmap().GetPixel(wCount, hCount));
                    writer.Write(num.ToString()+",");
                }
                writer.Write("\n");
            }
            writer.Close();
            Common.DEBUG_PRINT("Color Convert finished");
            
            return 0;
        }
    }
}
