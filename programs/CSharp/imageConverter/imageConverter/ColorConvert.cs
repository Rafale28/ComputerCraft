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
        private List<Bitmap> img;
        private List<ImageStr> imgStr;
        //private List<Color> colorList;
        public ColorConvert(List<ImageStr> srcStr)
        {
            imgStr = srcStr;
            //colorList = new List<Color>();
        }

        public struct ImageStr
        {
            private String fileName;
            private Bitmap bitmap;
            private List<Color> colorList;
            public void setImage(String fn, Bitmap bmp)
            {
                fileName = fn;
                bitmap = bmp;
                colorList = new List<Color>();
            }

            public String getFileName()
            {
                return fileName;
            }
            public Bitmap getBitmap()
            {
                return bitmap;
            }
            public List<Color> getColorList()
            {
                return colorList;
            }
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

        public static String[] colorString = { 
            "white",
            "orange",
            "magenta",
            "lightBlue",
            "yellow",
            "lime",
            "pink",
            "gray",
            "lightGray",
            "cyan",
            "purple",
            "blue",
            "brown",
            "green",
            "red",
            "black"
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

        private void showColor(Color c)
        {
            Common.DEBUG_PRINT("COLOR R:" + c.R + " G:" + c.G + " B:" + c.B);
        }
        public void checkPalette()
        {
            Bitmap i = imgStr[0].getBitmap();
            int bmpWidth = i.Width;
            int bmpHeight = i.Height;
            Common.DEBUG_PRINT("showColor");
            for (int hCount = 0; hCount < bmpHeight; hCount++)
            {
                for (int wCount = 0; wCount < bmpWidth; wCount++)
                {
                    if (imgStr[0].getColorList().Count < 1)
                    {
                        imgStr[0].getColorList().Add(i.GetPixel(wCount, hCount));
                        //colorList.Add(i.GetPixel(wCount, hCount));
                        showColor(i.GetPixel(wCount, hCount));
                    }
                    else
                    {
                        //foreach(Color c in colorList)
                        bool flag = false;
                        for(int cnt=0; cnt < imgStr[0].getColorList().Count; cnt++)
                        {
                            if (i.GetPixel(wCount, hCount).R == imgStr[0].getColorList()[cnt].R &&
                                i.GetPixel(wCount, hCount).G == imgStr[0].getColorList()[cnt].G &&
                                i.GetPixel(wCount, hCount).B == imgStr[0].getColorList()[cnt].B)
                            {
                                flag = true;
                            }
                        }
                        if(!flag)
                        {
                            imgStr[0].getColorList().Add(i.GetPixel(wCount, hCount));
                            showColor(i.GetPixel(wCount, hCount));

                        }
                    }
                }
            }
            Common.DEBUG_PRINT("List Count:" + imgStr[0].getColorList().Count);
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
            foreach (ImageStr s in imgStr)
            {
                Bitmap i = s.getBitmap();
                int bmpWidth = i.Width;
                int bmpHeight = i.Height;
                int min = -1;
                for (int hCount = 0; hCount < bmpHeight; hCount++)
                {
                    for (int wCount = 0; wCount < bmpWidth; wCount++)
                    {
                        //透明の時
                        if (i.GetPixel(wCount, hCount).A == 0)
                        {
                            i.SetPixel(wCount, hCount, Color.FromArgb(0, 0, 0, 0));
                        }
                        else 
                        { 
                            //Common.DEBUG_PRINT("H: " + hCount + "W:" + wCount);
                            min = getMin(i.GetPixel(wCount, hCount));
                            i.SetPixel(wCount, hCount, colorArray[min]);
                        }
                    }
                }
            }
            Common.DEBUG_PRINT("Color Convert finished");
        }
        public List<Bitmap> getBitmap()
        {
            return img;
        }
        public void saveBitmap()
        {
            foreach (ImageStr s in imgStr)
            {
                Common.DEBUG_PRINT("Save File");
                s.getBitmap().Save( s.getFileName() + ".bmp", System.Drawing.Imaging.ImageFormat.Bmp);
            }
        }
    }
}
