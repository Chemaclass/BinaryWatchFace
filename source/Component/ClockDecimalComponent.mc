using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class ClockDecimalComponent
{
    public function draw(dc as Dc) as Void
    {
        var app = Application.getApp();
        if (!app.getProperty("ShouldDisplayDecimalTime")) {
            return; 
        }

        var shouldDisplaySeconds = app.getProperty("ShouldDisplaySeconds");
        
        var clockTime = System.getClockTime();
        var width = dc.getWidth()/2 + 115;
        var height = dc.getHeight();
        var font = Graphics.FONT_SMALL;
        var justification = Graphics.TEXT_JUSTIFY_RIGHT;

        dc.setColor(app.getProperty("DecimalClockColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(width, calculateHeightHour(dc), font, clockTime.hour.format("%02d"), justification);
        dc.drawText(width, calculateHeightMin(dc), font, clockTime.min.format("%02d"), justification);

        if (shouldDisplaySeconds) {
            dc.drawText(width, height/2 + 15, font, clockTime.sec.format("%02d"), justification);
        }
    }

    private function calculateHeightHour(dc as Dc) as Int
    {
        var height = dc.getHeight();

        if (Application.getApp().getProperty("ShouldDisplaySeconds")) {
            return height/2 - 45;
        }
    
        return height/2 - 30;
    }
    
    private function calculateHeightMin(dc as Dc) as Int
    {
        var height = dc.getHeight();

        if (Application.getApp().getProperty("ShouldDisplaySeconds")) {
            return height/2 - 15;
        }
    
        return height/2;
    }
}
