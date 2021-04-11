using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;

namespace imageConverter
{
    class ColorConvert
    {
        private Bitmap img;
        public ColorConvert(Bitmap srcImg)
        {
            img = srcImg;
        }

        public static Color[] colorArray = { 
            Color.White,
            Color.Orange,
            Color.Magenta,
            Color.LightBlue,
            Color.Yellow,
            Color.Lime,
            Color.Pink,
            Color.Gray,
            Color.LightGray,
            Color.Cyan,
            Color.Purple,
            Color.Blue,
            Color.Brown,
            Color.Green,
            Color.Red,
            Color.Black
        };

        private static double MAX = Math.Sqrt(3);
        private double getDefference(Color src, Color dst)
        {
            double rd = src.R - dst.R;
            double gd = src.G - dst.G;
            double bd = src.B - dst.B;

            double deff = Math.Sqrt(rd * rd + gd * gd + bd * bd) / MAX;
            return deff;

        }
        private int getMin(Color src)
        {
            double[] dArray = new double[16];
            //Common.DEBUG_PRINT("Src R:" + src.R + " G:" + src.G + " B:" + src.B);
            for (int i = 0; i < 16; i++)
            {
                //Common.DEBUG_PRINT("i=" + i + " R:" + colorArray[i].R + " G:" + colorArray[i].G + " B:" + colorArray[i].B);
                dArray[i] = getDefference(src , colorArray[i]);
                //Common.DEBUG_PRINT("Deff:" + dArray[i]);
                //Common.DEBUG_PRINT("");
            }

            int min = 0;
            for (int i=1; i < 16; i++)
            {
                if(dArray[min] > dArray[i])
                {
                    min = i;
                }
            }
            //Common.DEBUG_PRINT("Min:" + min);
            //Common.DEBUG_PRINT("");
            return min;
        }

        public void doColorConvert()
        {
            int bmpWidth  = img.Width;
            int bmpHeight = img.Height;
            int min = -1;
            for (int hCount=0; hCount < bmpHeight; hCount++)
            {
                for (int wCount=0; wCount < bmpWidth; wCount++)
                {
                    //Common.DEBUG_PRINT("H: " + hCount + "W:" + wCount);
                    min = getMin(img.GetPixel(wCount, hCount));
                    img.SetPixel(wCount, hCount, colorArray[min]);
                }
            }
            Common.DEBUG_PRINT("Color Convert finished");
        }
        public Bitmap getBitmap()
        {
            return img;
        }
        public void saveBitmap()
        {
            img.Save("img.bmp", System.Drawing.Imaging.ImageFormat.Bmp);
        }
    }
}
