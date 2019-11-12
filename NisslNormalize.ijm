normalizestart = 1;
normalizeend = 243;
maxheight = 0;
maxwidth = 0;
// Decomment code for new dataset, for current dataset maxwidth and maxheight are known to be 11392 and 7744, respectively.
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

start = 1;
end = 20; //max of 243
for( i = start; i < end; i++)
{
	imagepath = "/Volumes/CivmUsers/ope/Desktop/Nissl Scans/100140665_" + i + ".jpg";
	if( File.exists(imagepath))
	{
		open(imagepath);
		run("16-bit");
		//background = getValue("Mode");
		background = getPixel(10,10);
		run("Macro...", "code=v=" + background + "-v");
		setBackgroundColor(background);
		imagepath = "/Volumes/CivmUsers/ope/Desktop/Nissl Scans/100140665_" + i + ".jpg";
		run("Canvas Size...", "width=" + maxwidth + " height=" + maxheight + " position=Center");
		//run("Properties...", "channels=1 slices=1 frames=1 unit=µm pixel_width=10.0000 pixel_height=10.0000 voxel_depth=1.0000");
		saveAs("Raw Data", "/Volumes/CivmUsers/ope/Desktop/Normalized Nissl Scans/v3/100140665_" + i + ".raw");
		close();
	}
	
}
