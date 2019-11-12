normalizestart = 1;
normalizeend = 243;
maxheight = 0;
maxwidth = 0;
// Decomment code for new dataset, for current dataset, Nissle Histology Sections, maxwidth and maxheight are known to be 11392 and 7744, respectively.
/*
for( i = normalizestart; i < normalizeend; i++)
{
	imagepath = "/Volumes/CivmUsers/ope/Desktop/Nissl Scans/100140665_" + i + ".jpg";
	if( File.exists(imagepath))
	{
		open(imagepath);		
		if(maxwidth < getWidth())
		{
			maxwidth = getWidth();
		}

		if(maxheight < getHeight())
		{
			maxheight = getHeight();
		}
		close();
	}	

}
*/

maxwidth = 11392;
maxheight = 7744;

start = 1;//for next time
end = 243; //max of 243
//For continuous indexing of the scans given discontinuous scans.
normalizeindex = start;
for( i = start; i < end; i++)
{
	imagepath = "/Volumes/CivmUsers/ope/Desktop/Nissl Scans/100140665_" + i + ".jpg";
	if( File.exists(imagepath))
	{
		open(imagepath);
		run("16-bit");
		// A better way of getting the background value, assuming it is the most common pixel value. Requires version 1.52p.
		//background = getValue("Mode");
		background = getPixel(10,10);
		run("Macro...", "code=v=" + background + "-v");
		setBackgroundColor(0,0,0);
		imagepath = "/Volumes/CivmUsers/ope/Desktop/Nissl Scans/100140665_" + i + ".jpg";
		yoffset = 0;
		xoffset = 0;
		run("Canvas Size...", "width=" + maxwidth + " height=" + maxheight + " position=Top-Left");
		//run("Properties...", "channels=1 slices=1 frames=1 unit=µm pixel_width=10.0000 pixel_height=10.0000 voxel_depth=1.0000");

		//Run the following to shrink the images.

		compressedWidth = maxwidth/8;
		compressedHeight = maxheight/8;
		run("Scale...", "x=- y=- width=" + compressedWidth+ " height=" + compressedHeight+ " interpolation=Bilinear average");
		run("Canvas Size...", "width=" + compressedWidth+ " height=" + compressedHeight+ " position=Center");
		
		//saveAs("Raw Data", "/Volumes/CivmUsers/ope/Desktop/Normalized Nissl Scans/v3/100140665_" + i + ".raw");
		saveAs("Raw Data", "/Volumes/CivmUsers/ope/Desktop/Normalized Nissl Scans/v4(compressed)/100140665_" + normalizeindex + ".raw");
		close();
		normalizeindex = normalizeindex + 1;
	}
	
}
