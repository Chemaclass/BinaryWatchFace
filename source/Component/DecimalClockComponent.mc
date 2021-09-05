using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class DecimalClockComponent
{
    public function draw(dc as Dc) as Void
    {
        var app = Application.getApp();
    	if (!app.getProperty("ShouldDisplayDecimalTime")) { 
    	    return; 
    	}
        
        var clockTime = System.getClockTime();
        var width = dc.getWidth()/2 + 115;
        var height = dc.getHeight();
        var font = Graphics.FONT_SMALL;
        var justification = Graphics.TEXT_JUSTIFY_RIGHT;

        dc.setColor(app.getProperty("DecimalClockColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(width, height/2 - 45, font, clockTime.hour.format("%02d"), justification);
        dc.drawText(width, height/2 - 15, font, clockTime.min.format("%02d"), justification);
        dc.drawText(width, height/2 + 15, font, clockTime.sec.format("%02d"), justification);
    }
}
