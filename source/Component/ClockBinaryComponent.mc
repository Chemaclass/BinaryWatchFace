using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class ClockBinaryComponent
{
    private var _binaryRenderer as BinaryRenderer;

    function initialize()
    {
        _binaryRenderer = new BinaryRenderer(6);       
    }

    public function draw(dc as Dc) as Void
    {
        var app = Application.getApp();
        var clockTime = System.getClockTime();
        var width = dc.getWidth()/2;
        var height = dc.getHeight();
        
        var font = Graphics.FONT_LARGE * 2;
        var justification = Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER;

        var shouldDisplaySeconds = app.getProperty("ShouldDisplaySeconds");
        
        dc.setColor(app.getProperty("BinaryClockColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(width, calculateHeightHour(dc), font, _binaryRenderer.fromDecimal(clockTime.hour), justification);
        dc.drawText(width, calculateHeightMin(dc), font, _binaryRenderer.fromDecimal(clockTime.min), justification);
        
        if (shouldDisplaySeconds) {
            dc.drawText(width, height/32 * 25, font, _binaryRenderer.fromDecimal(clockTime.sec), justification);
        }
        
    }
    
    private function calculateHeightHour(dc as Dc) as Int
    {
        var height = dc.getHeight();

        if (Application.getApp().getProperty("ShouldDisplaySeconds")) {
            return height/2 - 55;
        }
    
        return height/2 - 25;
    }
    
    private function calculateHeightMin(dc as Dc) as Int
    {
        var height = dc.getHeight();

        if (Application.getApp().getProperty("ShouldDisplaySeconds")) {
            return height/2;
        }
    
        return height/2 + 20;
    }
}
